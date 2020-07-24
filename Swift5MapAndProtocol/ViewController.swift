//
//  ViewController.swift
//  Swift5MapAndProtocol
//
//  Created by Shota Ishii on 2020/07/24.
//  Copyright © 2020 is. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate,UIGestureRecognizerDelegate,SearchLocationDelegate {
    
    @IBOutlet var longPress: UILongPressGestureRecognizer!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locManager:CLLocationManager!
    
    @IBOutlet weak var adressLabel: UILabel!
    
    @IBOutlet weak var settingButton: UIButton!
    
    var adressString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingButton.backgroundColor = .white
        settingButton.layer.cornerRadius = 20.0
        
    }

    @IBAction func longPressTap(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began{
            //タップを開始したとき
            

        }else if sender.state == .ended{
            //タップを終了したとき
            //タップした位置を指定して、MKMapView上の経度、緯度を取得
            //緯度軽度から住所に変換
            
            let tapPoint = sender.location(in: view)
            
            //タップした位置(GCPoint)を指定してMKMapView上の緯度、軽度を取得する
            
            let center = mapView.convert(tapPoint, toCoordinateFrom: mapView)
            
            let lat = center.latitude
            let log = center.longitude
            
            convert(lat: lat, log: log)

        }
        
    }
    
    func convert(lat:CLLocationDegrees,log:CLLocationDegrees){
        
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: log)
        
        
        //クロージャー
        geocoder.reverseGeocodeLocation(location) { (placeMark,error) in
            
            if let placeMark = placeMark{
                
                if let pm = placeMark.first{
                    
                    if pm.administrativeArea != nil && pm.location != nil{
                        self.adressString = pm.name! + pm.administrativeArea! + pm.locality!
                    }else{
                        self.adressString = pm.name!
                    }
                    self.adressLabel.text = self.adressString
                }
            }
        }
    }
    
    
    @IBAction func gotoSearchVC(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"{
            let nextVC = segue.destination as! NextViewController
            nextVC.delegate = self
        }
    }
    
    func serchLocation(idoValue: String, keidoValue: String) {
        if idoValue.isEmpty != true && keidoValue.isEmpty != true{
            
            let idoString = idoValue
            let keidoString = keidoValue
            
            //緯度、軽度からコーディネイト
            let cordinate = CLLocationCoordinate2DMake(Double(idoString)!, Double(keidoString)!)
            
            //表示する範囲を指定
            
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            
            //領域を指定
            let region = MKCoordinateRegion(center: cordinate, span: span)

            //領域をmapViewに設定
            mapView.setRegion(region, animated: true)
            
            //緯度軽度から住所へ変換
            convert(lat: Double(idoString)!, log: Double(keidoString)!)
            
            //labalに表示
            adressLabel.text = adressString
            
        }else{
            adressLabel.text = "表示できません"
        }
    }
    
}

