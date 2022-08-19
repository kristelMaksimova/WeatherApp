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
    
    
    // MARK: - Public properties
    var weatherReport: CurrentWeather!
    var delegate: CityController!
    
    var hourlyWeather = [List] ()
    var dailyWeather = [List] ()
    
    
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        interfaceElements(networkData: weatherReport)
    }
    
    
    // MARK: - Private method
    private func interfaceElements(networkData: CurrentWeather!) {
        
        guard let weatherReport = networkData else {return}
        
        currentCity.text = weatherReport.city
        currentTemp.text = "\(Int(weatherReport.breakdown.temperature))˚C"
        currentCondition.text = weatherReport.conditions.first?.description
        currentMinMax.text = "Max.:\(Int(weatherReport.breakdown.maxTemperature))˚C,  Min.: \(Int(weatherReport.breakdown.minTemperature))˚C"
        currentFeelsLike.text = "Feels like \(Int(weatherReport.breakdown.feelsLikeTemperature))˚C"
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
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func fromDtToformatedDate(dt: Double, format : String ) -> String {
       
        //        Wednesday, Sep 12, 2018           --> EEEE, MMM d, yyyy
        //        09/12/2018                        --> MM/dd/yyyy
        //        09-12-2018 14:11                  --> MM-dd-yyyy HH:mm
        //        Sep 12, 2:11 PM                   --> MMM d, h:mm a
        //        September 2018                    --> MMMM yyyy
        //        Sep 12, 2018                      --> MMM d, yyyy
        //        Wed, 12 Sep 2018 14:11:54 +0000   --> E, d MMM yyyy HH:mm:ss Z
        //        2018-09-12T14:11:54+0000          --> yyyy-MM-dd'T'HH:mm:ssZ
        //        12.09.18                          --> dd.MM.yy
        //        10:41:02.112                      --> HH:mm:ss.SSS
        
        let date = Date(timeIntervalSince1970: dt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}


//MARK: - Table view data source, delegate
extension WeatherController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as! DailyCell
        
        cell.interfaceElements(
            temp: dailyWeather[indexPath.row].main.temp,
            image: dailyWeather[indexPath.row].weather[0].icon,
            day: dailyWeather[indexPath.row].dtTxt
        )
        return cell
    }
}


// MARK: UICollectionViewDataSource
extension WeatherController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyWeather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourlyCell", for: indexPath) as! HourlyCell
        
        cell.settempCell(
            temp: hourlyWeather[indexPath.row].main.temp,
            hour: hourlyWeather[indexPath.row].dtTxt,
            image: hourlyWeather[indexPath.row].weather[0].icon
        )
        return cell
    }
}
