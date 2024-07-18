//
//  WeatherViewController.swift
//  VKTestTaskForInternship
//
//  Created by Mukaram Gaitova on 18.07.2024.
//

import UIKit

class WeatherViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let weatherTypes = WeatherType.allCases
    private let collectionView: UICollectionView
    private var weatherView: WeatherView?
    private let toggleButton = UIButton()
    private var isDay = true {
        didSet {
            updateBackground()
            updateToggleButtonImage()
            updateWeatherView()
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        // Создание layout для коллекции
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)
        
        // Инициализация коллекции
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        // Настройка коллекции
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Настройка вью
        updateBackground()
        
        // Добавление и настройка collectionView
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        view.addSubview(collectionView)
        
        // Установка constraints для collectionView
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        // Настройка toggleButton
        setupToggleButton()
        
        // Отображение случайного погодного явления при старте
        let randomWeather = weatherTypes.randomElement()!
        presentWeather(for: randomWeather)
    }
    
    private func setupToggleButton() {
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        toggleButton.addTarget(self, action: #selector(toggleButtonTapped(_:)), for: .touchUpInside)
        updateToggleButtonImage()
        view.addSubview(toggleButton)
        
        // Установка constraints для toggleButton
        NSLayoutConstraint.activate([
            toggleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toggleButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            toggleButton.widthAnchor.constraint(equalToConstant: 50),
            toggleButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func updateToggleButtonImage() {
        let image = isDay ? UIImage(named: "moon") : UIImage(named: "sun")
        toggleButton.setImage(image, for: .normal)
    }
    
    @objc private func toggleButtonTapped(_ sender: UIButton) {
        isDay.toggle()
    }
    
    private func updateBackground() {
        let backgroundImage = isDay ? UIImage(resource: .day) : UIImage(resource: .night)
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        
        // Удаление предыдущего фона
        if let existingBackgroundView = view.subviews.first(where: { $0 is UIImageView }) {
            existingBackgroundView.removeFromSuperview()
        }
        
        // Добавление нового фона
        view.insertSubview(backgroundImageView, at: 0)
    }
    
    private func updateWeatherView() {
        if let currentWeatherType = weatherView?.weatherType {
            presentWeather(for: currentWeatherType)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        // Удаление всех подвидов из contentView, чтобы избежать наложения
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        // Настройка иконки для ячейки
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        let iconName: String
        switch weatherTypes[indexPath.item] {
        case .clear:
            iconName = "sun.max.fill"
        case .rain:
            iconName = "cloud.rain.fill"
        case .storm:
            iconName = "cloud.bolt.fill"
        case .fog:
            iconName = "cloud.fog.fill"
        case .cloudy:
            iconName = "cloud.fill"
        case .snow:
            iconName = "snowflake"
        case .wind:
            iconName = "wind"
        case .overcast:
            iconName = "cloud.sun.fill"
        case .blizzard:
            iconName = "wind.snow"
        case .rainAndSnow:
            iconName = "cloud.sleet.fill"
        }
        imageView.image = UIImage(systemName: iconName)
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(imageView)
        
        // Настройка текста для ячейки
        let label = UILabel()
        label.text = weatherTypes[indexPath.item].rawValue
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(label)
        
        // Установка constraints для иконки и текста
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            label.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -5),
            label.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -10)
        ])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedWeather = weatherTypes[indexPath.item]
        presentWeather(for: selectedWeather)
    }
    
    private func presentWeather(for weatherType: WeatherType) {
        weatherView?.removeFromSuperview()
        weatherView = WeatherView(frame: view.bounds, weatherType: weatherType, isDay: isDay)
        if let weatherView = weatherView {
            view.insertSubview(weatherView, belowSubview: collectionView)
        }
        
        // Анимация перехода
        UIView.transition(with: view, duration: 1.0, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
