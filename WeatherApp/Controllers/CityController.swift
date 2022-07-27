//
//  CityController.swift
//  WeatherApp
//
//  Created by Kristi on 25.07.2022.
//

import UIKit
import CoreData
import Foundation

class CityController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var cityTemperature: UILabel!
    
    
    private var cityList: [City] = []
  
    var weatherReport: Weather!
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        tableView.reloadData()
    }
    
    
    @IBAction func buttonGoTapped(_ sender: Any) {
        
        self.save(cityName: cityTextField.text!)
        networking(text: cityTextField.text!)
    }
    
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
    
}

//MARK: - Table view data source

extension CityController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CityCell
        let city = cityList[indexPath.row]
        cell.cityName.text = city.title!
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cityList[indexPath.row]
        networking(text: city.title!)
        self.performSegue(withIdentifier: "Go", sender: weatherReport)
        }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let city = cityList[indexPath.row]
        
        if editingStyle == .delete {
            cityList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            StorageManager.shared.delete(city)
        }
       }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        if  let weatherVC = segue.destination as? WeatherController,
            let weatherReport = sender as? Weather {
            weatherVC.weatherReport = weatherReport
        }
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let product = cityList[indexPath.row]
        guard let productsVC = segue.destination as? WeatherController else { return }
        productsVC.networkingTwo(text: product.title!)
        
    }
}

// MARK: - Networking

extension CityController {
    
    func networking(text: String) {
        guard cityTextField.text?.isEmpty == false else {return}
        
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
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "Go", sender: weatherReport)
                    }
                } catch {
                    print(error)
                }
            }
        }
        dataTask.resume()
    }
    
    }
