//
//  RepsOrTimerView.swift
//  WorkOut
//
//  Created by d vasylenko on 16.04.2022.
//

import UIKit

class RepsOrTimerView: UIView {
    
    private let setsLable = UILabel(text: "Sets", font: .robotoMedium18(), fontColor: .specialGray)
    private let numberOfSetsLable = UILabel(text: "0", font: .robotoMedium24(), fontColor: .specialGray)
   
    private lazy var setsSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 10
        slider.maximumTrackTintColor = .specialBrown
        slider.minimumTrackTintColor = .specialGreen
        slider.addTarget(self, action: #selector(changeSetsSlider), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private let chooseRepsOrTimerLable = UILabel(text: "Choose repeat ot timer")
    private let repsLable = UILabel(text: "Reps", font: .robotoMedium18(), fontColor: .specialGray)
    private let numberOfRepsLable = UILabel(text: "0", font: .robotoMedium24(), fontColor: .specialGray)
    
    private lazy var repsSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.maximumTrackTintColor = .specialBrown
        slider.minimumTrackTintColor = .specialGreen
        slider.addTarget(self, action: #selector(changeRepsSlider), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private let timerLable = UILabel(text: "Timer", font: .robotoMedium18(), fontColor: .specialGray)
    private let timerIndicatorLable = UILabel(text: "0 min", font: .robotoMedium24(), fontColor: .specialGray)
    
    private lazy var timerSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1000
        slider.maximumTrackTintColor = .specialBrown
        slider.minimumTrackTintColor = .specialGreen
        slider.addTarget(self, action: #selector(changeTimeSlider), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private var setsStackView = UIStackView()
    private var repsStackView = UIStackView()
    private var timerStackView = UIStackView()
    
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
        translatesAutoresizingMaskIntoConstraints = false
        setsStackView = UIStackView(arrangedSubviews: [setsLable, numberOfSetsLable],
                                    axis: .horizontal, spacing: 10)
        addSubview(setsStackView)
        addSubview(setsSlider)
        addSubview(chooseRepsOrTimerLable)
        repsStackView = UIStackView(arrangedSubviews: [repsLable, numberOfRepsLable],
                                    axis: .horizontal, spacing: 10)
        addSubview(repsStackView)
        addSubview(repsSlider)
        timerStackView = UIStackView(arrangedSubviews: [timerLable, timerIndicatorLable],
                                     axis: .horizontal, spacing: 10)
        addSubview(timerStackView)
        addSubview(timerSlider)
    }
    
    @objc private func changeSetsSlider() {
        numberOfSetsLable.text = "\(Int(setsSlider.value))"
    }
    
    @objc private func changeRepsSlider() {
        numberOfRepsLable.text = "\(Int(repsSlider.value))"
        setUnactive(lable: timerLable, numberLable: timerIndicatorLable, slider: timerSlider)
        setActive(lable: repsLable, numberLable: numberOfRepsLable, slider: repsSlider)
    }
    
    @objc private func changeTimeSlider() {
        let (min, sec) = { (secs: Int) -> (Int, Int) in
            return (secs/60, secs % 60 )}(Int(timerSlider.value))
        
        timerIndicatorLable.text = (sec != 0 ? "\(min) min \(sec) sec" : "\(min) min")
        
        setUnactive(lable: repsLable, numberLable: numberOfRepsLable, slider: repsSlider)
        setActive(lable: timerLable, numberLable: timerIndicatorLable, slider: timerSlider)
    }
    
    private func setUnactive(lable: UILabel, numberLable: UILabel, slider: UISlider) {
        lable.alpha = 0.5
        numberLable.alpha = 0.5
        numberLable.text = "0"
        slider.alpha = 0.5
        slider.value = 0
    }
    
    private func setActive(lable: UILabel, numberLable: UILabel, slider: UISlider) {
        lable.alpha = 1
        numberLable.alpha = 1
        slider.alpha = 1
    }
    
    private func getSliderValue() -> (Int, Int, Int) {
        let setsSliderValue = Int(setsSlider.value)
        let repsSliderValue = Int(repsSlider.value)
        let timerSliderValue = Int(timerSlider.value)
        return (setsSliderValue, repsSliderValue, timerSliderValue)
    }
    
    private func refreshWorkoutObjects() {
        numberOfSetsLable.text = "0"
        repsSlider.value = 0
        numberOfRepsLable.text = "0"
        setsSlider.value = 0
        timerIndicatorLable.text = "0"
        timerSlider.value = 0
    }
    
    public func refreshLablesAndSliders() {
        refreshWorkoutObjects()
    }
    
    public func setSliderValue() -> (Int, Int, Int) {
        getSliderValue()
    }
    
}
extension RepsOrTimerView {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            setsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            setsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            setsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        NSLayoutConstraint.activate([
            setsSlider.topAnchor.constraint(equalTo: setsStackView.bottomAnchor, constant: 10),
            setsSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            setsSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        NSLayoutConstraint.activate([
            chooseRepsOrTimerLable.topAnchor.constraint(equalTo: setsSlider.bottomAnchor, constant: 15),
            chooseRepsOrTimerLable.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            repsStackView.topAnchor.constraint(equalTo: chooseRepsOrTimerLable.bottomAnchor, constant: 20),
            repsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            repsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        NSLayoutConstraint.activate([
            repsSlider.topAnchor.constraint(equalTo: repsStackView.bottomAnchor, constant: 10),
            repsSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            repsSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        NSLayoutConstraint.activate([
            timerStackView.topAnchor.constraint(equalTo: repsSlider.bottomAnchor, constant: 20),
            timerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            timerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        NSLayoutConstraint.activate([
            timerSlider.topAnchor.constraint(equalTo: timerStackView.bottomAnchor, constant: 10),
            timerSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            timerSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
}
