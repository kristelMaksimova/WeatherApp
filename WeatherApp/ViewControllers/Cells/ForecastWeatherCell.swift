//
//  ForecastWeatherCell.swift
//  WeatherApp
//
//  Created by Kristi on 28.07.2022.
//

import UIKit

class ForecastWeatherCell: UITableViewCell {

    @IBOutlet var forecastDay: UILabel!
    @IBOutlet var forecastImage: UIImageView!
    @IBOutlet var forecastTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

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
