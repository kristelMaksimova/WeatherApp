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
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var tableView: UITableView!
    
    
    var weatherReport: CurrentWeather!
    var hourlyWeather = [List] ()
    var delegate: CityController!
    var delegateTwo: CityController!
    var dailyWeather = [List] ()


    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.layer.cornerRadius = 12
        tableView.layer.cornerRadius = 12
        interfaceElements(networkData: weatherReport)
        setupNavigationBar()
    }
    
    // MARK: - Private methods

    private func interfaceElements(networkData: CurrentWeather!) {
        
        guard let weatherReport = networkData else {return}
        
        cityLabel.text = weatherReport.city
        temperatureLabel.text = "\(Int(weatherReport.breakdown.temperature))˚C"
        conditionLabel.text = weatherReport.conditions.first?.description
        minMaxTemperature.text = "Max.:\(Int(weatherReport.breakdown.maxTemperature))˚C,  Min.: \(Int(weatherReport.breakdown.minTemperature))˚C"
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
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
