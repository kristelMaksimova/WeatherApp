//
//  Weather.swift
//  WeatherApp
//
//  Created by Kristi on 25.07.2022.
//

import Foundation

struct CurrentWeather: Codable {
    let city: String
    let breakdown: WeatherBreakdown
    let conditions: [WeatherCondition]
    
    private enum CodingKeys: String, CodingKey {
        case city = "name"
        case breakdown = "main"
        case conditions = "weather"
    }
}

struct WeatherBreakdown: Codable {
    let temperature: Double
    let minTemperature: Double
    let maxTemperature: Double
    
    enum CodingKeys: String, CodingKey{
        case temperature = "temp"
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
    }
}

struct WeatherCondition: Codable {
    let id: Int
    let description: String
    let icon: String
}
