//
//  DescriptionPopup.swift
//  WeatherTask
//
//  Created by Valerii on 11/9/19.
//  Copyright © 2019 Valerii. All rights reserved.
//

import Foundation
import UIKit

class DescriptionPopup: PopupView {
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.frame.size.height = mainWindow.frame.size.height / 1.33
        self.addGesture()
    }
}
