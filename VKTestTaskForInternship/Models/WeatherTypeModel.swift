//
//  WeatherTypeModel.swift
//  VKTestTaskForInternship
//
//  Created by Mukaram Gaitova on 17.07.2024.
//

import UIKit

enum WeatherType: String, CaseIterable {
    case sunny = "Sunny"
    case rain = "Rain"
    case storm = "Storm"
    case fog = "Fog"
    
    var color: UIColor {
        switch self {
        case .sunny:
            return .yellow
        case .rain:
            return .gray
        case .storm:
            return .darkGray
        case .fog:
            return .lightGray
        }
    }
}
