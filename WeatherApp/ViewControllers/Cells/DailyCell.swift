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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

   // func configure(with products: Welcome) {
       // forecastDay.text = products.
       // forecastTemp.text = products.name
        //forecastImage.text = "$ \(products.price ?? "")"
   // }
}
