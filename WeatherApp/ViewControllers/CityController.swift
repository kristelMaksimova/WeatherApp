//
//  CityController.swift
//  WeatherApp
//
//  Created by Kristi on 25.07.2022.
//

import UIKit
import CoreData

class CityController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var cityTextField: UITextField!
    
    
    // MARK: - Public properties
    var weatherReport: CurrentWeather!
    
    //MARK: - Private Properties
    private var cityList: [City] = []
    
    var hourlyWeather = [List] ()
    var dailyWeather = [List] ()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        tableView.reloadData()
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  let weatherVC = segue.destination as? WeatherController,
            let weatherReport = sender as? CurrentWeather {
            weatherVC.weatherReport = weatherReport
            weatherVC.delegate = self
            weatherVC.hourlyWeather = self.hourlyWeather
            weatherVC.dailyWeather = self.dailyWeather
        }
        
        dismiss(animated: true) {
            self.cityTextField.text = ""
        }
    }
    
    
    //MARK: - IBActoin
    @IBAction func buttonGoTapped(_ sender: Any) {
        if cityTextField.text! == "" {
            print("Нужен алерт")
        } else {
            networkingTableAndColletionViews(text: cityTextField.text!, host: WeatherAPI.hostOne)
            networkingTableAndColletionViews(text: cityTextField.text!, host: WeatherAPI.hostTwo)
            self.save(cityName: cityTextField.text!)
        }
    }
    
    
    // MARK: - Private methods
    
    private func save(cityName: String) {
        StorageManager.shared.save(cityName) { city in
            self.cityList.append(city)
            self.tableView.insertRows(
                at: [IndexPath(row: self.cityList.count - 1, section: 0)] ,
                with: .automatic)
        }
    }
    
    private func fetchData() {
        StorageManager.shared.fetchData { result in
            switch result {
            case .success(let city):
                self.cityList = city
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func dailyDataFilter(watherData: Welcome) {
        self.dailyWeather.removeAll()
        
        for i in 0...40 {
            if i == 5 || i == 13 || i == 21 || i == 29 || i == 37 {
                self.dailyWeather.append(watherData.list[i])
            }
        }
    }
    
    private func hourlyDataFilter(watherData: Welcome) {
        self.hourlyWeather.removeAll()
        
        for i in 0...7 {
            self.hourlyWeather.append(watherData.list[i])
        }
    }
}


//MARK: - Table view data source
extension CityController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CityCell
        let city = cityList[indexPath.row]
        cell.cityName.text = city.title!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let city = cityList[indexPath.row]
        
        if editingStyle == .delete {
            cityList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            StorageManager.shared.delete(city)
        }
    }
}


// MARK: - Table view delegate
extension CityController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cityList[indexPath.row]
        networkingTableAndColletionViews(text: city.title!, host: WeatherAPI.hostTwo)
        networkingTableAndColletionViews(text: city.title!, host: WeatherAPI.hostOne)
    }
}


// MARK: - Networking
extension CityController {
    
    func networkingTableAndColletionViews(text: String, host: String) {
        
        var components = URLComponents(string: host)
        let cityQuery = URLQueryItem(name: "q", value: text)
        let appIdQuery = URLQueryItem(name: "appid", value: "b6d1e53fa1e2de6d512ae99663b7137e")
        let unitsQuery = URLQueryItem(name: "units", value: "metric")
        
        components?.queryItems = [cityQuery, appIdQuery, unitsQuery]
        
        guard let url = components?.url else {return}
        
        URLSession.shared.dataTask(with: url) { data , response, errur in
            guard let data = data else {return }
            
            do {
                if host == WeatherAPI.hostTwo { 
                    let watherData = try JSONDecoder().decode( Welcome.self ,from: data )
                    
                    self.dailyDataFilter(watherData: watherData)
                    self.hourlyDataFilter(watherData: watherData)
                    
                } else {
                    
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    let weatherReport = try JSONDecoder().decode(CurrentWeather.self, from: data)
                    print(weatherReport)
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "Go", sender: weatherReport)
                    }
                }
            } catch let jsonErr {
                print("Error :" ,jsonErr )
            }
            
        }.resume()
    }
}

