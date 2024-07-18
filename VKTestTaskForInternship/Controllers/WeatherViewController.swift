//
//  WeatherViewController.swift
//  VKTestTaskForInternship
//
//  Created by Mukaram Gaitova on 18.07.2024.
//

import UIKit

class WeatherViewController: UIViewController {
    
    private let weatherTypes = WeatherType.allCases
    private let collectionView: UICollectionView
    private var weatherView: WeatherView?
    private let toggleButton = UIButton()
    private var selectedIndexPath: IndexPath?
    private var isDay = true {
        didSet {
            updateBackground()
            updateToggleButtonImage()
            updateWeatherView()
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateBackground()
        setupCollectionView()
        setupToggleButton()
        
        let randomIndex = Int.random(in: 0..<weatherTypes.count)
        selectedIndexPath = IndexPath(item: randomIndex, section: 0)
        presentWeather(for: weatherTypes[randomIndex])
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
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
            toggleButton.heightAnchor.constraint(equalToConstant: 50)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let weatherType = weatherTypes[indexPath.item]
        let imageView = createImageView(for: weatherType, isSelected: indexPath == selectedIndexPath)
        let label = createLabel(for: weatherType, isSelected: indexPath == selectedIndexPath)
        
        cell.contentView.addSubview(imageView)
        cell.contentView.addSubview(label)
        
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
        selectedIndexPath = indexPath
        collectionView.reloadData()
        presentWeather(for: weatherTypes[indexPath.item])
    }
    
    private func createImageView(for weatherType: WeatherType, isSelected: Bool) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: weatherType.iconName)
        imageView.tintColor = isSelected ? .systemBlue : .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    private func createLabel(for weatherType: WeatherType, isSelected: Bool) -> UILabel {
        let label = UILabel()
        label.text = weatherType.localizedString
        label.textAlignment = .center
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = isSelected ? .systemBlue : .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

