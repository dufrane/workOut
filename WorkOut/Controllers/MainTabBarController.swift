//
//  MainTabController.swift
//  WorkOut
//
//  Created by d vasylenko on 14.04.2022.
//

import Foundation

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViews()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .specialTabBar
        tabBar.tintColor = .specialDarkGreen
        tabBar.unselectedItemTintColor = .specialGray
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.specialBrown.cgColor
    }
    
    private func setupViews() {
        let mainVC = MainViewController()
        let statisticVC = StatisticViewController()
        setViewControllers([mainVC, statisticVC], animated: true)
        guard let items = tabBar.items else { return }
        items[0].title = "Main"
        items[1].title = "Statistic"
        items[0].image = UIImage(named: "mainTabBar")
        items[1].image = UIImage(named: "statisticTabBar")
        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont(name: "Roboto-Bold",
                                                                        size: 12) as Any],
                                                         for: .normal)
    }
}
