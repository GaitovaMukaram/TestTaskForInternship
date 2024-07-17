//
//  WeatherView.swift
//  VKTestTaskForInternship
//
//  Created by Mukaram Gaitova on 18.07.2024.
//

import UIKit

class WeatherView: UIView {
    
    private var weatherType: WeatherType?
    private let weatherLabel = UILabel()
    
    init(frame: CGRect, weatherType: WeatherType) {
        super.init(frame: frame)
        self.weatherType = weatherType
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        guard let weatherType = weatherType else { return }
        self.backgroundColor = weatherType.color
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
            animateSunny()
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
        
        // Создание лучей солнца
        let numberOfRays = 12
        let rayLength: CGFloat = 30
        let rayWidth: CGFloat = 10
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        for i in 0..<numberOfRays {
            let angle = CGFloat(i) * (.pi * 2 / CGFloat(numberOfRays))
            let startX = center.x + cos(angle) * 50
            let startY = center.y + sin(angle) * 50
            let endX = center.x + cos(angle) * (50 + rayLength)
            let endY = center.y + sin(angle) * (50 + rayLength)
            
            let rayPath = UIBezierPath()
            rayPath.move(to: CGPoint(x: startX, y: startY))
            rayPath.addLine(to: CGPoint(x: endX, y: endY))
            rayPath.lineWidth = rayWidth
            
            let rayLayer = CAShapeLayer()
            rayLayer.path = rayPath.cgPath
            rayLayer.strokeColor = UIColor.yellow.cgColor
            rayLayer.lineWidth = rayWidth
            layer.addSublayer(rayLayer)
        }
        
        // Анимация вращения
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.toValue = NSNumber(value: Double.pi * 2)
        rotateAnimation.duration = 5
        rotateAnimation.repeatCount = Float.infinity
        layer.add(rotateAnimation, forKey: "rotate")
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
        // Анимация грозы (молнии)
        let lightning = UIView()
        lightning.backgroundColor = .white
        lightning.frame = bounds
        lightning.alpha = 0.0
        addSubview(lightning)
        
        UIView.animate(withDuration: 0.1, delay: 0, options: [.repeat, .autoreverse], animations: {
            lightning.alpha = 1.0
        }, completion: { _ in
            lightning.alpha = 0.0
        })
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
