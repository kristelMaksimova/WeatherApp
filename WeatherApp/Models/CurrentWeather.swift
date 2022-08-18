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
    let sys: Sun
    let visibility: Int
    
    private enum CodingKeys: String, CodingKey {
        case city = "name"
        case breakdown = "main"
        case conditions = "weather"
        case sys = "sys"
        case visibility = "visibility"
    }
}

struct WeatherBreakdown: Codable {
    let temperature: Double
    let minTemperature: Double
    let maxTemperature: Double
    let feelsLikeTemperature: Double
    let pressure: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey{
        case temperature = "temp"
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
        case feelsLikeTemperature = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
    }
}

struct WeatherCondition: Codable {
    let icon: String
    let id: Int
    let description: String
}

struct Sun: Codable {
    let sunrise: Int
    let sunset: Int
    
    enum CodingKeys: String, CodingKey {
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
}
