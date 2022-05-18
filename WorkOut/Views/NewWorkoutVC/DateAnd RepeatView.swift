//
//  DateAndRepeatView.swift
//  WorkOut
//
//  Created by d vasylenko on 16.04.2022.
//

import UIKit

class DateAndRepeatView: UIView {
    
    private let dateLable = UILabel(text: "Date", font: .robotoMedium18(), fontColor: .specialGray)
    
    private let repeatLable = UILabel(text: "Repeat every 7 days", font: .robotoMedium18(), fontColor: .specialGray)
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.tintColor = .specialGreen
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        print(datePicker)
        return datePicker
    }()
    
    private let repeatSwitch: UISwitch = {
        let testSwitch = UISwitch()
        testSwitch.isOn = true
        testSwitch.onTintColor = .specialGreen
        //        testSwitch.thumbTintColor = .specialYellow
        testSwitch.translatesAutoresizingMaskIntoConstraints = false
        return testSwitch
    }()
    
    private var dateStackView = UIStackView()
    private var repeatStackView = UIStackView()
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
        datePicker.subviews[0].subviews[0].subviews[0].alpha = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .specialLightBrown
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        dateStackView = UIStackView(arrangedSubviews: [dateLable, datePicker],
                                    axis: .horizontal, spacing: 10)
        addSubview(dateStackView)
        repeatStackView = UIStackView(arrangedSubviews: [repeatLable, repeatSwitch],
                                      axis: .horizontal, spacing: 10)
        addSubview(repeatStackView)
    }
    
    private func getDateAndRepeat() -> (Date, Bool) {
        (datePicker.date, repeatSwitch.isOn)
    }
    
    private func refreshWorkoutObjects() {
        datePicker.setDate(Date(), animated: true)
        repeatSwitch.isOn = true
    }
    
    public func refreshDatePickerAndSwitch() {
        refreshWorkoutObjects()
    }
    
    public func setDateAndRepeat() ->(Date, Bool) {
        getDateAndRepeat()
    }
}
extension DateAndRepeatView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            dateStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            dateStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            dateStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        NSLayoutConstraint.activate([
            repeatStackView.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 10),
            repeatStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            repeatStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
}
