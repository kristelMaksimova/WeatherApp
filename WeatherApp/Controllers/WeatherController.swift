//
//  WeatherController.swift
//  WeatherApp
//
//  Created by Kristi on 25.07.2022.
//

import UIKit

class WeatherController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var minAndMaxTemperatureLabel: UILabel!
    
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
}
