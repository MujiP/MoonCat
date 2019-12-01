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
        marker.title = "Tim Hortons"
        marker.snippet = "Tims at SS"
        marker.appearAnimation = .pop
        marker.position = CLLocationCoordinate2D(latitude: 43.662279, longitude: -79.398489)
        marker.map = mapView
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
    /*
     
     func createMarkerArray() -> {
         let marker: GMSMarker = GMSMarker()
     }
     func placeMarkers(){
         
     }
     */
    

}

