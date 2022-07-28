//
//  ForecastWeather.swift
//  WeatherApp
//
//  Created by Kristi on 28.07.2022.
//

import Foundation

struct ForecastWeather: Codable {
    let list: [listArray]
    
    private enum CodingKeys: String, CodingKey{
        case list = "list"
    }
}

struct listArray: Codable {
    let main: listMainTemperature
    let weather: listWeatherImage
    let data: String
    
    private enum CodingKeys: String, CodingKey{
        case main = "main"
        case weather
        case data = "dt_txt"
    }
    
}

struct listMainTemperature: Codable {
   let temperature: Double
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
    }
}
struct listWeatherImage: Codable {
   let image: Double
    
    private enum CodingKeys: String, CodingKey {
        case image = "icon"
    }
}


// выводить в массиве для дней 8,
