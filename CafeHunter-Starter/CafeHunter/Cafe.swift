//
//  Cafe.swift
//  CafeHunter
//
//  Created by chenzhipeng on 15/1/24.
//  Copyright (c) 2015年 Razeware. All rights reserved.
//

import Foundation
import MapKit

class Cafe: NSObject {
    let fbid: String
    let name: String
    let location: CLLocationCoordinate2D
    let street: String
    let city: String
    let zip: String
    
    var pictureURL: NSURL {
        return NSURL(string: "http://graph.facebook.com/place/picture?id=\(self.fbid)"+"type=large")!
    }
    
    init(fbid: String, name: String, location: CLLocationCoordinate2D, street: String, city: String, zip: String)
    {
       
        self.fbid = fbid
        self.name = name
        self.location = location
        self.street = street
        self.city = city
        self.zip = zip
        super.init()
    }
    
    class func fromJSON(json: [String:JSONValue]) -> Cafe? {
        // 1
        /// First, you pull the required parameters fbid, name, latitude and longitude out of the JSON. Notice the use of optional chaining to ensure very simple code. If the JSON doesn't contain a value for the "id" key, then fbid will be nil. fbid will alsobe nil if the value it contains isn't a string.
        let fbid = json["id"]?.string
        let name = json["name"]?.string
        let latitude = json["location"]?["latitude"]?.double
        let longitude = json["location"]?["longitude"]?.double
        
        // 2
        /**
        *  if success parsed, then create a Cafe
        */
        if fbid != nil && name != nil && latitude != nil && longitude != nil {
            // 3
            /// handle the first of the optional parameters. It's OK if there's no street----- you simply use an empty string.
            var street: String
            if let maybeStreet = json["location"]?["street"]?.string {
                street = maybeStreet
            } else {
                street = ""
            }
            
            // 4
            /// same goes for the city and the zip code.
            var city: String
            if let maybeCity = json["location"]?["city"]?.string {
                city = maybeCity
            } else {
                city = ""
            }
            
            var zip: String
            if let maybeZip = json["location"]?["zip"]?.string {
                zip = maybeZip
            } else {
                zip = ""
            }
            
            let location = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
            return Cafe(fbid: fbid!, name: name!, location: location, street: street, city: city, zip: zip)
        }
        // 6
        return nil
    }
    
}

extension Cafe: MKAnnotation {
    var title: String! {
        return name
    }
    
    var coordinate: CLLocationCoordinate2D {
        return location
    }
}
