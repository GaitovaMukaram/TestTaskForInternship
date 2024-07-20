//
//  CustomToggleButton.swift
//  VKTestTaskForInternship
//
//  Created by Mukaram Gaitova on 20.07.2024.
//

import UIKit

class CustomToggleButton: UIButton {
    
    private let moonImageView = UIImageView(image: UIImage(systemName: "moon.fill"))
    private let sunImageView = UIImageView(image: UIImage(systemName: "sun.min.fill"))
    private let toggleBackgroundView = UIView()
    private var isDay = false
    
    var toggleAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        setupToggleBackgroundView()
        
        setupImageView(moonImageView, tintColor: .yellow)
        setupImageView(sunImageView, tintColor: .yellow)
        
        addSubview(moonImageView)
        addSubview(sunImageView)
        
        updateImageVisibility()
        
        addTarget(self, action: #selector(toggle), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutToggleBackgroundView()
        layoutImageViews()
    }
    
    @objc private func toggle() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.isDay.toggle()
            self.updateImageVisibility()
        }, completion: { _ in
            self.toggleAction?()
        })
    }
    
    private func setupToggleBackgroundView() {
        toggleBackgroundView.backgroundColor = UIColor(red: 36.0/255.0, green: 24.0/255.0, blue: 56.0/255.0, alpha: 1.0)
        toggleBackgroundView.layer.cornerRadius = bounds.height / 2
        toggleBackgroundView.isUserInteractionEnabled = false
        addSubview(toggleBackgroundView)
    }
    
    private func setupImageView(_ imageView: UIImageView, tintColor: UIColor) {
        imageView.tintColor = tintColor
    }
    
    private func layoutToggleBackgroundView() {
        toggleBackgroundView.frame = bounds
        toggleBackgroundView.layer.cornerRadius = bounds.height / 2
    }
    
    private func layoutImageViews() {
        let size: CGFloat
        if UIDevice.current.userInterfaceIdiom == .pad {
            size = bounds.height * 0.8
        } else {
            size = bounds.height - 10
        }
        moonImageView.frame = CGRect(x: 5, y: 5, width: size, height: size)
        sunImageView.frame = CGRect(x: bounds.width - size - 5, y: 5, width: size, height: size)
    }
    
    private func updateImageVisibility() {
        moonImageView.alpha = isDay ? 1 : 0
        sunImageView.alpha = isDay ? 0 : 1
    }
}
