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
    
    
    func settempCell(temp: String , hour: String, image: String) {
        
        self.hourlyTemp.text = temp
        self.hourlyTime.text = hour
        
        DispatchQueue.global().async {
            let stringURL = "http://openweathermap.org/img/wn/\(image)@2x.png"
            guard let url = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.hourlyImage.image = UIImage(data: imageData)
            }
        }
    }
}


