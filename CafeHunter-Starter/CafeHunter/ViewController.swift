/*
* Copyright (c) 2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit
import MapKit

class ViewController: UIViewController {
  
  private var locationManager: CLLocationManager!
    private var lastLocation: CLLocation?
    
    private var cafes = [Cafe]()
    
    
    let searchDistance: CLLocationDistance = 1000
    
    
    
    @IBOutlet weak var loginView: FBLoginView!
    @IBOutlet weak var mapView: MKMapView!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.locationManager = CLLocationManager()
    self.locationManager.delegate = self
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "refresh:")
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    self.checkLocationAuthorizationStatus()
  }
  
  private func checkLocationAuthorizationStatus() {
    if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
        self.mapView.showsUserLocation = true
    } else {
      self.locationManager.requestWhenInUseAuthorization()
    }
  }

    func refresh(sender: UIBarButtonItem) {
        if let location = self.lastLocation {
            self.centerMapOnLocation(location)
            self.fetchCafesAroundLocation(location)
        } else {
            let alert = UIAlertController(title: "Error", message: "No location yet!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert
                , animated: true
                , completion: nil)
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
  
  func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    self.checkLocationAuthorizationStatus()
  }
  
}

extension ViewController: CafeViewControllerDelegate {
    func cafeViewControllerDidFinish(viewController: CafeViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        // 1
        /// pick out the annotations that are Cafe objects
        if let annotation = annotation as? Cafe {
            let identifier = "pin"
            var view: MKPinAnnotationView
            
            // 2
            /// use conditional downcast to ensure that the view is of type MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView {
                // 3
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                // 4
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as UIView
            }
            // 5
            return view
        }
        return nil
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        // 1
        // instantiate a new CafeViewController by asking the storyboard to create one from the Storyboard ID you already set. This could fail and return nil, so you employ the usual conditional optional unwrapping.
        if let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("CafeView") as? CafeViewController
        {
            // 2
            /// Then check the annotation from the tapped view to see if it's a Cafe object. You know it is, but the compiler doesn't because the type of the annotation property is MKAnnotation.
            if let cafe = view.annotation as? Cafe {
                // 3
                // finally, set up the view controller and present it.
                viewController.cafe = cafe
                viewController.delegate = self
                self.presentViewController(viewController, animated: true, completion: nil)
                
            }
        }
    }
    
    func mapView(mapView: MKMapView!, didFailToLocateUserWithError error: NSError!) {
        println(error)
        let alert = UIAlertController(title: "Error",
            message: "Failed to obtain location!",
            preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK",
            style: .Default,
            handler: nil))
        self.presentViewController(alert,
            animated: true,
            completion: nil)
    }
    
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        // 1
        // you retrieve the new location from the delegate method's userLocation parameter
        let newLocation = userLocation.location
        
        // 2
        // calculate the distance from the last location. Note the use of the question mark when obtaining the lastLocation property value. lastLocation is an optional property, meaning its value may be nil. If it is, then this expression returns nil and stops processing. Only if there is a concrete value in lastLocation is distanceFromLocation called on it. For this reason, the local distance variable is also an optional.
        let distance = self.lastLocation?.distanceFromLocation(newLocation)
        
        // 3
        // you want to update the map if there's no previous distance or if the user has moved by a certain amount. Since distance is an optional, you can do this check very easily in one if-statement. Without optionals, this code would need to be more complex, because you wouldn't be able to tell the diference between no distance value and a distance value of 0.
        if distance == nil || distance! > searchDistance {
            self.lastLocation = newLocation
            self.centerMapOnLocation(newLocation)
            self.fetchCafesAroundLocation(newLocation)
        }
    }
    
    private func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, searchDistance, searchDistance)
        self.mapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func fetchCafesAroundLocation(location: CLLocation) {
        if !FBSession.activeSession().isOpen {
            let alert = UIAlertController(title: "Error", message: "Login first!", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        // 1
        // construct the URL that going to use to ask Facebook for the places around the current location that match the search term "cafe"
        var urlString = "https://graph.facebook.com/v2.0/search/"
        urlString += "?access_token="
        urlString += "\(FBSession.activeSession().accessTokenData.accessToken)"
        urlString += "&type=place"
        urlString += "&q=cafe"
        urlString += "&center=\(location.coordinate.latitude)"
        urlString += "\(location.coordinate.longitude)"
        urlString += "&distance=\(Int(searchDistance))"
        
        
        // 2
        let url = NSURL(string: urlString)!
        
        println("Request from FB with URL: \(url)")
        
        // 3
        let request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request,
            queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                
                // 4
                if error != nil {
                    let alert = UIAlertController(title: "Oops!", message: "An error occured", preferredStyle: .Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    return
                }
                
                // 5
                var error: NSError?
                let jsonObject: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &error)
                
                // 6
                // if it is successfully downcast and there's no error, then you're successfully retrieved valid data from the API
                // NSDictionery to [String:AnyObject] NSArray to [AnyObject]
                if let jsonObject = jsonObject as? [String:AnyObject] {
                    if error == nil {
                        println("Data returned from FB:\n\(jsonObject)")
                        
                        // 7
                        // use the JSONValue helper defined. use optional chaining to extract the data key out of the JSON. If that key exists and its value can be cast to an array, then the if-statement passes and you have an array of nearby locations to work with.
                        if let data = JSONValue.fromObject(jsonObject)?["data"]?.array {
                            // 8
                            var cafes: [Cafe] = []
                            for cafeJSON in data {
                                if let cafeJSON = cafeJSON.object {
                                    if let cafe = Cafe.fromJSON(cafeJSON) {
                                        cafes.append(cafe)
                                    }
                                }
                            }
                            
                            // 9
                            self.mapView.removeAnnotations(self.cafes)
                            self.cafes = cafes
                            self.mapView.addAnnotations(cafes)
                        }
                    }
                }
                
        }
        
    }
    
}

