//
//  Weather.swift
//  WeatherApp
//
//  Created by Kristi on 25.07.2022.
//

import Foundation
import UIKit

struct Weather: Decodable {
    let city: String
    let breakdown: WeatherBreakdown
    let conditions: [WeatherCondition]
    
    private enum CodingKeys: String, CodingKey{
        case city = "name"
        case breakdown = "main"
        case conditions = "weather"
    }
}

struct WeatherBreakdown: Decodable{
    let temperature: Double
    
    private enum CodingKeys: String, CodingKey{
        case temperature = "temp"
    }
}

struct WeatherCondition: Decodable{
    let id: Int
    let description: String
}

extension Weather{
    
    var degreesCelcium: String {
        
        let wholeTemperature = Int(breakdown.temperature)
        let degreesCelcium = String(wholeTemperature) + "˚C"
        return degreesCelcium
        
    }
}
