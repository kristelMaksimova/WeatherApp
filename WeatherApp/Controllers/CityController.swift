//
//  CityController.swift
//  WeatherApp
//
//  Created by Kristi on 25.07.2022.
//

import UIKit

class CityController: UIViewController {

    @IBOutlet var cityTextField: UITextField!
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBAction func buttonGoTapped(_ sender: Any) {
        
       // self.save()
        
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
    
   // @IBAction func returnToMainVC(_ sender: UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let weatherVC = segue.destination as? WeatherController,
           let weatherReport = sender as? Weather {
            weatherVC.weatherReport = weatherReport
        }
    }
    /*
    private func save() {
        
        guard let enityDescription = NSEntityDescription.entity(forEntityName: "City", in: context) else { return }
        guard let city = NSManagedObject(entity: enityDescription, insertInto: context) else { return }
        
        city.title = cityTextField.text
        
        dismiss(animated: true)
    }
     */
}
