//
//  workoutTableViewCell.swift
//  WorkOut
//
//  Created by d vasylenko on 08.04.2022.
//

import UIKit

protocol StartWorkoutProtocol: AnyObject {
    func startButtonTapped(model: WorkoutModel)
}

class WorkoutTableViewCell: UITableViewCell {
    
    private let backgroundCell: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .specialLightBrown
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let workoutBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBackground
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let workoutImageView: UIImageView = {
        let imageVeiew = UIImageView()
        imageVeiew.contentMode = .scaleAspectFit
        imageVeiew.tintColor = .black
        imageVeiew.image = UIImage(named: "testWorkout")?.withRenderingMode(.alwaysTemplate)
        imageVeiew.translatesAutoresizingMaskIntoConstraints = false
        return imageVeiew
    }()
    
    private let workoutNameLable: UILabel = {
        let lable = UILabel(text: "", font: .robotoMedium22(), fontColor: .specialBlack)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let workoutRepsLable: UILabel = {
        let lable = UILabel(text: "", font: .robotoMedium16(), fontColor: .specialGray)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let workoutSetsLable: UILabel = {
        let lable = UILabel(text: "", font: .robotoMedium16(), fontColor: .specialGray)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.addShadowOnView()
        button.titleLabel?.font = .robotoBold16()
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var lablesStackView = UIStackView()
    var workoutModel = WorkoutModel()
    
    weak var cellStartWorkoutDelegate: StartWorkoutProtocol?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(backgroundCell)
        addSubview(workoutBackgroundView)
        workoutBackgroundView.addSubview(workoutImageView)
        addSubview(workoutNameLable)
        
        lablesStackView = UIStackView(arrangedSubviews: [workoutRepsLable, workoutSetsLable], axis: .horizontal,
                                      spacing: 10)
        addSubview(lablesStackView)
        contentView.addSubview(startButton)
    }
    
    @objc private func startButtonTapped() {
        cellStartWorkoutDelegate?.startButtonTapped(model: workoutModel)

    }
    
    private func cellConfigure(model: WorkoutModel) {
        
        workoutModel = model
        
        workoutNameLable.text = model.workoutName
        
        let (min, sec) = { (secs: Int) -> (Int, Int) in
            return (secs/60, secs % 60 )}(model.workoutTimer)
        
        workoutRepsLable.text = model.workoutTimer == 0 ? "Reps: \(model.workoutReps)" : "Timer: \(min) min \(sec) sec"
        workoutSetsLable.text = "Sets: \(model.workoutSets)"
        
        if model.workoutStatus {
            startButton.setTitle("COMPLETE", for: .normal)
            startButton.tintColor = .white
            startButton.backgroundColor = .specialGreen
            startButton.isEnabled = false
        } else {
            startButton.setTitle("START", for: .normal)
            startButton.tintColor = .specialDarkGreen
            startButton.backgroundColor = .specialYellow
            startButton.isEnabled = true
        }
        
        guard let imageData = model.workoutImage else { return }
        guard let image = UIImage(data: imageData) else { return }
        
        workoutImageView.image = image.withRenderingMode(.alwaysTemplate)
    }
    
    public func cellSetConfigure(model: WorkoutModel) {
        cellConfigure(model: model)
    }
}

extension WorkoutTableViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        NSLayoutConstraint.activate([
            workoutBackgroundView.centerYAnchor.constraint(equalTo: backgroundCell.centerYAnchor),
            workoutBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            workoutBackgroundView.heightAnchor.constraint(equalToConstant: 70),
            workoutBackgroundView.widthAnchor.constraint(equalToConstant: 70)
        ])
        NSLayoutConstraint.activate([
            workoutImageView.topAnchor.constraint(equalTo: workoutBackgroundView.topAnchor, constant: 10),
            workoutImageView.leadingAnchor.constraint(equalTo: workoutBackgroundView.leadingAnchor, constant: 10),
            workoutImageView.trailingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: -10),
            workoutImageView.bottomAnchor.constraint(equalTo: workoutBackgroundView.bottomAnchor, constant: -10)
        ])
        NSLayoutConstraint.activate([
            workoutNameLable.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 5),
            workoutNameLable.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: 10),
            workoutNameLable.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10)
        ])
        NSLayoutConstraint.activate([
            lablesStackView.topAnchor.constraint(equalTo: workoutNameLable.bottomAnchor, constant: 0),
            lablesStackView.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: 10),
            lablesStackView.heightAnchor.constraint(equalToConstant: 20)
        ])
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: lablesStackView.bottomAnchor, constant: 5),
            startButton.leadingAnchor.constraint(equalTo: workoutBackgroundView.trailingAnchor, constant: 10),
            startButton.trailingAnchor.constraint(equalTo: backgroundCell.trailingAnchor, constant: -10),
            startButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
