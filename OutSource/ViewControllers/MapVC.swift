//
//  MapVC.swift
//  OutSource
//
//  Created by JoeB on 7/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

import Foundation
import MapKit
import Material
import UIKit
import CoreLocation
import Firebase

class MapVC: UIViewController, CLLocationManagerDelegate {
    
    //THESE ARE FOR THE MENU
    // MenuView reference.
    private lazy var menuView: MenuView = MenuView()
    
    // Default spacing size
    let spacing: CGFloat = 16
    
    // Diameter for FabButtons.
    let diameter: CGFloat = 56
    
    // Height for FlatButtons.
    let height: CGFloat = 36
    
    //The map view
    @IBOutlet weak var map: MKMapView!
    
    //Firebase helper
    let firebaseHelper = FirebaseHelper()
    
    //Posts we will load
    var posts = [Post]()
    
    //the current user
    var user = User(email: nil, userName: nil, UID: nil, interests: nil, blocked: nil)
    
    //the location contoller
    var locationManager: CLLocationManager!
    
    //Where creating the posts happens
    override func viewDidLoad(){
        super.viewDidLoad()
    
        prepareMenuView()
        self.map.delegate = self
        
        // set up the location services
        if (CLLocationManager.locationServicesEnabled()){
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            
            map.showsUserLocation = true
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        print("view loaded")
        
        self.map.removeAnnotations(map.annotations)
        
        self.firebaseHelper.currentUser { user in
            
            self.firebaseHelper.loadPosts(user){ post in
                
                // Download i post image
                self.firebaseHelper.storageRef.child(post.imageID!).dataWithMaxSize(1 * 6000 * 6000) { (data, error) -> Void in
                    if (error != nil) {
                        print(error?.description)
                    } else {
                        
                        print("image downloaded")
                        
                        let pin = PostAnnotation(post: post, image: UIImage(data: data!)!)
                        
                        pin.coordinate = CLLocationCoordinate2D(latitude: Double(post.latitude!)!, longitude: Double(post.longitude!)!)
                        pin.title = post.title!
                        pin.subtitle = post.interest!
                        
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            //self.map.viewForAnnotation(pin)
                            self.map.addAnnotation(pin)
                        })
                    }
                }
            }
        }
    }
    
    //Location zoom function
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.11, longitudeDelta: 0.11))
        
        self.map.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()

        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("ERROR")
    }
    
    //Handles the button on the annotations
    func displayPostDetail(sender: PostButton){
        print(sender.post?.title!)
        performSegueWithIdentifier("mapToDetailSegue", sender: sender)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "mapToDetailSegue" {
                
                let navController = segue.destinationViewController as! UINavigationController
                let detailController = navController.topViewController as! PostDetailVC
                detailController.post = (sender as!  PostButton).post!
            }
        }
    }
    
    
    
}

//Stuff for buttons and annotations
extension MapVC: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? PostAnnotation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation , reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                
                let btn = PostButton(type: .InfoLight)
                btn.post = annotation.post
                btn.tintColor = UIColor.init(red: 0, green: 0, blue: 100, alpha: 1.0)
                btn.addTarget(self, action: #selector(displayPostDetail), forControlEvents: .TouchUpInside)
                view.rightCalloutAccessoryView = btn
                
//                let imageView = UIImageView()
//                imageView.image = annotation.image
//                view.leftCalloutAccessoryView = imageView
                
            }
            return view
        }
        return nil
    }
    
    
}

//MARK: THIS EXTENSION HANDLES THE MENU
extension MapVC {
    
    /// Handle the menuView touch event.
    internal func handleMenu() {
        if menuView.menu.opened {
            menuView.menu.close()
            (menuView.menu.views?.first as? MaterialButton)?.animate(MaterialAnimation.rotate(rotation: 0))
        } else {
            menuView.menu.open() { (v: UIView) in
                (v as? MaterialButton)?.pulse()
            }
            (menuView.menu.views?.first as? MaterialButton)?.animate(MaterialAnimation.rotate(rotation: 0.125))
        }
    }
    
