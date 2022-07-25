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
        
        guard let weatherReport = weatherReport else {return}
        
        cityLabel.text = weatherReport.city
        temperatureLabel.text = weatherReport.degreesCelcium
        minAndMaxTemperatureLabel.text = weatherReport.conditions.first?.description
      //  weatherImage.image = weatherReport.conditionImage
    }
}
