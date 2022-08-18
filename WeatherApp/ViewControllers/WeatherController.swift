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
    @IBOutlet var currentFeelsLike: UILabel!
    @IBOutlet var currentSunrise: UILabel!
    @IBOutlet var currentSunset: UILabel!
    @IBOutlet var currentHumidity: UILabel!
    @IBOutlet var currentVisibility: UILabel!
    @IBOutlet var currentPressure: UILabel!
    @IBOutlet var currentImage: UIImageView!
    
    @IBOutlet var oneView: UIView!
    @IBOutlet var twoView: UIView!
    @IBOutlet var threeView: UIView!
    
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
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // MARK: - Private method

    private func interfaceElements(networkData: CurrentWeather!) {
        
        guard let weatherReport = networkData else {return}
        
        currentCity.text = weatherReport.city
        currentTemp.text = "\(Int(weatherReport.breakdown.temperature))˚C"
        currentCondition.text = weatherReport.conditions.first?.description
        currentMinMax.text = "Max.:\(Int(weatherReport.breakdown.maxTemperature))˚C,  Min.: \(Int(weatherReport.breakdown.minTemperature))˚C"
        currentFeelsLike.text = "\(Int(weatherReport.breakdown.feelsLikeTemperature))"
        currentSunrise.text = self.fromDtToformatedDate(dt:Double(weatherReport.sys.sunrise), format : "HH:mm")
        currentSunset.text = self.fromDtToformatedDate(dt:Double(weatherReport.sys.sunset), format : "HH:mm")
        currentPressure.text = "\(weatherReport.breakdown.pressure) hPa"
        currentHumidity.text = "\(weatherReport.breakdown.humidity)%"
        currentVisibility.text = "\(weatherReport.visibility / 1000) км"
        currentImage.image = UIImage(named: "\(weatherReport.conditions[0].icon)")
        
        collectionView.layer.cornerRadius = 12
        tableView.layer.cornerRadius = 12
        oneView.layer.cornerRadius = 12
        twoView.layer.cornerRadius = 12
        threeView.layer.cornerRadius = 12
    }
    func fromDtToformatedDate(dt: Double, format : String ) -> String {
        let date = Date(timeIntervalSince1970: dt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
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
