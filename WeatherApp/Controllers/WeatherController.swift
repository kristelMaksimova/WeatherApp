//
//  WeatherController.swift
//  WeatherApp
//
//  Created by Kristi on 25.07.2022.
//

import UIKit

class WeatherController: UIViewController {

    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var minAndMaxTemperatureLabel: UILabel!
    
    //API KEY: http://api.openweathermap.org/data/2.5/weather?q=Moscow&appid=b6d1e53fa1e2de6d512ae99663b7137e&units=metric
    
    var weatherReport: Weather!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        interfaceElements(networkData: weatherReport)
    
    }
    
    private func interfaceElements(networkData: Weather!) {
       
        guard let weatherReport = networkData else {return}
        
        cityLabel.text = weatherReport.city
        temperatureLabel.text = weatherReport.degreesCelcium
        minAndMaxTemperatureLabel.text = weatherReport.conditions.first?.description
        //  weatherImage.image = weatherReport.conditionImage
    }
    
    
    func networkingTwo(text: String) {
     
        var components = URLComponents(string: "http://api.openweathermap.org/data/2.5/weather")
        let cityQuery = URLQueryItem(name: "q", value: text)
        let appIdQuery = URLQueryItem(name: "appid", value: "c46cb767269fcb488c33372509d677a2")
        let unitsQuery = URLQueryItem(name: "units", value: "metric")
        
        components?.queryItems = [cityQuery, appIdQuery, unitsQuery]
        
        guard let url = components?.url else {return}
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) {(data, _, error) in
            if let error = error {
                print(error)
            } else if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    let weatherReport = try JSONDecoder().decode(Weather.self, from: data)
                    print(weatherReport)
                } catch {
                    print(error)
                }
            }
        }
        dataTask.resume()
    }
}
