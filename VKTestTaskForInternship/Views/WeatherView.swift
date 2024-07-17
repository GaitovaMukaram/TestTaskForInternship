//
//  WeatherView.swift
//  VKTestTaskForInternship
//
//  Created by Mukaram Gaitova on 18.07.2024.
//

import UIKit

class WeatherView: UIView {
    
    var weatherType: WeatherType?
    private let weatherLabel = UILabel()
    private var isDay: Bool
    
    init(frame: CGRect, weatherType: WeatherType, isDay: Bool) {
        self.isDay = isDay
        super.init(frame: frame)
        self.weatherType = weatherType
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        guard let weatherType = weatherType else { return }
        weatherLabel.text = weatherType.rawValue
        weatherLabel.textAlignment = .center
        weatherLabel.font = UIFont.systemFont(ofSize: 32)
        weatherLabel.frame = self.bounds
        addSubview(weatherLabel)
        
        // Анимация
        animateWeather()
    }
    
    private func animateWeather() {
        guard let weatherType = weatherType else { return }
        
        switch weatherType {
        case .sunny:
            isDay ? animateSunny() : animateMoon()
        case .rain:
            animateRain()
        case .storm:
            animateStorm()
        case .fog:
            animateFog()
        }
    }
    
    private func animateSunny() {
        // Создание круга для солнца
        let sunLayer = CAShapeLayer()
        let sunPath = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: 50, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        sunLayer.path = sunPath.cgPath
        sunLayer.fillColor = UIColor.orange.cgColor
        layer.addSublayer(sunLayer)
        
        // Создание контейнера для лучей
        let raysContainer = CALayer()
        raysContainer.frame = bounds
        layer.addSublayer(raysContainer)
        
        // Создание лучей солнца
        let numberOfRays = 12
        let rayLength: CGFloat = 30
        let raySpacing: CGFloat = 10 // Расстояние между кругом и лучами
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        for i in 0..<numberOfRays {
            let angle = CGFloat(i) * (.pi * 2 / CGFloat(numberOfRays))
            
            let startX = center.x + cos(angle) * (50 + raySpacing)
            let startY = center.y + sin(angle) * (50 + raySpacing)
            let endX = center.x + cos(angle) * (50 + raySpacing + rayLength)
            let endY = center.y + sin(angle) * (50 + raySpacing + rayLength)
            
            let rayPath = UIBezierPath()
            rayPath.move(to: CGPoint(x: startX, y: startY))
            rayPath.addLine(to: CGPoint(x: endX, y: endY))
            
            let rayLayer = CAShapeLayer()
            rayLayer.path = rayPath.cgPath
            rayLayer.strokeColor = UIColor.orange.cgColor
            rayLayer.lineWidth = 5
            rayLayer.lineCap = .round
            raysContainer.addSublayer(rayLayer)
        }
        
        // Анимация вращения лучей
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.toValue = NSNumber(value: Double.pi * 2)
        rotateAnimation.duration = 5
        rotateAnimation.repeatCount = Float.infinity
        raysContainer.add(rotateAnimation, forKey: "rotate")
    }

    private func animateMoon() {
        // Создание круга для луны
        let moonLayer = CAShapeLayer()
        let moonPath = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: 50, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        moonLayer.path = moonPath.cgPath
        moonLayer.fillColor = UIColor.yellow.cgColor
        layer.addSublayer(moonLayer)
        
        // Создание контейнера для звезд
        let starsContainer = CALayer()
        starsContainer.frame = bounds
        layer.addSublayer(starsContainer)
        
        // Создание звезд
        let numberOfStars = 10
        for _ in 0..<numberOfStars {
            let starLayer = CAShapeLayer()
            let starPath = UIBezierPath(arcCenter: CGPoint(x: CGFloat(arc4random_uniform(UInt32(bounds.width))), y: CGFloat(arc4random_uniform(UInt32(bounds.height)))), radius: 2, startAngle: 0, endAngle: .pi * 2, clockwise: true)
            starLayer.path = starPath.cgPath
            starLayer.fillColor = UIColor.white.cgColor
            starsContainer.addSublayer(starLayer)
        }
        
        // Анимация мигания звезд
        let blinkAnimation = CABasicAnimation(keyPath: "opacity")
        blinkAnimation.fromValue = 1.0
        blinkAnimation.toValue = 0.0
        blinkAnimation.duration = 0.5
        blinkAnimation.autoreverses = true
        blinkAnimation.repeatCount = Float.infinity
        starsContainer.add(blinkAnimation, forKey: "blink")
    }
    
