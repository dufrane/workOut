//
//  WetherView.swift
//  WorkOut
//
//  Created by d vasylenko on 05.04.2022.
//

import UIKit

class WeatherView: UIView {
    private let wetherView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sunnyDay")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let weatherLable: UILabel = {
        let lable = UILabel(text: "Солнечно", font: .robotoMedium18(), fontColor: .specialGray)
        lable.adjustsFontSizeToFitWidth = true
        lable.minimumScaleFactor = 0.5
        lable.numberOfLines = 2
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let weatherDescriprtionLable: UILabel = {
        let lable = UILabel(text: "Хорошая погода что бы позаниматься на улице",
                            font: .robotoMedium14(), fontColor: .specialLine)
        lable.adjustsFontSizeToFitWidth = true
        lable.minimumScaleFactor = 0.5
        lable.numberOfLines = 2
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
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
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(wetherView)
        addSubview(weatherLable)
        addSubview(weatherDescriprtionLable)
    }
}

extension WeatherView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            wetherView.centerYAnchor.constraint(equalTo: centerYAnchor),
            wetherView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                 constant: -10),
            wetherView.heightAnchor.constraint(equalToConstant: 60),
            wetherView.widthAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            weatherLable.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            weatherLable.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                  constant: 10),
            weatherLable.trailingAnchor.constraint(equalTo: wetherView.leadingAnchor,
                                                   constant: -10)
        ])
        NSLayoutConstraint.activate([
            weatherDescriprtionLable.topAnchor.constraint(equalTo: weatherLable.bottomAnchor,
                                                          constant: 5),
            weatherDescriprtionLable.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                              constant: 10),
            weatherDescriprtionLable.trailingAnchor.constraint(equalTo:
                                                                wetherView.leadingAnchor,
                                                               constant: -10),
            weatherDescriprtionLable.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
