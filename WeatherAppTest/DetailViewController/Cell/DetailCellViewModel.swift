//
//  DetailCellViewModel.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 27/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import Foundation
struct DetailCellViewModel {
    let date: Date
    let tempeature: Double
    let rain: Double
    let wind: Double
}

extension DetailCellViewModel {
    var dateString: String {
        return DateFormatter.hourFormatter.string(from: date)
    }
        
    var tempeatureString: String {
        return "Temperature \(tempeature)°"
    }
    
    var rainString: String {
        return "Pluie \(rain)"
    }
    
    var windString: String {
        return "Vent Moyen \(wind)"
    }
}

