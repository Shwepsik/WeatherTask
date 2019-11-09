//
//  ViewController.swift
//  WeatherTask
//
//  Created by Valerii on 11/9/19.
//  Copyright © 2019 Valerii. All rights reserved.
//

import UIKit
import Mapbox

class MapViewController: UIViewController {
    
    var mapModel: MapModel!
    @IBOutlet weak var mapView: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let requestController = RequestController()
        let mapModel = MapModel(dataFetcher: requestController)
        self.mapModel = mapModel
        mapView.delegate = self
        addGestureRecognizer()
    }
    
    
    private func addGestureRecognizer() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(sender:)))
        for recognizer in mapView.gestureRecognizers! where recognizer is UITapGestureRecognizer {
            singleTap.require(toFail: recognizer)
        }
        mapView.addGestureRecognizer(singleTap)
    }
    
    
    @objc func handleMapTap(sender: UITapGestureRecognizer) {
        let tapPoint: CGPoint = sender.location(in: mapView)
        let tapCoordinate: CLLocationCoordinate2D = mapView.convert(tapPoint, toCoordinateFrom: nil)
        mapModel.loadWeatherDescriptions(lat: tapCoordinate.latitude, lon: tapCoordinate.longitude) { (model) in
            let popup: DescriptionPopup = DescriptionPopup.create()
            popup.countryLabel.text = model.country
            popup.descriptionLabel.text = model.description
            popup.humidityLabel.text = String(model.humidity)
            popup.pressureLabel.text = String(model.pressure)
            popup.regionLabel.text = model.name
            popup.temperatureLabel.text = String(model.temp)
            popup.show()
        }
    }
}

extension MapViewController: MGLMapViewDelegate {
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        let coordinate = CLLocationCoordinate2DMake(48.45, 34.98333)
        mapView.setCenter(coordinate, zoomLevel: 9, direction: 0, animated: false) {
            let camera = MGLMapCamera(lookingAtCenter: coordinate, altitude: 20000, pitch: 15, heading: 0)
            self.mapView.setCamera(camera, withDuration: 3, animationTimingFunction: CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn))
        }
    }
}

