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
        animateWeather()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func animateWeather() {
        
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
        case .none:
            isDay ? animateSunny() : animateMoon()
        }
    }
    
    private func animateSunny() {
        let sunImageView = UIImageView(image: UIImage(systemName: "sun.max.fill"))
        sunImageView.tintColor = .orange
        sunImageView.bounds = CGRect(x: 0, y: 0, width: 200, height: 200)
        sunImageView.center = CGPoint(x: bounds.midX, y: bounds.midY - 150)
        sunImageView.contentMode = .scaleAspectFit
        layer.addSublayer(sunImageView.layer)
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.toValue = NSNumber(value: Double.pi * 2)
        rotateAnimation.duration = 5
        rotateAnimation.repeatCount = Float.infinity
        sunImageView.layer.add(rotateAnimation, forKey: "rotate")
        
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.fromValue = 1.0
        pulseAnimation.toValue = 1.1
        pulseAnimation.duration = 1
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = Float.infinity
        sunImageView.layer.add(pulseAnimation, forKey: "pulse")
    }
    
    private func animateMoon() {
        let moonImageView = UIImageView(image: UIImage(systemName: "moonphase.new.moon"))
        moonImageView.tintColor = .yellow
        moonImageView.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        moonImageView.center = CGPoint(x: bounds.midX, y: bounds.midY - 150)
        moonImageView.contentMode = .scaleAspectFit
        layer.addSublayer(moonImageView.layer)
        
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.fromValue = 1.0
        pulseAnimation.toValue = 1.1
        pulseAnimation.duration = 1
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = Float.infinity
        moonImageView.layer.add(pulseAnimation, forKey: "pulse")
        
        let starsContainer = CALayer()
        starsContainer.frame = bounds
        layer.addSublayer(starsContainer)
        
        let numberOfStars = 30
        for _ in 0..<numberOfStars {
            let starLayer = CALayer()
            let starSize: CGFloat = 4
            starLayer.frame = CGRect(x: CGFloat.random(in: 0..<bounds.width), y: CGFloat.random(in: 0..<bounds.midY), width: starSize, height: starSize)
            starLayer.backgroundColor = UIColor.yellow.cgColor
            starLayer.cornerRadius = starSize / 2
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
            dropImageView.tintColor = UIColor(red: 113.0/255.0, green: 192.0/255.0, blue: 235.0/255.0, alpha: 1.0)
            let dropSize = CGFloat.random(in: 5...10)
            let xPosition = CGFloat.random(in: 0..<bounds.width)
            dropImageView.frame = CGRect(x: xPosition, y: -dropSize, width: dropSize, height: dropSize)
            addSubview(dropImageView)
            
            UIView.animate(withDuration: 1.0, delay: Double.random(in: 0..<1), options: [.repeat, .curveLinear], animations: {
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
            let startX = CGFloat.random(in: 0..<bounds.width)
            let startY: CGFloat = 0
            lightningPath.move(to: CGPoint(x: startX, y: startY))
            
            let segments = 5
            var previousPoint = CGPoint(x: startX, y: startY)
            for _ in 0..<segments {
                let randomX = CGFloat.random(in: -20...20)
                let randomY = CGFloat.random(in: 20...80)
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
            fadeAnimation.beginTime = CACurrentMediaTime() + CFTimeInterval(Double.random(in: 0..<3))
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
        let numberOfFogLayers = 9
        
        for i in 0..<numberOfFogLayers {
            let fogLayer = CALayer()
            
            let fogImageView = UIImageView(image: UIImage(systemName: "smoke.fill"))
            fogImageView.contentMode = .scaleToFill
            fogImageView.tintColor = UIColor.white.withAlphaComponent(Bool.random() ? 0.8 : 0.2)
            fogLayer.addSublayer(fogImageView.layer)
            
            let fogHeight: CGFloat = 100
            let yOffset = CGFloat.random(in: 0..<bounds.midY)
            fogLayer.frame = CGRect(x: -bounds.width, y: bounds.height - yOffset - fogHeight / 2, width: bounds.width * 2, height: fogHeight)
            fogImageView.frame = fogLayer.bounds
            layer.addSublayer(fogLayer)
            
            let fogAnimation = CABasicAnimation(keyPath: "position.x")
            fogAnimation.fromValue = -bounds.width
            fogAnimation.toValue = bounds.width * 2
            fogAnimation.duration = 10 + Double(i * 5)
            fogAnimation.repeatCount = Float.infinity
            fogLayer.add(fogAnimation, forKey: "fogMovement\(i)")
            
            let opacityAnimation = CABasicAnimation(keyPath: "opacity")
            opacityAnimation.fromValue = fogImageView.tintColor.cgColor.alpha
            opacityAnimation.toValue = fogImageView.tintColor.cgColor.alpha == 0.8 ? 0.8 : 0.5
            opacityAnimation.duration = 1
            opacityAnimation.autoreverses = true
            opacityAnimation.repeatCount = Float.infinity
            fogLayer.add(opacityAnimation, forKey: "fogOpacity\(i)")
        }
    }
    
    private func animateCloudy(numberOfClouds: Int, tintColor: [UIColor], duration : Double) {
        for i in 0..<numberOfClouds {
            let cloudImageView = UIImageView(image: UIImage(systemName: "cloud.fill"))
            cloudImageView.tintColor = tintColor.randomElement()
            cloudImageView.alpha = 0.8
            let startY = CGFloat.random(in: 0..<bounds.midY - 50)
            cloudImageView.frame = CGRect(x: -120, y: startY, width: 120, height: 70)
            layer.addSublayer(cloudImageView.layer)
            
            let cloudAnimation = CABasicAnimation(keyPath: "position.x")
            cloudAnimation.fromValue = -120
            cloudAnimation.toValue = bounds.width + 120
            cloudAnimation.duration = duration + Double(i * 5)
            cloudAnimation.repeatCount = Float.infinity
            cloudImageView.layer.add(cloudAnimation, forKey: "cloudMovement\(i)")
        }
    }
    
    private func animateSnowflakes(count: Int, durationRange: ClosedRange<TimeInterval>, delayRange: ClosedRange<TimeInterval>, fallSpeed: CGFloat, oscillationAmplitude: CGFloat) {
        for _ in 0..<count {
            let snowflake = UIImageView(image: UIImage(systemName: "snowflake"))
            snowflake.tintColor = .white
            let snowflakeSize = CGFloat.random(in: 10...20)
            let xPosition = CGFloat.random(in: 0..<bounds.width)
            snowflake.frame = CGRect(x: xPosition, y: -snowflakeSize, width: snowflakeSize, height: snowflakeSize)
            addSubview(snowflake)
            
            let fallDuration = TimeInterval.random(in: durationRange)
            let delay = TimeInterval.random(in: delayRange)
            UIView.animate(withDuration: fallDuration, delay: delay, options: [.repeat, .curveLinear], animations: {
                snowflake.frame.origin.y = self.bounds.height * fallSpeed
            }, completion: { _ in
                snowflake.removeFromSuperview()
            })
            
            let oscillation = CABasicAnimation(keyPath: "position.x")
            oscillation.duration = 2
            oscillation.fromValue = snowflake.center.x - oscillationAmplitude
            oscillation.toValue = snowflake.center.x + oscillationAmplitude
            oscillation.repeatCount = Float.infinity
            oscillation.autoreverses = true
            snowflake.layer.add(oscillation, forKey: "oscillation")
        }
    }
    
    private func animateSnow() {
        animateSnowflakes(count: 50, durationRange: 5...15, delayRange: 0...1, fallSpeed: 1, oscillationAmplitude: 20)
    }
    
    private func animateBlizzard() {
        animateSnowflakes(count: 150, durationRange: 2...8, delayRange: 0...1, fallSpeed: 3, oscillationAmplitude: 60)
    }
    
    private func animateWind() {
        let numberOfPaths = 5
        
        for pathIndex in 0..<numberOfPaths {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(pathIndex) * 0.5) {
                let windPath = UIBezierPath()
                let startY = CGFloat.random(in: 0..<(self.bounds.height - 150))
                let direction = Bool.random() ? 1 : -1
                windPath.move(to: CGPoint(x: direction == 1 ? -50 : self.bounds.width + 50, y: startY))
                
                let straightLineEndX = direction == 1 ? self.bounds.width / 3 : 2 * self.bounds.width / 3
                windPath.addLine(to: CGPoint(x: straightLineEndX, y: startY))
                
                let spiralCenterX = straightLineEndX + CGFloat(direction) * CGFloat.random(in: 0..<(self.bounds.width / 3))
                let spiralCenterY = CGFloat.random(in: 0..<self.bounds.height)
                let spiralCenter = CGPoint(x: spiralCenterX, y: spiralCenterY)
                let numberOfSpirals = 3
                let spiralRadiusIncrement: CGFloat = 20
                
                for i in 0..<(numberOfSpirals * 10) {
                    let angle = CGFloat(i) * .pi / 5
                    let radius = spiralRadiusIncrement * CGFloat(i) / 10
                    let x = spiralCenter.x + radius * cos(angle)
                    let y = spiralCenter.y + radius * sin(angle)
                    windPath.addLine(to: CGPoint(x: x, y: y))
                }
                
                windPath.addLine(to: CGPoint(x: direction == 1 ? self.bounds.width + 50 : -50, y: spiralCenterY))
                
                let numberOfLeaves = 1
                for i in 0..<numberOfLeaves {
                    let leafImageView = UIImageView(image: UIImage(systemName: "leaf.fill"))
                    leafImageView.tintColor = UIColor(red: 0.6, green: 0.8, blue: 0.6, alpha: 1.0)
                    let leafSize: CGFloat = 30
                    leafImageView.frame = CGRect(x: direction == 1 ? -leafSize : self.bounds.width + leafSize, y: startY, width: leafSize, height: leafSize)
                    leafImageView.contentMode = .scaleAspectFit
                    self.addSubview(leafImageView)
                    
                    let leafAnimation = CAKeyframeAnimation(keyPath: "position")
                    leafAnimation.path = windPath.cgPath
                    leafAnimation.duration = 4
                    leafAnimation.repeatCount = Float.infinity
                    leafImageView.layer.add(leafAnimation, forKey: "leafMovement\(pathIndex)_\(i)")
                }
                
                let numberOfDustParticles = 2
                for particleIndex in 0..<numberOfDustParticles {
                    let dustParticle = UIView()
                    dustParticle.backgroundColor = .brown
                    let particleSize: CGFloat = CGFloat.random(in: 2...5)
                    dustParticle.frame = CGRect(x: direction == 1 ? -particleSize : self.bounds.width + particleSize, y: startY, width: particleSize, height: particleSize)
                    dustParticle.layer.cornerRadius = particleSize / 2
                    self.addSubview(dustParticle)
                    
                    let dustAnimation = CAKeyframeAnimation(keyPath: "position")
                    dustAnimation.path = windPath.cgPath
                    dustAnimation.duration = 4 + Double.random(in: 0...5)
                    dustAnimation.repeatCount = Float.infinity
                    dustParticle.layer.add(dustAnimation, forKey: "dustMovement\(pathIndex)_\(particleIndex)")
                }
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
            let hailstone = CALayer()
            let hailstoneSize: CGFloat = CGFloat(Int.random(in: 5...9))
            let randomXPosition = CGFloat.random(in: 0..<bounds.width)
            
            hailstone.backgroundColor = UIColor.white.cgColor
            hailstone.cornerRadius = hailstoneSize / 2
            hailstone.frame = CGRect(x: randomXPosition, y: CGFloat.random(in: 0..<bounds.midY - 200), width: hailstoneSize, height: hailstoneSize)
            layer.addSublayer(hailstone)
            
            let fallAnimation = CABasicAnimation(keyPath: "position.y")
            fallAnimation.fromValue = hailstone.position.y
            fallAnimation.toValue = bounds.height
            fallAnimation.duration = 0.1 + Double.random(in: 0...1)
            fallAnimation.repeatCount = Float.infinity
            hailstone.add(fallAnimation, forKey: "fallingHailstone")
        }
    }
    
    private func animateHeavyRain() {
        animateRain(countDrops: 450)
    }
}
