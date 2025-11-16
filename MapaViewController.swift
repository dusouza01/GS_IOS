//
//  MapaViewController.swift
//  GS_IOS_Edu_Osvaldo
//
//  Created by Eduardo  Souza on 16/11/25.
//

import UIKit
import MapKit

class MapaViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: MKMapView!
        

    override func viewDidLoad() {
        super.viewDidLoad()
        let anotation = MKPointAnnotation()
        anotation.coordinate = CLLocationCoordinate2D(latitude: -22.9064, longitude: -43.1769)
        anotation.title = "Médico sem Fronteiras"
        mapView.addAnnotation(anotation)
        
        let region = MKCoordinateRegion(center: anotation.coordinate, latitudinalMeters: 360, longitudinalMeters: 360)
        mapView.setRegion(region, animated: true)
        

        // Do any additional setup after loading the view.
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
