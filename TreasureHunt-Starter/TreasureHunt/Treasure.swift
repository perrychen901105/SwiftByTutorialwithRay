//
//  Treasure.swift
//  TreasureHunt
//
//  Created by chenzhipeng on 15/1/7.
//  Copyright (c) 2015年 Razeware. All rights reserved.
//

import Foundation

class Treasure {
    let what: String
    let location: GeoLocation
    
    init(what: String, location: GeoLocation) {
        self.what = what
        self.location = location
    }

    convenience init(what: String, latitude: Double, logitude: Double)
    {
        let location = GeoLocation(latitude: latitude, logitude: logitude)
        self.init(what: what, location: location)
    }
    
}

// 1
class HistoryTreasure: Treasure {
    let year: Int
    
    // 2
    init(what: String, year: Int, latitude: Double, logitude: Double)
    {
        self.year = year
        let location = GeoLocation(latitude: latitude, logitude: logitude)
        super.init(what: what, location: location)
    }
}

// 3
class FactTreasure: Treasure {
    let fact: String
    
    init(what: String, fact: String, latitude: Double, longitude: Double) {
        self.fact = fact
        let location = GeoLocation(latitude: latitude, logitude: longitude)
        super.init(what: what, location: location)
    }
}

// 4
class HQTreasure: Treasure {
    let company: String
    init(company: String, latitude: Double, longitude: Double) {
        self.company = company
        let location = GeoLocation(latitude: latitude, logitude: longitude)
        super.init(what: company + " headquarters", location: location)
    }
}



