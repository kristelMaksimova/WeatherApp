//
//  HourlyForecastCell.swift
//  WeatherApp
//
//  Created by Kristi on 29.07.2022.
//

import UIKit

class HourlyForecastCell: UICollectionViewCell {
   
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var hour: UILabel!
    
    
    func settempCell(temp: String , hour: String, image: String) {
        self.temp.text = temp
        self.hour.text = hour
        
        DispatchQueue.global().async {
            let stringURL = "http://openweathermap.org/img/wn/\(image)@2x.png"
            guard let url = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.img.image = UIImage(data: imageData)
            }
        }
    }
}


