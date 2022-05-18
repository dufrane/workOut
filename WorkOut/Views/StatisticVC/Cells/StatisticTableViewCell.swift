//
//  StatisticViewCell.swift
//  WorkOut
//
//  Created by d vasylenko on 11.04.2022.
//

import UIKit

class StatisticTableViewCell: UITableViewCell {

    private let statisticNameLable: UILabel = {
        let lable = UILabel(text: "", font: .robotoMedium24(), fontColor: .specialBlack)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let beforeRepsLable: UILabel = {
        let lable = UILabel(text: "", font: .robotoMedium14(), fontColor: .specialBrown)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let afterRepsLable: UILabel = {
        let lable = UILabel(text: "", font: .robotoMedium14(), fontColor: .specialBrown)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let progressNameLable: UILabel = {
        let lable = UILabel(text: "", font: .robotoMedium24(), fontColor: .specialGreen)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .specialGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var statisticLablesStackView = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .specialBackground
        selectionStyle = .none
        addSubview(statisticNameLable)
        statisticLablesStackView = UIStackView(arrangedSubviews: [beforeRepsLable, afterRepsLable], axis: .horizontal,
                                               spacing: 10)
        addSubview(statisticLablesStackView)
        addSubview(progressNameLable)
        addSubview(bottomLineView)
    }
    
    func cellConfigure(differenceWorkout: DifferenceWorkout) {
        
        statisticNameLable.text = differenceWorkout.name
        beforeRepsLable.text = "Before: \(differenceWorkout.firstReps)"
        afterRepsLable.text = "Now: \(differenceWorkout.lastReps)"
        
        let difference = differenceWorkout.lastReps - differenceWorkout.firstReps
        progressNameLable.text = "\(difference)"
        
        switch difference {
        case ..<0: progressNameLable.textColor = .specialGreen
        case 1...: progressNameLable.textColor = .specialDarkYellow
        default: progressNameLable.textColor = .specialGray
        }
    }
}

extension StatisticTableViewCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            statisticNameLable.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            statisticNameLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
        NSLayoutConstraint.activate([
            statisticLablesStackView.topAnchor.constraint(equalTo: statisticNameLable.bottomAnchor, constant: -2),
            statisticLablesStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            statisticLablesStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2)
        ])
        NSLayoutConstraint.activate([
            progressNameLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            progressNameLable.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        NSLayoutConstraint.activate([
            bottomLineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            bottomLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            bottomLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            bottomLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
