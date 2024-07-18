//
//  WeatherView.swift
//  VKTestTaskForInternship
//
//  Created by Mukaram Gaitova on 18.07.2024.
//

import UIKit

class WeatherView: UIView {
    
    var weatherType: WeatherType?
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
        animateWeather()
    }
    
    private func animateWeather() {
        guard let weatherType = weatherType else { return }
        
        switch weatherType {
        case .clear:
            isDay ? animateSunny() : animateMoon()
        case .rain:
            animateRain(countDrops: 50)
        case .storm:
            animateStorm()
        case .fog:
            animateFog()
        case .cloudy:
            animateCloudy(numberOfClouds: 10, tintColor: [UIColor.white, UIColor.lightGray], duration: 10)
        case .snow:
            animateSnow()
        case .wind:
            animateWind()
        case .overcast:
            isDay ? animateOvercastSun() : animateOvercastMoon()
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
        let sunContainer = CALayer()
        let sunCenter = CGPoint(x: bounds.midX, y: bounds.midY - 100)
        sunContainer.position = sunCenter
        layer.addSublayer(sunContainer)
        
        let sunLayer = CAShapeLayer()
        let sunPath = UIBezierPath(arcCenter: .zero, radius: 50, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        sunLayer.path = sunPath.cgPath
        sunLayer.fillColor = UIColor.orange.cgColor
        sunContainer.addSublayer(sunLayer)
        
        let numberOfRays = 12
        let rayLength: CGFloat = 30
        let raySpacing: CGFloat = 10
        
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
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.toValue = NSNumber(value: Double.pi * 2)
        rotateAnimation.duration = 5
        rotateAnimation.repeatCount = Float.infinity
        sunContainer.add(rotateAnimation, forKey: "rotate")
    }
    
    private func animateMoon() {
        let moonLayer = CAShapeLayer()
        let moonPath = UIBezierPath(arcCenter: CGPoint(x: bounds.midX, y: bounds.midY - 100), radius: 50, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        moonLayer.path = moonPath.cgPath
        moonLayer.fillColor = UIColor.yellow.cgColor
        layer.addSublayer(moonLayer)
        
        let starsContainer = CALayer()
        starsContainer.frame = bounds
        layer.addSublayer(starsContainer)
        
        let numberOfStars = 30
        for _ in 0..<numberOfStars {
            let starLayer = CAShapeLayer()
            let starPath = UIBezierPath(arcCenter: CGPoint(x: CGFloat(arc4random_uniform(UInt32(bounds.width))), y: CGFloat(arc4random_uniform(UInt32(bounds.midY)))), radius: 2, startAngle: 0, endAngle: .pi * 2, clockwise: true)
            starLayer.path = starPath.cgPath
            starLayer.fillColor = UIColor.yellow.cgColor
            starsContainer.addSublayer(starLayer)
        }
        
        let blinkAnimation = CABasicAnimation(keyPath: "opacity")
        blinkAnimation.fromValue = 1.0
        blinkAnimation.toValue = 0.0
        blinkAnimation.duration = 0.5
        blinkAnimation.autoreverses = true
        blinkAnimation.repeatCount = Float.infinity
        starsContainer.add(blinkAnimation, forKey: "blink")
    }
    
    private func animateRain(countDrops: Int) {
        for _ in 0..<countDrops {
            let dropImageView = UIImageView(image: UIImage(systemName: "drop.fill"))
            dropImageView.tintColor = .blue
            let dropSize = CGFloat(arc4random_uniform(5) + 5)
            let xPosition = CGFloat(arc4random_uniform(UInt32(bounds.width)))
            dropImageView.frame = CGRect(x: xPosition, y: -dropSize, width: dropSize, height: dropSize)
            addSubview(dropImageView)
            
            UIView.animate(withDuration: 1.0, delay: Double(arc4random_uniform(100)) / 100.0, options: [.repeat, .curveLinear], animations: {
                dropImageView.frame.origin.y = self.bounds.height
            }, completion: { _ in
                dropImageView.removeFromSuperview()
            })
        }
    }
    
    private func animateStorm() {
        let lightningContainer = CALayer()
        lightningContainer.frame = bounds
        layer.addSublayer(lightningContainer)
        
        let numberOfLightnings = 3
        for _ in 0..<numberOfLightnings {
            let lightningPath = UIBezierPath()
            let startX = CGFloat(arc4random_uniform(UInt32(bounds.width)))
            let startY: CGFloat = 0
            lightningPath.move(to: CGPoint(x: startX, y: startY))
            
            let segments = 5
            var previousPoint = CGPoint(x: startX, y: startY)
            for _ in 0..<segments {
                let randomX = CGFloat(arc4random_uniform(40)) - 20
                let randomY = CGFloat(arc4random_uniform(60)) + 20
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
        animateStorm()
        animateRain(countDrops: 50)
    }
    
    private func animateFog() {
        let fogContainer = CALayer()
        fogContainer.frame = bounds
        layer.addSublayer(fogContainer)
        
        let numberOfFogLayers = 7
        
        for i in 0..<numberOfFogLayers {
            let fogLayer = CALayer()
            
            let fogImageView = UIImageView(image: UIImage(systemName: "smoke.fill"))
            fogImageView.contentMode = .scaleToFill
            fogImageView.tintColor = UIColor.white.withAlphaComponent(CGFloat(arc4random_uniform(2) == 0 ? 0.8 : 0.2))
            fogLayer.addSublayer(fogImageView.layer)
            
            let fogHeight: CGFloat = 100
            let yOffset = CGFloat(arc4random_uniform(UInt32(bounds.midY - 50)))
            fogLayer.frame = CGRect(x: -bounds.width, y: bounds.height - yOffset - fogHeight / 2, width: bounds.width * 2, height: fogHeight)
            fogImageView.frame = fogLayer.bounds
            fogContainer.addSublayer(fogLayer)
            
            let fogAnimation = CABasicAnimation(keyPath: "position.x")
            fogAnimation.fromValue = -bounds.width
            fogAnimation.toValue = bounds.width * 2
            fogAnimation.duration = 10 + Double(i * 5)
            fogAnimation.repeatCount = Float.infinity
            fogLayer.add(fogAnimation, forKey: "fogMovement\(i)")
            
            let opacityAnimation = CABasicAnimation(keyPath: "opacity")
            opacityAnimation.fromValue = fogImageView.tintColor.cgColor.alpha
            opacityAnimation.toValue = fogImageView.tintColor.cgColor.alpha == 0.8 ? 0.8 : 0.5
            opacityAnimation.duration = 10
            opacityAnimation.autoreverses = true
            opacityAnimation.repeatCount = Float.infinity
            fogLayer.add(opacityAnimation, forKey: "fogOpacity\(i)")
        }
    }
    
    private func animateCloudy(numberOfClouds: Int, tintColor: [UIColor], duration : Double) {
        let cloudsContainer = CALayer()
        cloudsContainer.frame = bounds
        layer.addSublayer(cloudsContainer)
        
        for i in 0..<numberOfClouds {
            let cloudImageView = UIImageView(image: UIImage(systemName: "cloud.fill"))
            cloudImageView.tintColor = tintColor.randomElement()
            cloudImageView.alpha = 0.8
            cloudImageView.frame = CGRect(x: -120, y: CGFloat(arc4random_uniform(UInt32(bounds.midY))), width: 120, height: 70)
            cloudsContainer.addSublayer(cloudImageView.layer)
            
            let cloudAnimation = CABasicAnimation(keyPath: "position.x")
            cloudAnimation.fromValue = -120
            cloudAnimation.toValue = bounds.width + 120
            cloudAnimation.duration = duration + Double(i * 5)
            cloudAnimation.repeatCount = Float.infinity
            cloudImageView.layer.add(cloudAnimation, forKey: "cloudMovement\(i)")
        }
    }
    
    private func animateSnow() {
        let numberOfFlakes = 50
        
        for _ in 0..<numberOfFlakes {
            let snowflake = UIImageView(image: UIImage(systemName: "snowflake"))
            snowflake.tintColor = .white
            let flakeSize = CGFloat(arc4random_uniform(10) + 15)
            snowflake.frame = CGRect(x: CGFloat(arc4random_uniform(UInt32(bounds.width))), y: -flakeSize, width: flakeSize, height: flakeSize)
            addSubview(snowflake)
            
            let fallDuration = TimeInterval(arc4random_uniform(10) + 5)
            let delay = TimeInterval(arc4random_uniform(10)) / 10.0
            UIView.animate(withDuration: fallDuration, delay: delay, options: [.repeat, .curveLinear], animations: {
                snowflake.frame.origin.y = self.bounds.height
            }, completion: { _ in
                snowflake.removeFromSuperview()
            })
            
            let oscillation = CABasicAnimation(keyPath: "position.x")
            oscillation.duration = 20
            oscillation.fromValue = snowflake.center.x - 20
            oscillation.toValue = snowflake.center.x + 20
            oscillation.repeatCount = Float.infinity
            oscillation.autoreverses = true
            snowflake.layer.add(oscillation, forKey: "oscillation")
        }
    }
    
    private func animateWind() {
        let windContainer = CALayer()
        windContainer.frame = bounds
        layer.addSublayer(windContainer)

        let numberOfLines = 5

        for i in 0..<numberOfLines {
            let windPath = UIBezierPath()

            var startX = CGFloat(-50)
            let startY = CGFloat(arc4random_uniform(UInt32(bounds.height)))
            windPath.move(to: CGPoint(x: startX, y: startY))

            let waveLength: CGFloat = 100
            let waveHeight: CGFloat = 20

            for _ in 0..<5 {
                let controlPoint1 = CGPoint(x: startX + waveLength / 2, y: startY - waveHeight)
                let controlPoint2 = CGPoint(x: startX + waveLength / 2, y: startY + waveHeight)
                windPath.addCurve(to: CGPoint(x: startX + waveLength, y: startY), controlPoint1: controlPoint1, controlPoint2: controlPoint2)
                startX += waveLength
            }

            // Создание анимации листьев
            let leafImageView = UIImageView(image: UIImage(systemName: "leaf.fill"))
            leafImageView.tintColor = .green
            leafImageView.frame = CGRect(x: -50, y: startY, width: 30, height: 30)
            leafImageView.contentMode = .scaleAspectFit
            windContainer.addSublayer(leafImageView.layer)

            // Анимация движения листьев по пути ветра
            let leafAnimation = CAKeyframeAnimation(keyPath: "position")
            leafAnimation.path = windPath.cgPath
            leafAnimation.duration = 5 + Double(i * 2)
            leafAnimation.repeatCount = Float.infinity
            leafImageView.layer.add(leafAnimation, forKey: "leafMovement\(i)")

            // Создание анимации песчинок
            let numberOfDustParticles = 50
            for _ in 0..<numberOfDustParticles {
                let dustParticle = UIView()
                dustParticle.backgroundColor = .brown
                let particleSize: CGFloat = CGFloat(arc4random_uniform(3) + 2)
                dustParticle.frame = CGRect(x: -particleSize, y: CGFloat(arc4random_uniform(UInt32(bounds.height))), width: particleSize, height: particleSize)
                dustParticle.layer.cornerRadius = particleSize / 2
                addSubview(dustParticle)

                // Анимация движения песчинок по волнистому пути
                let dustAnimation = CAKeyframeAnimation(keyPath: "position")
                dustAnimation.path = windPath.cgPath
                dustAnimation.duration = 5 + Double(arc4random_uniform(5))
                dustAnimation.repeatCount = Float.infinity
                dustParticle.layer.add(dustAnimation, forKey: "dustMovement\(i)")
            }
        }
    }
    
    private func animateOvercastSun() {
        animateSunny()
        animateCloudy(numberOfClouds: 7, tintColor: [UIColor.white, UIColor.lightGray], duration: 10)
    }
    
    private func animateOvercastMoon() {
        animateMoon()
        animateCloudy(numberOfClouds: 7, tintColor: [UIColor.white, UIColor.lightGray], duration: 10)
    }
    
    private func animateBlizzard() {
        animateSnow()
//        animateWind()
    }
    
    private func animateRainAndSnow() {
        animateRain(countDrops: 50)
        animateSnow()
    }
    
    private func animatePartlyCloudySun() {
        animateSunny()
        animateCloudy(numberOfClouds: 5, tintColor: [UIColor.white], duration: 10)
    }
    
    private func animatePartlyCloudyMoon() {
        animateMoon()
        animateCloudy(numberOfClouds: 5, tintColor: [UIColor.white], duration: 10)
    }
    
    private func animateLightRainSun() {
        animatePartlyCloudySun()
        animateRain(countDrops: 20)
    }
    
    private func animateLightRainMoon() {
        animatePartlyCloudyMoon()
        animateRain(countDrops: 20)
    }
    
    private func animateHail() {
        animateCloudy(numberOfClouds: 3, tintColor: [UIColor.darkGray], duration: 7)
        
        let numberOfHailstones = 20
        for _ in 0..<numberOfHailstones {
            let hailstone = CAShapeLayer()
            let hailstoneSize: CGFloat = CGFloat(arc4random_uniform(5) + 5)
            let randomXPosition = CGFloat(arc4random_uniform(UInt32(bounds.width)))
            
            let hailstonePath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: hailstoneSize, height: hailstoneSize))
            hailstone.path = hailstonePath.cgPath
            hailstone.fillColor = UIColor.white.cgColor
            hailstone.frame = CGRect(x: randomXPosition, y: CGFloat(arc4random_uniform(UInt32(bounds.midY - 200))), width: hailstoneSize, height: hailstoneSize)
            layer.addSublayer(hailstone)
            
            let fallAnimation = CABasicAnimation(keyPath: "position.y")
            fallAnimation.fromValue = hailstone.position.y
            fallAnimation.toValue = bounds.height
            fallAnimation.duration = 0.1 + Double(arc4random_uniform(10)) / 10.0
            fallAnimation.repeatCount = Float.infinity
            hailstone.add(fallAnimation, forKey: "fallingHailstone")
        }
    }
    
    private func animateHeavyRain() {
        animateRain(countDrops: 450)
    }
}
