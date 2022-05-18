//
//  StartWorkoutRepsView.swift
//  WorkOut
//
//  Created by d vasylenko on 17.04.2022.
//

import UIKit

class StartWorkoutRepsView: UIView {
    private let workoutLable = UILabel(text: "Biceps", font: .robotoMedium24(), fontColor: .specialGray)
    private let setsLable = UILabel(text: "Sets", font: .robotoMedium18(), fontColor: .specialGray)
    private let numberOfSetsLable = UILabel(text: "1/4", font: .robotoMedium24(), fontColor: .specialGray)
    private let bottomSetsLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBrown
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let repsLable = UILabel(text: "Reps", font: .robotoMedium18(), fontColor: .specialGray)
    private let numberOfRepsLable = UILabel(text: "20", font: .robotoMedium24(), fontColor: .specialGray)
    private let bottomRepsLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialBrown
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var setsStackView = UIStackView()
    private var repsStackView = UIStackView()
    
    private lazy var editingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Editing", for: .normal)
        button.tintColor = .specialBrown
        button.titleLabel?.font = .robotoMedium16()
        button.setImage(UIImage(named: "pencil"), for: .normal)
        button.addTarget(self, action: #selector(editingTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nextSetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT SET", for: .normal)
        button.tintColor = .specialDarkGreen
        button.titleLabel?.font = .robotoMedium16()
        button.backgroundColor = .specialYellow
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(nextSetTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .specialLightBrown
        layer.cornerRadius = 10
    
        addSubview(workoutLable)
        setsStackView = UIStackView(arrangedSubviews: [setsLable, numberOfSetsLable],
                                    axis: .horizontal, spacing: 10)
        addSubview(setsStackView)
        addSubview(bottomSetsLineView)
        repsStackView = UIStackView(arrangedSubviews: [repsLable, numberOfRepsLable],
                                    axis: .horizontal, spacing: 10)
        addSubview(repsStackView)
        addSubview(bottomRepsLineView)
        addSubview(editingButton)
        addSubview(nextSetButton)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func editingTapped() {
        print("finishTapped")
    }
    @objc private func nextSetTapped() {
        print("nextSetTapped")
    }
}
extension StartWorkoutRepsView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            workoutLable.topAnchor.constraint(equalTo: topAnchor, constant: 14),
            workoutLable.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            setsStackView.topAnchor.constraint(equalTo: workoutLable.bottomAnchor, constant: 10),
            setsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            setsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        NSLayoutConstraint.activate([
            bottomSetsLineView.topAnchor.constraint(equalTo: setsStackView.bottomAnchor, constant: 3),
            bottomSetsLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            bottomSetsLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            bottomSetsLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        NSLayoutConstraint.activate([
            repsStackView.topAnchor.constraint(equalTo: bottomSetsLineView.bottomAnchor, constant: 15),
            repsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            repsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        NSLayoutConstraint.activate([
            bottomRepsLineView.topAnchor.constraint(equalTo: repsStackView.bottomAnchor, constant: 3),
            bottomRepsLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            bottomRepsLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            bottomRepsLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        NSLayoutConstraint.activate([
            editingButton.topAnchor.constraint(equalTo: bottomRepsLineView.bottomAnchor, constant: 15),
            editingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
//            editingButton.heightAnchor.constraint(equalToConstant: 1)
        ])
        NSLayoutConstraint.activate([
            nextSetButton.topAnchor.constraint(equalTo: editingButton.bottomAnchor, constant: 12),
            nextSetButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            nextSetButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            nextSetButton.heightAnchor.constraint(equalToConstant: 43)
        ])
    }
}

