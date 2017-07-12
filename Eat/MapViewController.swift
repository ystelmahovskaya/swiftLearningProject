//
//  MapViewController.swift
//  Eat
//
//  Created by Yuliia Stelmakhovska on 2017-07-02.
//  Copyright © 2017 Yuliia Stelmakhovska. All rights reserved.
//

import UIKit
import MapKit

//MKMapViewDelegate protocol to show image in annotation
class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    //! restaurant exists if vi reached this page
    
    var restaurant : Restaurant!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MKMapViewDelegate protocol require , этот класс сам реализовывает методы делегата mapview
        mapView.delegate = self

        //Core location converts text format to latitude and longitude and revert
        let geocoder = CLGeocoder()
        //placemarks array of addresses
        geocoder.geocodeAddressString(restaurant.location!) { (placemarks, error) in
            //if there is no erreors code runs else return
            guard error == nil else { return }
            //извлекаем опциональный массив в константу placemarks если он не nil
            guard let placemarks = placemarks else { return }
            let placemark = placemarks.first!
            //размещает табл с адресом
            let annotation = MKPointAnnotation()
            annotation.title = self.restaurant.name
            annotation.subtitle = self.restaurant.type
            
            guard let location = placemark.location else { return }
            annotation.coordinate = location.coordinate
            //отображение
            self.mapView.showAnnotations([annotation], animated: true)
            self.mapView.selectAnnotation(annotation, animated: true)
            
            
        }
        // Do any additional setup after loading the view.
    }

    //add image to map
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // check if it is our annotation
        guard !(annotation is MKUserLocation) else {return nil}
        
        let annotationIdentifier = "restAnnotation"
        //повторно использует уже созданные ярлыки MKPinAnnotationView, MKAnnotationView = without pin
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? MKPinAnnotationView
        //если не получилось повторно использовать созд новый
        if annotationView == nil {
        annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
           
            //отображ доп инфо в аннотации
            annotationView?.canShowCallout = true
        }
        //созд рамку
        let rightImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        rightImage.image = UIImage(data: restaurant.image! as Data)
        annotationView?.rightCalloutAccessoryView = rightImage
        
        annotationView?.pinTintColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        return annotationView
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
