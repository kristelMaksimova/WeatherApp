//
//  WeatherController.swift
//  WeatherApp
//
//  Created by Kristi on 25.07.2022.
//

import UIKit

class WeatherController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet var currentCity: UILabel!
    @IBOutlet var currentTemp: UILabel!
    @IBOutlet var currentCondition: UILabel!
    @IBOutlet var currentMinMax: UILabel!
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var tableView: UITableView!
    
    
    var weatherReport: CurrentWeather!
    var delegate: CityController!
    
    var hourlyWeather = [List] ()
    var dailyWeather = [List] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interfaceElements(networkData: weatherReport)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    // MARK: - Private method

    private func interfaceElements(networkData: CurrentWeather!) {
        
        guard let weatherReport = networkData else {return}
        
        currentCity.text = weatherReport.city
        currentTemp.text = "\(Int(weatherReport.breakdown.temperature))˚C"
        currentCondition.text = weatherReport.conditions.first?.description
        currentMinMax.text = "Max.:\(Int(weatherReport.breakdown.maxTemperature))˚C,  Min.: \(Int(weatherReport.breakdown.minTemperature))˚C"
       
        collectionView.layer.cornerRadius = 12
        tableView.layer.cornerRadius = 12
    }
}


//MARK: - Table view data source, delegate
extension WeatherController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("В списке для коллекции: \(dailyWeather.count)")
        return dailyWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as! DailyCell
        
        cell.interfaceElements(
            temp: "\(Int(dailyWeather[indexPath.row].main.temp))˚C",
            image: dailyWeather[indexPath.row].weather[0].icon,
            day: dailyWeather[indexPath.row].dtTxt
        )
        return cell
    }
}


// MARK: UICollectionViewDataSource
   
extension WeatherController: UICollectionViewDataSource, UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("В списке для коллекции: \(hourlyWeather.count)")
        return hourlyWeather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourlyCell", for: indexPath) as! HourlyCell
        
        cell.settempCell(
            temp: "\(Int(hourlyWeather[indexPath.row].main.temp))˚C",
            hour: hourlyWeather[indexPath.row].dtTxt,
            image: hourlyWeather[indexPath.row].weather[0].icon
        )
        
        return cell
    }
}
