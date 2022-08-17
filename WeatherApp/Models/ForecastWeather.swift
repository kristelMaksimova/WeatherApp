//
//  ForecastWeather.swift
//  WeatherApp
//
//  Created by Kristi on 28.07.2022.
//

import Foundation

struct Welcome: Codable {
    //let cod: String
    //let message, cnt: Int
    let list: [List]
    let city: CityT
}

// MARK: - City
struct CityT: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double
}

// MARK: - List
struct List: Codable {
    let dt: Int
    let main: MainClass
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let sys: Sys
    let dtTxt: String
    let snow, rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case snow, rain
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let pod: Pod
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: MainEnum
    let weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case snow = "Snow"
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}




/*



struct ForecastWeather: Codable {
    
    let list: [listArray]
    
    private enum CodingKeys: String, CodingKey{
        case list
    }
}

struct listArray: Codable {
    let main: listMainTemperature
    let weather: listWeatherImage
    let data: String
    
    private enum CodingKeys: String, CodingKey{
        case main
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
*/
