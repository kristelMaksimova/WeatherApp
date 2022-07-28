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
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var conditionLabel: UILabel!
    @IBOutlet var minMaxTemperature: UILabel!
    
    
    var weatherReport: CurrentWeather!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        interfaceElements(networkData: weatherReport)
    
    }
    
    private func interfaceElements(networkData: CurrentWeather!) {
        
        guard let weatherReport = networkData else {return}
        
        cityLabel.text = weatherReport.city
        temperatureLabel.text = "\(Int(weatherReport.breakdown.temperature))˚C"
        conditionLabel.text = weatherReport.conditions.first?.description
        minMaxTemperature.text = "Max.:\(Int(weatherReport.breakdown.maxTemperature))˚C,  Min.: \(Int(weatherReport.breakdown.minTemperature))˚C"
    }
}

//MARK: - Table view data source, delegate
extension WeatherController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as! ForecastWeatherCell
       
       // let city = [indexPath.row]
        //cell.cityName.text = city.title!
        
        return cell
    }
}
