//
//  CityCell.swift
//  WeatherApp
//
//  Created by Kristi on 25.07.2022.
//

import UIKit

class CityCell: UITableViewCell {

    @IBOutlet var cityName: UILabel!
    @IBOutlet var temperature: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }

}
