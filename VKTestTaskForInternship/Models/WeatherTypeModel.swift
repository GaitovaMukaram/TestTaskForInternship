//
//  WeatherTypeModel.swift
//  VKTestTaskForInternship
//
//  Created by Mukaram Gaitova on 17.07.2024.
//

import Foundation

enum WeatherType: String, CaseIterable {
    case clear = "clear_label"
    case rain = "rain_label"
    case storm = "storm_label"
    case stormAndRain = "stormAndRain_label"
    case fog = "fog_label"
    case cloudy = "cloudy_label"
    case snow = "snow_label"
    case wind = "wind_label"
    case overcast = "overcast_label"
    case blizzard = "blizzard_label"
    case rainAndSnow = "rainAndSnow_label"
    case partlyCloudy = "partlyCloudy_label"
    case hail = "hail_label"
    case heavyRain = "heavyRain_label"
    case lightRain = "lightRain_label"
    
    var localizedString: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
    
    var iconName: String {
        switch self {
        case .clear: return "sun.max.fill"
        case .rain: return "cloud.rain.fill"
        case .storm: return "cloud.bolt.fill"
        case .stormAndRain: return "cloud.bolt.rain.fill"
        case .fog: return "cloud.fog.fill"
        case .cloudy: return "cloud.fill"
        case .snow: return "snowflake"
        case .wind: return "wind"
        case .overcast: return "cloud.sun.fill"
        case .blizzard: return "wind.snow"
        case .rainAndSnow: return "cloud.sleet.fill"
        case .partlyCloudy: return "cloud.sun.fill"
        case .lightRain: return "cloud.sun.rain.fill"
        case .hail: return "cloud.hail"
        case .heavyRain: return "cloud.heavyrain.fill"
        }
    }
}
