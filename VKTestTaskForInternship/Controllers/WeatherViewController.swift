//
//  WeatherViewController.swift
//  VKTestTaskForInternship
//
//  Created by Mukaram Gaitova on 18.07.2024.
//

import UIKit

class WeatherViewController: UIViewController {
    
    private let weatherTypes = WeatherType.allCases
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    private var weatherView: WeatherView?
    private let toggleButton = UIButton()
    private var selectedIndexPath: IndexPath?
    private let selectedCellColor = UIColor(red: 36.0/255.0, green: 24.0/255.0, blue: 56.0/255.0, alpha: 1.0)
    private var isDay = true {
        didSet {
            updateBackground()
            updateToggleButtonImage()
            updateWeatherView()
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateBackground()
        setupCollectionView()
        setupToggleButton()
        randomPresentWeather()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "WeatherCell")
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupToggleButton() {
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        toggleButton.addTarget(self, action: #selector(toggleButtonTapped(_:)), for: .touchUpInside)
        updateToggleButtonImage()
        view.addSubview(toggleButton)
        
        NSLayoutConstraint.activate([
            toggleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toggleButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            toggleButton.widthAnchor.constraint(equalToConstant: 100),
            toggleButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    private func updateToggleButtonImage() {
        UIView.transition(with: toggleButton, duration: 0.1, options: .transitionCrossDissolve, animations: {
            let image = self.isDay ? UIImage(named: "moon") : UIImage(named: "sun")
            self.toggleButton.setImage(image, for: .normal)
        }, completion: nil)
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
        
        if let existingBackgroundView = view.subviews.first(where: { $0 is UIImageView }) {
            existingBackgroundView.removeFromSuperview()
        }
        
        view.insertSubview(backgroundImageView, at: 0)
    }
    
    private func randomPresentWeather() {
        let randomIndex = Int.random(in: 0..<weatherTypes.count)
        selectedIndexPath = IndexPath(item: randomIndex, section: 0)
        presentWeather(for: weatherTypes[randomIndex])
        collectionView.reloadData()
    }
    
    private func updateWeatherView() {
        if let currentWeatherType = weatherView?.weatherType {
            presentWeather(for: currentWeatherType)
        }
    }
    
    private func presentWeather(for weatherType: WeatherType) {
        weatherView?.removeFromSuperview()
        weatherView = WeatherView(frame: view.bounds, weatherType: weatherType, isDay: isDay)
        if let weatherView = weatherView {
            view.insertSubview(weatherView, belowSubview: collectionView)
        }
        
        UIView.transition(with: view, duration: 1.0, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCell", for: indexPath) as! WeatherCollectionViewCell
        let weatherType = weatherTypes[indexPath.item]
        cell.configure(with: weatherType, isSelected: indexPath == selectedIndexPath, selectedColor: selectedCellColor)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        collectionView.reloadData()
        presentWeather(for: weatherTypes[indexPath.item])
    }
}
