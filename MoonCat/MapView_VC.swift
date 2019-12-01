//
//  MapView_VC.swift
//  MoonCat
//
//  Created by Si Yu Zhuang on 11/30/19.
//  Copyright © 2019 Bolusaur. All rights reserved.
//

import UIKit
import GoogleMaps

class MapView_VC: UIViewController, CLLocationManagerDelegate {
    
    var mapView = GMSMapView()
    var mLocationManager = CLLocationManager()
    var mDidFindMyLocation = false
    let marker = GMSMarker()
    var markers = [GMSMarker]()
    //var subView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        let screen = UIScreen.main.bounds
        let screenW = screen.size.width
        let screenL = screen.size.height
        mLocationManager.delegate = self
        mLocationManager.requestWhenInUseAuthorization()
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 20, width: screenW, height: screenL - 20), camera:  GMSCameraPosition.camera(withLatitude: 43.662682, longitude: -79.395785, zoom: 15))
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        mapView.settings.indoorPicker = true
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        mapView.settings.tiltGestures = true
        mapView.settings.rotateGestures = true
        createMarkerArray()
        placeMarkers(markers: markers)
        self.view = mapView
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        if (status == CLAuthorizationStatus.authorizedWhenInUse) {
            mapView.isMyLocationEnabled = true
        }

    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?){
        
        if (!mDidFindMyLocation) {

            let myLocation: CLLocation = change![NSKeyValueChangeKey.newKey] as! CLLocation
            // change the camera view if my location moved
            mapView.camera = GMSCameraPosition.camera(withTarget: myLocation.coordinate, zoom: 10.0)
            mapView.settings.myLocationButton = true

            mDidFindMyLocation = true

            print("found location!")

        }
    }
    // MARK: - Test placing markers from array
    
     
     func createMarkerArray(){
        let marker0: GMSMarker = GMSMarker()
        let marker1: GMSMarker = GMSMarker()
        let marker2: GMSMarker = GMSMarker()
        let marker3: GMSMarker = GMSMarker()
        let marker4: GMSMarker = GMSMarker()
        
        marker0.title = "Tim Hortons"
        marker0.snippet = "Tims at SS"
        marker0.appearAnimation = .pop
        marker0.position = CLLocationCoordinate2D(latitude: 43.662279, longitude: -79.398489)
        markers.append(marker0)
        marker1.title = "Starbucks"
        marker1.snippet = "Starbucks at MS"
        marker1.appearAnimation = .pop
        marker1.position = CLLocationCoordinate2D(latitude: 43.660866, longitude: -79.392577)
        markers.append(marker1)
        marker2.title = "Innis Cafe"
        marker2.snippet = "Innis College Cafe"
        marker2.appearAnimation = .pop
        marker2.position = CLLocationCoordinate2D(latitude: 43.665600, longitude: -79.399540)
        markers.append(marker2)
        marker3.title = "Diabolos' Coffee"
        marker3.snippet = "Campus hub for coffee & light eats"
        marker3.appearAnimation = .pop
        marker3.position = CLLocationCoordinate2D(latitude: 43.663311, longitude: -79.396418)
        markers.append(marker3)
        marker4.title = "McCafe"
        marker4.snippet = "McCafe, great lattes"
        marker4.appearAnimation = .pop
        marker4.position = CLLocationCoordinate2D(latitude: 43.657924, longitude: -79.398682)
        markers.append(marker4)
     }
    
    func placeMarkers(markers: [GMSMarker]){
        for marker in markers{
            marker.map = mapView
        }
     }
     
    

}

