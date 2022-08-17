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
    
    
    func settempCell(temp:String , hour : String /*, img : UIImage*/){
        self.temp.text = temp
        self.hour.text = hour
      //  self.img.image = img
    }
}