    private func animateRain() {
        // Анимация дождя
        for _ in 0..<20 {
            let drop = UIView()
            drop.backgroundColor = .blue
            drop.frame = CGRect(x: CGFloat(arc4random_uniform(UInt32(bounds.width))), y: -10, width: 2, height: 10)
            addSubview(drop)
            
            UIView.animate(withDuration: 1.0, delay: Double(arc4random_uniform(100)) / 100.0, options: [.repeat, .curveLinear], animations: {
                drop.frame.origin.y = self.bounds.height
            }, completion: { _ in
                drop.removeFromSuperview()
            })
        }
    }
    
    private func animateStorm() {
        // Создание контейнера для молний
        let lightningContainer = CALayer()
        lightningContainer.frame = bounds
        layer.addSublayer(lightningContainer)
        
        // Создание молний
        let numberOfLightnings = 3
        for _ in 0..<numberOfLightnings {
            let lightningPath = UIBezierPath()
            let startX = CGFloat(arc4random_uniform(UInt32(bounds.width)))
            let startY: CGFloat = 0
            lightningPath.move(to: CGPoint(x: startX, y: startY))
            
            // Создание зигзагообразного пути для молнии
            let segments = 5
            var previousPoint = CGPoint(x: startX, y: startY)
            for _ in 0..<segments {
                let randomX = CGFloat(arc4random_uniform(40)) - 20 // Случайное смещение по X
                let randomY = CGFloat(arc4random_uniform(60)) + 20 // Случайное смещение по Y
                let newPoint = CGPoint(x: previousPoint.x + randomX, y: previousPoint.y + randomY)
                lightningPath.addLine(to: newPoint)
                previousPoint = newPoint
            }
            
            let lightningLayer = CAShapeLayer()
            lightningLayer.path = lightningPath.cgPath
            lightningLayer.strokeColor = UIColor.white.cgColor
            lightningLayer.lineWidth = 2
            lightningLayer.fillColor = UIColor.clear.cgColor
            lightningLayer.lineCap = .round
            lightningLayer.opacity = 0.0
            lightningContainer.addSublayer(lightningLayer)
            
            // Анимация появления и исчезновения молнии
            let fadeAnimation = CABasicAnimation(keyPath: "opacity")
            fadeAnimation.fromValue = 1.0
            fadeAnimation.toValue = 0.0
            fadeAnimation.duration = 0.2
            fadeAnimation.beginTime = CACurrentMediaTime() + CFTimeInterval(arc4random_uniform(3))
            fadeAnimation.autoreverses = true
            fadeAnimation.repeatCount = Float.infinity
            lightningLayer.add(fadeAnimation, forKey: "fade")
        }
    }
    
    private func animateFog() {
        // Анимация тумана
        let fogLayer = CAGradientLayer()
        fogLayer.colors = [UIColor.white.withAlphaComponent(0.6).cgColor, UIColor.clear.cgColor]
        fogLayer.frame = bounds
        fogLayer.startPoint = CGPoint(x: 0, y: 0.5)
        fogLayer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.addSublayer(fogLayer)
        
        let fogAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        fogAnimation.fromValue = -bounds.width
        fogAnimation.toValue = bounds.width
        fogAnimation.duration = 10
        fogAnimation.repeatCount = Float.infinity
        fogLayer.add(fogAnimation, forKey: "fog")
    }
}
