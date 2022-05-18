//
//  NewWorkoutViewController.swift
//  WorkOut
//
//  Created by d vasylenko on 14.04.2022.
//

import UIKit

class NewWorkoutViewController: UIViewController {
    private let newWorkoutLable: UILabel = {
        let lable = UILabel(text: "NEW WORKOUT", font: .robotoMedium24(), fontColor: .specialDarkGreen)
        lable.adjustsFontSizeToFitWidth = true
        lable.minimumScaleFactor = 0.5
        lable.numberOfLines = 2
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "closeButton"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nameLable = UILabel(text: "Name")
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .specialLightBrown
        textField.layer.cornerRadius = 10
        textField.textColor = .specialGray
        textField.font = .robotoBold20()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15,
                                                  height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clearButtonMode = .always
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialGreen
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.setTitle("SAVE", for: .normal)
        button.titleLabel?.font = .robotoBold16()
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let dateAndRepeatLabel = UILabel(text: "Date and repeat")
    private let repsOrTimerLabel = UILabel(text: "Reps or timer")
    private let dateAndRepeatView = DateAndRepeatView()
    private let repsOrTimerView = RepsOrTimerView()
    private var workoutModel = WorkoutModel()
    private let testImage = UIImage(named: "testWorkout")
    
    override func viewDidLayoutSubviews() {
        closeButton.layer.cornerRadius = closeButton.frame.width / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTaps()
        setDelegates()
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        view.addSubview(newWorkoutLable)
        view.addSubview(closeButton)
        view.addSubview(nameLable)
        view.addSubview(nameTextField)
        view.addSubview(dateAndRepeatLabel)
        view.addSubview(dateAndRepeatView)
        view.addSubview(repsOrTimerLabel)
        view.addSubview(repsOrTimerView)
        view.addSubview(saveButton)
    }
    
    private func setDelegates() {
        nameTextField.delegate = self
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func saveButtonTapped() {
        setModel()
        saveModel()
    }
    
    private func setModel() {
        guard let nameWorkout = nameTextField.text else {  return }
        workoutModel.workoutName = nameWorkout
        let dateFromPicker = dateAndRepeatView.setDateAndRepeat().0
        workoutModel.workoutDate = dateFromPicker.localDate()
        workoutModel.workoutNumberOfDay = dateFromPicker.getWeekDayNumber()
        workoutModel.workoutRepeat = dateAndRepeatView.setDateAndRepeat().1
        workoutModel.workoutSets = repsOrTimerView.setSliderValue().0
        workoutModel.workoutReps = repsOrTimerView.setSliderValue().1
        workoutModel.workoutTimer = repsOrTimerView.setSliderValue().2
        guard let imageData = testImage?.pngData() else { return }
        workoutModel.workoutImage = imageData
    }
    
    private func saveModel() {
        guard let text = nameTextField.text else { return }
        let count = text.filter { $0.isLetter || $0.isNumber }.count
        
        if count != 0 && workoutModel.workoutSets != 0
            && (workoutModel.workoutReps != 0 || workoutModel.workoutTimer != 0) {
            RealmManager.shared.saveWorkoutModel(model: workoutModel)
            workoutModel = WorkoutModel()
            alertOk(title: "Success", message: nil)
            refreshObjects()
        } else {
            alertOk(title: "Error", message: "Please enter all parameters")
        }
    }
    
    private func refreshObjects() {
        dateAndRepeatView.refreshDatePickerAndSwitch()
        repsOrTimerView.refreshLablesAndSliders()
        nameTextField.text = ""
    }
    
    private func addTaps() {
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapScreen)
        let swipeScreen = UITapGestureRecognizer(target: self, action: #selector(swipeHideKeyboard))
        swipeScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(swipeScreen)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func swipeHideKeyboard() {
        view.endEditing(true)
    }
}

extension NewWorkoutViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
    }
}

extension NewWorkoutViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            newWorkoutLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            newWorkoutLable.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            closeButton.centerYAnchor.constraint(equalTo: newWorkoutLable.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            nameLable.topAnchor.constraint(equalTo: newWorkoutLable.bottomAnchor, constant: 10),
            nameLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            nameLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameLable.bottomAnchor, constant: 3),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 38)
        ])
        NSLayoutConstraint.activate([
            dateAndRepeatLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            dateAndRepeatLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            dateAndRepeatLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            dateAndRepeatView.topAnchor.constraint(equalTo: dateAndRepeatLabel.bottomAnchor, constant: 3),
            dateAndRepeatView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateAndRepeatView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dateAndRepeatView.heightAnchor.constraint(equalToConstant: 94)
        ])
        NSLayoutConstraint.activate([
            repsOrTimerLabel.topAnchor.constraint(equalTo: dateAndRepeatView.bottomAnchor, constant: 20),
            repsOrTimerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            repsOrTimerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            repsOrTimerView.topAnchor.constraint(equalTo: repsOrTimerLabel.bottomAnchor, constant: 3),
            repsOrTimerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            repsOrTimerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            repsOrTimerView.heightAnchor.constraint(equalToConstant: 320)
        ])
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: repsOrTimerView.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
}
