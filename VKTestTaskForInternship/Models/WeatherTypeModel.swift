//
//  WeatherTypeModel.swift
//  VKTestTaskForInternship
//
//  Created by Mukaram Gaitova on 17.07.2024.
//

import Foundation

// Расширение для локализации строк
extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

// Определение перечисления с raw-значениями и свойством для локализованных строк
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
}
