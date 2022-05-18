//
//  StatisticsViewController.swift
//  WorkOut
//
//  Created by d vasylenko on 11.04.2022.
//

import UIKit
import RealmSwift

struct DifferenceWorkout {
    let name: String
    let lastReps: Int
    let firstReps: Int
}

class StatisticViewController: UIViewController {
    
    private let statisticLable: UILabel = {
        
        let lable = UILabel(text: "STATISTICS", font: .robotoBold24(), fontColor: .specialDarkGreen)
        lable.adjustsFontSizeToFitWidth = true
        lable.minimumScaleFactor = 0.5
        lable.numberOfLines = 2
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Week", "Month"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .specialGreen
        segmentedControl.selectedSegmentTintColor = .specialYellow
        let font = UIFont(name: "Roboto-Medium", size: 16)
        segmentedControl.setTitleTextAttributes([.font: font as Any,
                                                 .foregroundColor: UIColor.white], for: .normal)
        segmentedControl.setTitleTextAttributes([.font: font as Any,
                                                 .foregroundColor: UIColor.specialGray], for: .selected)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(segmentedChange), for: .valueChanged)
        return segmentedControl
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
    
    private let statisticExercisesLable: UILabel = {
        let lable = UILabel()
        lable.text = "Exercises"
        lable.adjustsFontSizeToFitWidth = true
        lable.minimumScaleFactor = 0.5
        lable.numberOfLines = 2
        lable.font = .robotoMedium14()
        lable.textColor = .specialBrown
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let idStatisticTableviewCell = "idStatisticTableviewCell"
    
    private let localRealm = try! Realm()
    private var workoutArray: Results<WorkoutModel>!
    
    private var differenceArray = [DifferenceWorkout]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        differenceArray = [DifferenceWorkout]()
        setStartScreen()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setDelegates()
        setStartScreen()
    }
    
    private func setupViews() {
        view.backgroundColor = .specialBackground
        view.addSubview(statisticLable)
        view.addSubview(segmentedControl)
        view.addSubview(statisticExercisesLable)
        view.addSubview(tableView)
        tableView.register(StatisticTableViewCell.self, forCellReuseIdentifier: idStatisticTableviewCell)
    }
    
    private func setDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc private func segmentedChange() {
        
        let dateToday = Date().localDate()
        differenceArray = [DifferenceWorkout]()
        
        if segmentedControl.selectedSegmentIndex == 0 {
            let dateStart = dateToday.offsetDays(days: 7)
            getDifferenceModel(dateStart: dateStart)
        } else {
            let dateStart = dateToday.offsetMonth(month: 1)
            getDifferenceModel(dateStart: dateStart)
        }
        tableView.reloadData()
    }
    
    private func getWorkoutsNames() -> [String] {
        
        var nameArray = [String]()
        workoutArray = localRealm.objects(WorkoutModel.self)
        
        for workoutModel in workoutArray {
            if !nameArray.contains(workoutModel.workoutName) {
                nameArray.append(workoutModel.workoutName)
            }
        }
        return nameArray
    }
    
    private func getDifferenceModel(dateStart: Date) {
        
        let dateEnd = Date().localDate()
        let namesArray = getWorkoutsNames()
        
        for name in namesArray {
            
            let predicateDifference = NSPredicate(format: "workoutName = '\(name)'AND workoutDate BETWEEN %@", [dateStart, dateEnd])
            workoutArray = localRealm.objects(WorkoutModel.self).filter(predicateDifference).sorted(byKeyPath: "workoutDate")
            
            guard let last = workoutArray.last?.workoutReps,
                  let first = workoutArray.first?.workoutReps else {
                return
            }
            let differenceWorkout = DifferenceWorkout(name: name, lastReps: last, firstReps: first)
            differenceArray.append(differenceWorkout)
        }
    }
    
    private func setStartScreen() {
        let dateToday = Date().localDate()
        getDifferenceModel(dateStart: dateToday.offsetDays(days: 6))
        tableView.reloadData()
    }
}
extension StatisticViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        differenceArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idStatisticTableviewCell, for: indexPath) as?
                StatisticTableViewCell else {
            return UITableViewCell()
        }
        let differenceModel = differenceArray[indexPath.row]
        cell.cellConfigure(differenceWorkout: differenceModel)
        return cell
    }
}

extension StatisticViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        64
    }
}

extension StatisticViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            statisticLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            statisticLable.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: statisticLable.bottomAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            statisticExercisesLable.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            statisticExercisesLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statisticExercisesLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: statisticExercisesLable.bottomAnchor, constant: 2),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
