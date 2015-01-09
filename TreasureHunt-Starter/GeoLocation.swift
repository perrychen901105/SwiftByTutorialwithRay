//
//  GeoLocation.swift
//  TreasureHunt
//
//  Created by chenzhipeng on 15/1/7.
//  Copyright (c) 2015年 Razeware. All rights reserved.
//

import Foundation
import MapKit

struct GeoLocation {
    var latitude: Double
    var longitude: Double
    func distanceBetween(other: GeoLocation) -> Double{
        let locationA = CLLocation(latitude: self.latitude, longitude: self.longitude)
        let locationB = CLLocation(latitude: other.latitude, longitude: other.longitude)
        return locationA.distanceFromLocation(locationB)
    }
}

extension GeoLocation {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(self.latitude, self.longitude)
    }
    
    var mapPoint: MKMapPoint {
        return MKMapPointForCoordinate(self.coordinate)
    }
}

extension GeoLocation: Equatable {
}
/**
    Declare all operator overloads at global scope because they aren't methods that belong to a class. can use the == operator on its own anywhere.
*/
func ==(lhs: GeoLocation, rhs: GeoLocation) -> Bool {
    return lhs.latitude == rhs.latitude && rhs.longitude == rhs.longitude
}