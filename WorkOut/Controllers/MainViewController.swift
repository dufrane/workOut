//
//  ViewController.swift
//  WorkOut
//
//  Created by d vasylenko on 05.04.2022.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.7607843137, green: 0.7607843137, blue: 0.7607843137, alpha: 1)
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let userNameLable: UILabel = {
        let lable = UILabel(text: "Your name", font: .robotoBold24(), fontColor: .specialGray)
        lable.adjustsFontSizeToFitWidth = true
        lable.minimumScaleFactor = 0.5
        lable.numberOfLines = 2
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private lazy var addWorkoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .specialYellow
        button.layer.cornerRadius = 10
        button.setTitle("Add Workout", for: .normal)
        button.tintColor = .specialDarkGreen
        button.titleLabel?.font = .robotoMedium12()
        button.setImage(UIImage(named: "addWorkout"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0,
                                              left: 20,
                                              bottom: 15,
                                              right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 50,
                                              left: -40,
                                              bottom: 0,
                                              right: 0)
        button.addTarget(self, action: #selector(addWorkoutButtonTapped), for: .touchUpInside)
        button.addShadowOnView()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let workoutTodayLable: UILabel = {
        let lable = UILabel(text: "WorkuotToday", font: .robotoMedium14(), fontColor: .specialBrown)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable }()
    
    private let noWorkoutImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "noWorkout")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .none
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.delaysContentTouches = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let calendarView = CalendarView()
    private let wetherView = WeatherView()
    
    private let localRealm = try! Realm()
    private var workoutArray: Results<WorkoutModel>!
    
    private let idWorkourTableviewCell = "idWorkourTableviewCell"
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.width/2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getWorkouts(date: Date().localDate())
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        setDelegates()
        getWorkouts(date: Date().localDate())
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        
        view.addSubview(calendarView)
        view.addSubview(userPhotoImageView)
        view.addSubview(userNameLable)
        view.addSubview(addWorkoutButton)
        
        view.addSubview(wetherView)
        wetherView.addShadowOnView()
        
        view.addSubview(workoutTodayLable)
        
        view.addSubview(noWorkoutImageView)
        
        view.addSubview(tableView)
        tableView.register(WorkoutTableViewCell.self, forCellReuseIdentifier: idWorkourTableviewCell)
    }
    
    private func setDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
        calendarView.cellCollectionViewDelegate = self
    }
    
    @objc private func addWorkoutButtonTapped() {
        let newWorkoutViewController = NewWorkoutViewController()
        newWorkoutViewController.modalPresentationStyle = .fullScreen
        present(newWorkoutViewController, animated: true)
    }
    
    private func getWorkouts(date: Date) {
        
        let weekday = date.getWeekDayNumber()
        let dateStart = date.startEndDate().0
        let dateEnd = date.startEndDate().1
        
        let predicateRepeat = NSPredicate(format: "workoutNumberOfDay = \(weekday) AND workoutRepeat = true")
        let predicateUnrepeat = NSPredicate(format: "workoutRepeat = false AND workoutDate BETWEEN %@", [dateStart, dateEnd])
        let compound = NSCompoundPredicate(type: .or, subpredicates: [predicateRepeat, predicateUnrepeat])
        
        workoutArray = localRealm.objects(WorkoutModel.self).filter(compound).sorted(byKeyPath: "workoutName")
        
        checkWorkoutToday()
        tableView.reloadData()
    }
    
    private func checkWorkoutToday() {
        
        if workoutArray.count == 0 {
            noWorkoutImageView.isHidden = false
            tableView.isHidden = true
        } else {
            noWorkoutImageView.isHidden = true
            tableView.isHidden = false
        }
    }
}

extension MainViewController: StartWorkoutProtocol {
    
    func startButtonTapped(model: WorkoutModel) {
        
        if model.workoutTimer == 0 {
            let startWorkoutViewController = RepsWorkoutViewController()
            startWorkoutViewController.modalPresentationStyle = .fullScreen
            startWorkoutViewController.workoutModel = model
            present(startWorkoutViewController, animated: true)
        } else {
            let timerWorkoutViewController = TimerWorkoutViewController()
            timerWorkoutViewController.modalPresentationStyle = .fullScreen
            timerWorkoutViewController.workoutModel = model
            present(timerWorkoutViewController, animated: true)
        }
    }
}

extension MainViewController: SelectCollectionViewItemProtocol {
    
    func selectItem(date: Date) {
        getWorkouts(date: date)
    }
}

// MARK: UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        workoutArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idWorkourTableviewCell, for: indexPath) as? WorkoutTableViewCell else {
            return UITableViewCell()
        }
        let model = workoutArray[indexPath.row]
        cell.cellSetConfigure(model: model)
        cell.cellStartWorkoutDelegate = self
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction (style: .destructive, title: "" ) { _, _, _ in
            let deleteModel = self.workoutArray[indexPath.row]
            RealmManager.shared.deleteWorkoutModel(model: deleteModel)
            tableView.reloadData()
        }
        
        action.backgroundColor = .specialBackground
        action.image = UIImage(named: "delete")

        return UISwipeActionsConfiguration(actions: [action])
    }
}

extension MainViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            userPhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            userPhotoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 100),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: userPhotoImageView.centerYAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendarView.heightAnchor.constraint(equalToConstant: 70)
        ])
        NSLayoutConstraint.activate([
            userNameLable.bottomAnchor.constraint(equalTo: calendarView.topAnchor, constant: -10),
            userNameLable.leadingAnchor.constraint(equalTo: userPhotoImageView.trailingAnchor, constant: 5),
            userNameLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        NSLayoutConstraint.activate([
            addWorkoutButton.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 5),
            addWorkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            addWorkoutButton.widthAnchor.constraint(equalToConstant: 80),
            addWorkoutButton.heightAnchor.constraint(equalToConstant: 80)
        ])
        NSLayoutConstraint.activate([
            wetherView.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 5),
            wetherView.leadingAnchor.constraint(equalTo: addWorkoutButton.trailingAnchor, constant: 10),
            wetherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            wetherView.heightAnchor.constraint(equalToConstant: 80)
        ])
        NSLayoutConstraint.activate([
            workoutTodayLable.topAnchor.constraint(equalTo: addWorkoutButton.bottomAnchor, constant: 10),
            workoutTodayLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: workoutTodayLable.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            noWorkoutImageView.topAnchor.constraint(equalTo: workoutTodayLable.bottomAnchor, constant: 0),
            noWorkoutImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            noWorkoutImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            noWorkoutImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1)
        ])
        
    }
}
