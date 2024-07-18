//
//  WeatherView.swift
//  VKTestTaskForInternship
//
//  Created by Mukaram Gaitova on 18.07.2024.
//

import UIKit

class WeatherView: UIView {
    
    var weatherType: WeatherType?
//    private let weatherLabel = UILabel()
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
        guard weatherType != nil else { return }
//        weatherLabel.text = weatherType.rawValue
//        weatherLabel.textAlignment = .center
//        weatherLabel.font = UIFont.systemFont(ofSize: 32)
//        weatherLabel.frame = self.bounds
//        addSubview(weatherLabel)
        
        // Анимация
        animateWeather()
    }
    
    private func animateWeather() {
        guard let weatherType = weatherType else { return }
        
        switch weatherType {
        case .clear:
            isDay ? animateSunny() : animateMoon()
        case .rain:
            animateRain()
        case .storm:
            animateStorm()
        case .fog:
            animateFog()
        case .cloudy:
            animateCloudy()
        case .snow:
            animateSnow()
        case .wind:
            animateWind()
        case .overcast:
            animateOvercast()
        case .blizzard:
            animateBlizzard()
        case .rainAndSnow:
            animateRainAndSnow()
        case .partlyCloudy:
            isDay ? animatePartlyCloudySun() : animatePartlyCloudyMoon()
        case .lightRain:
            isDay ? animateLightRainSun() : animateLightRainMoon()
        case .hail:
            animateHail()
        case .heavyRain:
            animateHeavyRain()
        case .stormAndRain:
            animateStormAndRain()
        }
    }
    
    private func animateSunny() {
        // Создание контейнера для солнца и лучей
        let sunContainer = CALayer()
        let sunCenter = CGPoint(x: bounds.midX, y: bounds.midY - 100)
        sunContainer.position = sunCenter
        layer.addSublayer(sunContainer)
        
        // Создание круга для солнца
        let sunLayer = CAShapeLayer()
        let sunPath = UIBezierPath(arcCenter: .zero, radius: 50, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        sunLayer.path = sunPath.cgPath
        sunLayer.fillColor = UIColor.orange.cgColor
        sunContainer.addSublayer(sunLayer)
        
        // Создание лучей солнца
        let numberOfRays = 12
        let rayLength: CGFloat = 30
        let raySpacing: CGFloat = 10 // Расстояние между кругом и лучами
        
        for i in 0..<numberOfRays {
            let angle = CGFloat(i) * (.pi * 2 / CGFloat(numberOfRays))
            
            let startX = cos(angle) * (50 + raySpacing)
            let startY = sin(angle) * (50 + raySpacing)
            let endX = cos(angle) * (50 + raySpacing + rayLength)
            let endY = sin(angle) * (50 + raySpacing + rayLength)
            
            let rayPath = UIBezierPath()
            rayPath.move(to: CGPoint(x: startX, y: startY))
            rayPath.addLine(to: CGPoint(x: endX, y: endY))
            
            let rayLayer = CAShapeLayer()
            rayLayer.path = rayPath.cgPath
            rayLayer.strokeColor = UIColor.orange.cgColor
            rayLayer.lineWidth = 5
            rayLayer.lineCap = .round
            sunContainer.addSublayer(rayLayer)
        }
        
        // Анимация вращения лучей
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.toValue = NSNumber(value: Double.pi * 2)
        rotateAnimation.duration = 5
        rotateAnimation.repeatCount = Float.infinity
        sunContainer.add(rotateAnimation, forKey: "rotate")
    }
    
    private func animateMoon() {
        // Создание круга для луны
        let moonLayer = CAShapeLayer()
        let moonPath = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY - 100), radius: 50, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        moonLayer.path = moonPath.cgPath
        moonLayer.fillColor = UIColor.yellow.cgColor
        layer.addSublayer(moonLayer)
        
        // Создание контейнера для звезд
        let starsContainer = CALayer()
        starsContainer.frame = bounds
        layer.addSublayer(starsContainer)
        
        // Создание звезд
        let numberOfStars = 30
        for _ in 0..<numberOfStars {
            let starLayer = CAShapeLayer()
            let starPath = UIBezierPath(arcCenter: CGPoint(x: CGFloat(arc4random_uniform(UInt32(bounds.width))), y: CGFloat(arc4random_uniform(UInt32(bounds.midY)))), radius: 2, startAngle: 0, endAngle: .pi * 2, clockwise: true)
            starLayer.path = starPath.cgPath
            starLayer.fillColor = UIColor.yellow.cgColor
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
        for _ in 0..<50 {
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
    
    private func animateStormAndRain() {
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
        
        animateRain()
    }
    
    private func animateFog() {
        // Создание контейнера для слоев тумана
        let fogContainer = CALayer()
        fogContainer.frame = bounds
        layer.addSublayer(fogContainer)
        
        // Создание слоев тумана
        let numberOfFogLayers = 7
        for i in 0..<numberOfFogLayers {
            let fogLayer = CALayer()
            
            // Случайная густота тумана
            let randomOpacity = CGFloat(arc4random_uniform(2) == 0 ? 0.8 : 0.2)
            fogLayer.backgroundColor = UIColor.white.withAlphaComponent(randomOpacity).cgColor
            let fogHeight = CGFloat(100)
            let yOffset = CGFloat(arc4random_uniform(UInt32(bounds.midY))) // Случайное смещение от низа до середины экрана
            fogLayer.frame = CGRect(x: -bounds.width, y: bounds.height - yOffset - fogHeight / 2, width: bounds.width * 2, height: fogHeight)
            fogLayer.cornerRadius = fogHeight / 2
            fogContainer.addSublayer(fogLayer)
            
            // Анимация движения тумана
            let fogAnimation = CABasicAnimation(keyPath: "position.x")
            fogAnimation.fromValue = -bounds.width
            fogAnimation.toValue = bounds.width * 2
            fogAnimation.duration = 10 + Double(i * 5)
            fogAnimation.repeatCount = Float.infinity
            fogLayer.add(fogAnimation, forKey: "fogMovement\(i)")
            
            // Анимация изменения прозрачности
            let opacityAnimation = CABasicAnimation(keyPath: "opacity")
            opacityAnimation.fromValue = randomOpacity
            opacityAnimation.toValue = randomOpacity == 0.8 ? 0.8 : 0.5
            opacityAnimation.duration = 10
            opacityAnimation.autoreverses = true
            opacityAnimation.repeatCount = Float.infinity
            fogLayer.add(opacityAnimation, forKey: "fogOpacity\(i)")
        }
    }
    
    private func animateCloudy() {
        // Создание контейнера для облаков
        let cloudsContainer = CALayer()
        cloudsContainer.frame = bounds
        layer.addSublayer(cloudsContainer)
        
        // Создание слоев облаков
        let numberOfClouds = 7
        for i in 0..<numberOfClouds {
            let cloudImageView = UIImageView(image: UIImage(systemName: "cloud.fill"))
            cloudImageView.tintColor = arc4random_uniform(2) == 0 ? .white : .lightGray
            cloudImageView.alpha = 0.8
            cloudImageView.frame = CGRect(x: -120, y: CGFloat(arc4random_uniform(UInt32(bounds.midY))), width: 120, height: 70)
            cloudsContainer.addSublayer(cloudImageView.layer)
            
            // Анимация движения облаков
            let cloudAnimation = CABasicAnimation(keyPath: "position.x")
            cloudAnimation.fromValue = -120
            cloudAnimation.toValue = bounds.width + 120
            cloudAnimation.duration = 10 + Double(i * 5)
            cloudAnimation.repeatCount = Float.infinity
            cloudImageView.layer.add(cloudAnimation, forKey: "cloudMovement\(i)")
        }
    }
    
    private func animateSnow() {
        // Количество снежинок
        let numberOfFlakes = 50
        
        for _ in 0..<numberOfFlakes {
            // Создание снежинки
            let snowflake = UIImageView(image: UIImage(systemName: "snowflake"))
            snowflake.tintColor = .white
            let flakeSize = CGFloat(arc4random_uniform(10) + 15) // Размер снежинок от 15 до 25
            snowflake.frame = CGRect(x: CGFloat(arc4random_uniform(UInt32(bounds.width))), y: -flakeSize, width: flakeSize, height: flakeSize)
            addSubview(snowflake)
            
            // Анимация падения снежинки
            let fallDuration = TimeInterval(arc4random_uniform(10) + 5)
            let delay = TimeInterval(arc4random_uniform(10)) / 10.0
            UIView.animate(withDuration: fallDuration, delay: delay, options: [.repeat, .curveLinear], animations: {
                snowflake.frame.origin.y = self.bounds.height
            }, completion: { _ in
                snowflake.removeFromSuperview()
            })
            
            // Анимация горизонтального колебания
            let oscillation = CABasicAnimation(keyPath: "position.x")
            oscillation.duration = 2
            oscillation.fromValue = snowflake.center.x - 20
            oscillation.toValue = snowflake.center.x + 20
            oscillation.repeatCount = Float.infinity
            oscillation.autoreverses = true
            snowflake.layer.add(oscillation, forKey: "oscillation")
        }
    }
    
    private func animateWind() {
        // Создание контейнера для ветра
        let windContainer = CALayer()
        windContainer.frame = bounds
        layer.addSublayer(windContainer)
        
        // Количество линий ветра
        let numberOfLines = 5
        
        for i in 0..<numberOfLines {
            let windLayer = CAShapeLayer()
            let windPath = UIBezierPath()
            
            // Путь для линии ветра (прямые линии с кривыми)
            var startX = CGFloat(-50)
            let startY = CGFloat(arc4random_uniform(UInt32(bounds.height)))
            windPath.move(to: CGPoint(x: startX, y: startY))
            
            let waveLength: CGFloat = 100
            let waveHeight: CGFloat = 20
            
            // Создаем волнистую линию
            for _ in 0..<5 {
                let controlPoint1 = CGPoint(x: startX + waveLength / 2, y: startY - waveHeight)
                let controlPoint2 = CGPoint(x: startX + waveLength / 2, y: startY + waveHeight)
                windPath.addCurve(to: CGPoint(x: startX + waveLength, y: startY), controlPoint1: controlPoint1, controlPoint2: controlPoint2)
                startX += waveLength
            }
            
            windLayer.path = windPath.cgPath
            windLayer.strokeColor = UIColor.white.cgColor
            windLayer.lineWidth = 2
            windLayer.fillColor = UIColor.clear.cgColor
            windLayer.lineCap = .round
            windLayer.opacity = 0.5
            windContainer.addSublayer(windLayer)
            
            // Анимация движения ветра
            let windAnimation = CABasicAnimation(keyPath: "position.x")
            windAnimation.fromValue = -bounds.width
            windAnimation.toValue = bounds.width
            windAnimation.duration = 5 + Double(i * 2)
            windAnimation.repeatCount = Float.infinity
            windLayer.add(windAnimation, forKey: "windMovement\(i)")
        }
    }
    
    private func animateOvercast() {
        animateSunny()
        animateCloudy()
    }
    
    private func animateBlizzard() {
        animateSnow()
        animateWind()
    }
    
    private func animateRainAndSnow() {
        animateRain()
        animateSnow()
    }
    
    private func animatePartlyCloudySun() {
        animateSunny()
        // Создание контейнера для облаков
        let cloudsContainer = CALayer()
        cloudsContainer.frame = bounds
        layer.addSublayer(cloudsContainer)
        
        // Создание слоев облаков
        let numberOfClouds = 5
        for i in 0..<numberOfClouds {
            let cloudImageView = UIImageView(image: UIImage(systemName: "cloud.fill"))
            cloudImageView.tintColor = .white
            cloudImageView.alpha = 0.5
            cloudImageView.frame = CGRect(x: -120, y: CGFloat(arc4random_uniform(UInt32(bounds.midY))), width: 120, height: 70)
            cloudsContainer.addSublayer(cloudImageView.layer)
            
            // Анимация движения облаков
            let cloudAnimation = CABasicAnimation(keyPath: "position.x")
            cloudAnimation.fromValue = -120
            cloudAnimation.toValue = bounds.width + 120
            cloudAnimation.duration = 10 + Double(i * 5)
            cloudAnimation.repeatCount = Float.infinity
            cloudImageView.layer.add(cloudAnimation, forKey: "cloudMovement\(i)")
        }
    }

    private func animatePartlyCloudyMoon() {
        animateMoon()
        // Создание контейнера для облаков
        let cloudsContainer = CALayer()
        cloudsContainer.frame = bounds
        layer.addSublayer(cloudsContainer)
        
        // Создание слоев облаков
        let numberOfClouds = 5
        for i in 0..<numberOfClouds {
            let cloudImageView = UIImageView(image: UIImage(systemName: "cloud.fill"))
            cloudImageView.tintColor = .white
            cloudImageView.alpha = 0.5
            cloudImageView.frame = CGRect(x: -120, y: CGFloat(arc4random_uniform(UInt32(bounds.midY))), width: 120, height: 70)
            cloudsContainer.addSublayer(cloudImageView.layer)
            
            // Анимация движения облаков
            let cloudAnimation = CABasicAnimation(keyPath: "position.x")
            cloudAnimation.fromValue = -120
            cloudAnimation.toValue = bounds.width + 120
            cloudAnimation.duration = 10 + Double(i * 5)
            cloudAnimation.repeatCount = Float.infinity
            cloudImageView.layer.add(cloudAnimation, forKey: "cloudMovement\(i)")
        }
    }
    
    private func animateLightRainSun() {
        animatePartlyCloudySun()
        animateRain()
    }
    
    private func animateLightRainMoon() {
        animatePartlyCloudyMoon()
        animateRain()
    }
    
    private func animateHail() {
        // Создание контейнера для облаков
        let cloudsContainer = CALayer()
        cloudsContainer.frame = bounds
        layer.addSublayer(cloudsContainer)
        
        let numberOfClouds = 3
        for i in 0..<numberOfClouds {
            let cloudImageView = UIImageView(image: UIImage(systemName: "cloud.fill"))
            cloudImageView.tintColor = .darkGray
            cloudImageView.alpha = 0.8
            cloudImageView.frame = CGRect(x: -120, y: CGFloat(arc4random_uniform(UInt32(bounds.midY - 200))), width: 120, height: 70)
            cloudsContainer.addSublayer(cloudImageView.layer)
            
            // Анимация движения облаков
            let cloudAnimation = CABasicAnimation(keyPath: "position.x")
            cloudAnimation.fromValue = -120
            cloudAnimation.toValue = bounds.width + 120
            cloudAnimation.duration = 5 + Double(i * 5)
            cloudAnimation.repeatCount = Float.infinity
            cloudImageView.layer.add(cloudAnimation, forKey: "cloudMovement\(i)")
        }
        
        // Анимация града
        let numberOfHailstones = 50
        for _ in 0..<numberOfHailstones {
            let hailstone = CAShapeLayer()
            let hailstoneSize: CGFloat = CGFloat(arc4random_uniform(5) + 5) // Размер градин от 5 до 10
            let randomXPosition = CGFloat(arc4random_uniform(UInt32(bounds.width)))
            
            let hailstonePath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: hailstoneSize, height: hailstoneSize))
            hailstone.path = hailstonePath.cgPath
            hailstone.fillColor = UIColor.white.cgColor
            hailstone.frame = CGRect(x: randomXPosition, y: CGFloat(arc4random_uniform(UInt32(bounds.midY - 200))), width: hailstoneSize, height: hailstoneSize)
            layer.addSublayer(hailstone)
            
            // Анимация падения градин
            let fallAnimation = CABasicAnimation(keyPath: "position.y")
            fallAnimation.fromValue = hailstone.position.y
            fallAnimation.toValue = bounds.height
            fallAnimation.duration = 0.1 + Double(arc4random_uniform(10)) / 10.0
            fallAnimation.repeatCount = Float.infinity
            hailstone.add(fallAnimation, forKey: "fallingHailstone")
        }
    }
    
    private func animateHeavyRain() {
        for _ in 0..<450 {
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
}
