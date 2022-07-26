//
//  CityController.swift
//  WeatherApp
//
//  Created by Kristi on 25.07.2022.
//

import UIKit
import CoreData

class CityController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var cityTextField: UITextField!
    
    
    private var cityList: [City] = []
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        tableView.reloadData()
    }
    
    
    @IBAction func buttonGoTapped(_ sender: Any) {
        
        self.save()
        
        guard cityTextField.text?.isEmpty == false else {return}
        
        var components = URLComponents(string: "http://api.openweathermap.org/data/2.5/weather")
        let cityQuery = URLQueryItem(name: "q", value: cityTextField.text)
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let weatherVC = segue.destination as? WeatherController,
           let weatherReport = sender as? Weather {
            weatherVC.weatherReport = weatherReport
        }
    }
    
    private func save() {
        
        let city = City(context: context)
        city.title = cityTextField.text
        
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print(error)
            }
        }
        dismiss(animated: true)
    }
    
    private func fetchData() {
        let fetchRequest = City.fetchRequest()
        do {
            cityList = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}



//MARK: - Работа с табличным предствлением

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
    
}
