
import UIKit
import MapKit

class ViewController: UIViewController {
  
    @IBOutlet var mapView : MKMapView!
  
    private var treasures: [Treasure] = []
    /// hold an array of GeoLocation structs so that the app can keep track of whick treasures the user has found and in what order
    private var foundLocations: [GeoLocation] = []
    /// overlay can add to a map view to show a line with a set of points.
    private var polyLine: MKPolyline!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.treasures = [
            HistoryTreasure(what: "Google's first office", year: 1999, latitude: 37.44451, longitude: -122.163369),
            HistoryTreasure(what: "Facebook's first office", year: 2005, latitude: 37.444268, longitude: -122.163271),
            FactTreasure(what: "Stanford University", fact: "Founded in 1885 by Leland Stanford", latitude: 37.427474, longitude: -122.169719),
            FactTreasure(what: "Moscone West", fact: "Host to WWDC since 2003", latitude: 37.783083, longitude: -122.404025),
            FactTreasure(what: "Computer History Museum", fact: "Home to a working Babbage Difference Engine.", latitude: 37.414371, longitude: -122.076817),
            HQTreasure(company: "Apple", latitude: 37.331741, longitude: -122.030333),
            HQTreasure(company: "Facebook", latitude: 37.485955, longitude: -122.149555),
            HQTreasure(company: "Google", latitude: 37.422, longitude: -122.084)
        ]
    
        self.mapView.delegate = self
        self.mapView.addAnnotations(self.treasures)
        
        // 1
        /// works by using the reduce function of an array. To reduce an array means to run a function over the array that combines each element into a single, final return value. At each step, the next element from the array is passed along with the current value for the next reduce. Of course, you need to seed the reduce with an initial value. In this case, your seed is MKMapRectNull.
        let rectToDisplay = self.treasures.reduce(MKMapRectNull) {
            (mapRect: MKMapRect, treasure: Treasure) -> MKMapRect in
            // 2
            /// At each step in the reduce ,calculate a map rectangle enclosing just the single treasure
            let treasurePointRect = MKMapRect(origin: treasure.location.mapPoint, size: MKMapSize(width: 0, height: 0))
            
            // 3
            /**
            *
            *
            *  @param mapRect
            *  @param treasurePointRect
            *
            *  @return a rectangle made up of the union of the current overall rectangle and the single treasure rectangle.
            */
            
            return MKMapRectUnion(mapRect, treasurePointRect)
        }
        
        // 4

        self.mapView.setVisibleMapRect(rectToDisplay, edgePadding: UIEdgeInsetsMake(74, 10, 10, 10), animated: false)
    }
    
    private func markTreasureAsFound(treasure: Treasure) {
        // 1
        /// check if the location already exists in the found locations array using the global find() function, which takes a collection and an element to find in the collection.
        if let index = find(self.foundLocations, treasure.location) {
            // 2
            /// if the location does already exist in the found locations array, then you display an alert showing at which step the user found the treasure.
            let alert = UIAlertController(
                title: "Oops!",
                message: "You've already found this treasure (at step\(index + 1))! Try again!",
                preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            // 3
            self.foundLocations.append(treasure.location)
            
            // 4
            if self.polyLine != nil {
                self.mapView.removeOverlay(self.polyLine)
            }
            
            // 5
            var coordinates = self.foundLocations.map { $0.coordinate }
            self.polyLine = MKPolyline(coordinates: &coordinates, count: coordinates.count)
            self.mapView.addOverlay(self.polyLine)
        }
    }

}

extension ViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView!,
        viewForAnnotation annotation:MKAnnotation!) -> MKAnnotationView! {
            // 1
            /// perform the downcast using as? and immediately assign it to the local variable treasure. Only if the downcast succeeds will the if statement pass.
            if let treasure = annotation as? Treasure {
                // 2
                ///
                var view = mapView.dequeueReusableAnnotationViewWithIdentifier("pin") as MKPinAnnotationView!
                if view == nil {
                    // 3
                    view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
                    view.canShowCallout = true
                    view.animatesDrop = false
                    view.calloutOffset = CGPoint(x: -5, y: 5)
                    view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as UIView
                } else {
                    // 4
                    view.annotation = annotation
                }
                view.pinColor = treasure.pinColor()
                
                // 5
                return view
            }
            return nil
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        if let treasure = view.annotation as? Treasure {
            if let alertable = treasure as? Alertable {
                let alert = alertable.alert()
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                alert.addAction(UIAlertAction(title: "Find Nearest", style: UIAlertActionStyle.Default) { action in
                    
                        // 1
                        // sort the list of treasures,
                    var sortedTreasures = self.treasures
                    sortedTreasures.sort {
                        // 2
                        let distanceA = treasure.location.distanceBetween($0.location)
                        let distanceB = treasure.location.distanceBetween($1.location)
                        return distanceA < distanceB
                    }
                    // 3
                    mapView.deselectAnnotation(treasure, animated: true)
                    mapView.selectAnnotation(sortedTreasures[1], animated: true)
                    })
                alert.addAction(UIAlertAction(title: "Found", style: UIAlertActionStyle.Default) { action in
                        self.markTreasureAsFound(treasure)
                    })
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if let polylineOverlay = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polylineOverlay)
            renderer.strokeColor = UIColor.blueColor()
            return renderer
        }
        return nil
    }
    
    
}

