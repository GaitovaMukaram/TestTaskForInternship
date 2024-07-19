//
//  WeatherCollectionViewCell.swift
//  VKTestTaskForInternship
//
//  Created by Mukaram Gaitova on 19.07.2024.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let minImageViewSize: CGFloat = 30
        let maxImageViewSize: CGFloat = 50
        let imageViewSize = max(min(frame.width * 0.4, maxImageViewSize), minImageViewSize)

        let minLabelPadding: CGFloat = 3
        let maxLabelPadding: CGFloat = 5
        let labelVerticalPadding = max(min(frame.height * 0.02, maxLabelPadding), minLabelPadding)
        
        let minFontSize: CGFloat = 12
        let maxFontSize: CGFloat = 32
        let fontSize = max(min(frame.width * 0.05, maxFontSize), minFontSize)
        
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: imageViewSize),
            imageView.heightAnchor.constraint(equalToConstant: imageViewSize),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: labelVerticalPadding),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with weatherType: WeatherType, isSelected: Bool, selectedColor: UIColor) {
        imageView.image = UIImage(systemName: weatherType.iconName)
        imageView.tintColor = isSelected ? selectedColor : .white
        label.text = weatherType.localizedString
        label.textColor = isSelected ? selectedColor : .white
    }
}
