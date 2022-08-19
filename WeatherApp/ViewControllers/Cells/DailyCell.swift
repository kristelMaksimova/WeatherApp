//
//  ForecastWeatherCell.swift
//  WeatherApp
//
//  Created by Kristi on 28.07.2022.
//

import UIKit

class DailyCell: UITableViewCell {

    @IBOutlet var dailyData: UILabel!
    @IBOutlet var dailyImage: UIImageView!
    @IBOutlet var dailyTemp: UILabel!
    
    func interfaceElements(temp: Double, image: String, day: String) {
        self.dailyTemp.text = "\(Int(temp))˚C"
        self.dailyData.text = convertDateFormater(date: day)
        
        DispatchQueue.global().async {
            let stringURL = "http://openweathermap.org/img/wn/\(image)@2x.png"
            guard let url = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.dailyImage.image = UIImage(data: imageData)
            }
        }
    }
    
    private func convertDateFormater(date: String) -> String {
        var i = 0
        var result = ""
        for s in date {
            i += 1
            if i > 8 && i < 11 {
               result += "\(s)"
            }
        }
        return result 
    }
}
