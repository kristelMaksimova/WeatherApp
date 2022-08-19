//
//  HourlyForecastCell.swift
//  WeatherApp
//
//  Created by Kristi on 29.07.2022.
//

import UIKit

class HourlyCell: UICollectionViewCell {
   
    @IBOutlet weak var hourlyTemp: UILabel!
    @IBOutlet weak var hourlyImage: UIImageView!
    @IBOutlet weak var hourlyTime: UILabel!
    
    
    func settempCell(temp: Double , hour: String, image: String) {
        
        self.hourlyTemp.text = "\(Int(temp))˚C"
        self.hourlyTime.text = convertDateFormater(date: hour)
        
        DispatchQueue.global().async {
            let stringURL = "http://openweathermap.org/img/wn/\(image)@2x.png"
            guard let url = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.hourlyImage.image = UIImage(data: imageData)
            }
        }
    }
   
    private func convertDateFormater(date: String) -> String {
        var i = 0
        var result = ""
        for s in date {
            i += 1
            if i > 10 && i < 16 {
               result += "\(s)"
            }
        }
        return result + "0"
    }
}