    /// Handle the menuView touch event.
    @objc(handleButton:)
    internal func handleButton(button: UIButton) {
        print("Hit Button \(button)")
    }
    
    /// Handles the location button.
    func goToCurrentLocation(){
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .NotDetermined, .Restricted, .Denied:
                print("No access")
            case .AuthorizedAlways, .AuthorizedWhenInUse:
                print("Access")
                locationManager.startUpdatingLocation()
            }
        } else {
            print("Location services are not enabled")
        }
        
    }
    
    func addLocationBtnTapped() {
        locationManager.stopUpdatingLocation()
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .NotDetermined, .Restricted, .Denied:
                print("No access")
            case .AuthorizedAlways, .AuthorizedWhenInUse:
                print("Access")
                performSegueWithIdentifier("mapToAddLocationSegue", sender: self)
            }
        } else {
            print("Location services are not enabled")
        }
        
    }
    
    func settingsBtnTapped(){
        performSegueWithIdentifier("mapToSettingsSegue", sender: self)
    }

    /// Prepares the MenuView example.
    private func prepareMenuView() {
        
        //MARK: first button
        var image: UIImage? = UIImage(named: "plusIcon")?.imageWithRenderingMode(.AlwaysTemplate)
        let btn1: FabButton = FabButton()
        btn1.depth = .None
        btn1.pulseOpacity = 0
        btn1.borderColor = MaterialColor.white
        btn1.backgroundColor = self.hexStringToUIColor("#40DE96")
        btn1.borderWidth = 1
        btn1.setImage(image, forState: .Normal)
        btn1.setImage(image, forState: .Highlighted)
        btn1.addTarget(self, action: #selector(handleMenu), forControlEvents: .TouchUpInside)
        menuView.addSubview(btn1)
        
        //MARK: second button (New Location)
        image = UIImage(named: "addPostIcon")?.imageWithRenderingMode(.AlwaysTemplate)
        let btn2: FabButton = FabButton()
        btn2.depth = .None
        btn2.pulseOpacity = 0
        btn2.borderColor = MaterialColor.white
        btn2.backgroundColor = self.hexStringToUIColor("#46F2AF")
        btn2.borderWidth = 1
        btn2.setImage(image, forState: .Normal)
        btn2.setImage(image, forState: .Highlighted)
        btn2.addTarget(self, action: #selector(addLocationBtnTapped), forControlEvents: .TouchUpInside)
        menuView.addSubview(btn2)
        
        //MARK: third button
        image = UIImage(named: "gearIcon")?.imageWithRenderingMode(.AlwaysTemplate)
        let btn3: FabButton = FabButton()
        btn3.depth = .None
        btn3.pulseOpacity = 0
        btn3.borderColor = MaterialColor.white
        btn3.backgroundColor = self.hexStringToUIColor("#46F2AF")
        btn3.borderWidth = 1
        btn3.setImage(image, forState: .Normal)
        btn3.setImage(image, forState: .Highlighted)
        btn3.addTarget(self, action: #selector(settingsBtnTapped), forControlEvents: .TouchUpInside)
        menuView.addSubview(btn3)
        
        //MARK: fourth button
        image = UIImage(named: "navIcon")?.imageWithRenderingMode(.AlwaysTemplate)
        let btn4: FabButton = FabButton()
        btn4.depth = .None
        btn4.pulseOpacity = 0
        btn4.borderColor = MaterialColor.white
        btn4.backgroundColor = self.hexStringToUIColor("#46F2AF")
        btn4.borderWidth = 1
        btn4.setImage(image, forState: .Normal)
        btn4.setImage(image, forState: .Highlighted)
        btn4.addTarget(self, action: #selector(goToCurrentLocation), forControlEvents: .TouchUpInside)
        menuView.addSubview(btn4)
        
        // Initialize the menu and setup the configuration options.
        menuView.menu.direction = .Up
        menuView.menu.baseSize = CGSizeMake(diameter, diameter)
        menuView.menu.views = [btn1, btn4, btn2, btn3]
        view.layout(menuView).width(diameter).height(diameter).bottom(16).right(5)
    }
}

//MARK: the color method
extension MapVC{
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.grayColor()
        }
        
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}




