//
//  ContentViewModel.swift
//  MapKitPractice
//
//  Created by Apple New on 2022-05-20.
//

import MapKit

final class ContentViewModel: NSObject, ObservableObject,CLLocationManagerDelegate{
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.509865, longitude:  -0.118092), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    var locationManager: CLLocationManager?
    
    func checklocationAuthorization(){
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus{
            
      
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Location is restricted.")
        case .denied:
            print("Location access is denided.")
        case .authorizedAlways:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            
        case .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        @unknown default:
            break
        }

        
        
    }
    
    func checkLocationServiceIsEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        }else {
            print("Location sharing is not enabled yet")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager){
        checklocationAuthorization()
    }
}
