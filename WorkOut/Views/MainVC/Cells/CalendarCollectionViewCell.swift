//
//  CalendarCollectionViewCell.swift
//  WorkOut
//
//  Created by d vasylenko on 08.04.2022.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {

    let dayOfWeekLable: UILabel = {
        let lable = UILabel(text: "WE", font: .robotoBold16(), fontColor: .white)
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    let numberOfDayLable: UILabel = {
        let lable = UILabel(text: "07", font: .robotoBold20(), fontColor: .white)
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                backgroundColor = .specialYellow
                layer.cornerRadius = 10
                dayOfWeekLable.textColor = .specialBlack
                numberOfDayLable.textColor = .specialDarkGreen
            } else {
                backgroundColor = .specialGreen
                dayOfWeekLable.textColor = .white
                numberOfDayLable.textColor = .white
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(dayOfWeekLable)
        addSubview(numberOfDayLable)
    }
    
    private func cellConfigure(numberOfDay: String, dayOfWeek: String) {
        numberOfDayLable.text = numberOfDay
        dayOfWeekLable.text = dayOfWeek
    }
    
    public func dateForCell(numberOfDay: String, dayOfWeek: String) {
        cellConfigure(numberOfDay: numberOfDay, dayOfWeek: dayOfWeek)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dayOfWeekLable.centerXAnchor.constraint(equalTo: centerXAnchor),
            dayOfWeekLable.topAnchor.constraint(equalTo: topAnchor, constant: 7)
        ])
        NSLayoutConstraint.activate([
            numberOfDayLable.centerXAnchor.constraint(equalTo: centerXAnchor),
            numberOfDayLable.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
