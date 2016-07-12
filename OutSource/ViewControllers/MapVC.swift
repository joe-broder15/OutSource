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

class MapVC: UIViewController {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //prepares the menu view
        prepareMenuViewExample()
        
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
    
    
    /// Prepares the MenuView example.
    private func prepareMenuViewExample() {
        
        //MARK: first button
        var image: UIImage? = UIImage(named: "ic_add_white")?.imageWithRenderingMode(.AlwaysTemplate)
        let btn1: FabButton = FabButton()
        btn1.depth = .None
        btn1.tintColor = MaterialColor.blue.accent3
        btn1.borderColor = MaterialColor.blue.accent3
        btn1.backgroundColor = MaterialColor.red.accent1
        btn1.borderWidth = 1
        btn1.setImage(image, forState: .Normal)
        btn1.setImage(image, forState: .Highlighted)
        btn1.addTarget(self, action: #selector(handleMenu), forControlEvents: .TouchUpInside)
        menuView.addSubview(btn1)
        
        //MARK: second button
        image = UIImage(named: "ic_create_white")?.imageWithRenderingMode(.AlwaysTemplate)
        let btn2: FabButton = FabButton()
        btn2.depth = .None
        btn2.tintColor = MaterialColor.blue.accent3
        btn2.pulseColor = MaterialColor.grey.base
        btn2.borderColor = MaterialColor.blue.accent3
        btn2.backgroundColor = MaterialColor.green.accent1
        btn2.borderWidth = 1
        btn2.setImage(image, forState: .Normal)
        btn2.setImage(image, forState: .Highlighted)
        btn2.addTarget(self, action: #selector(handleButton), forControlEvents: .TouchUpInside)
        menuView.addSubview(btn2)
        
        //MARK: third button
        image = UIImage(named: "ic_photo_camera_white")?.imageWithRenderingMode(.AlwaysTemplate)
        let btn3: FabButton = FabButton()
        btn3.depth = .None
        btn3.tintColor = MaterialColor.blue.accent3
        btn3.pulseColor = MaterialColor.grey.base
        btn3.borderColor = MaterialColor.blue.accent3
        btn3.backgroundColor = MaterialColor.blue.accent1
        btn3.borderWidth = 1
        btn3.setImage(image, forState: .Normal)
        btn3.setImage(image, forState: .Highlighted)
        btn3.addTarget(self, action: #selector(handleButton), forControlEvents: .TouchUpInside)
        menuView.addSubview(btn3)
        
        //MARK: fourth button
        image = UIImage(named: "ic_note_add_white")?.imageWithRenderingMode(.AlwaysTemplate)
        let btn4: FabButton = FabButton()
        btn4.depth = .None
        btn4.tintColor = MaterialColor.blue.accent3
        btn4.pulseColor = MaterialColor.grey.base
        btn4.borderColor = MaterialColor.blue.accent3
        btn4.backgroundColor = MaterialColor.yellow.accent1
        btn4.borderWidth = 1
        btn4.setImage(image, forState: .Normal)
        btn4.setImage(image, forState: .Highlighted)
        btn4.addTarget(self, action: #selector(handleButton), forControlEvents: .TouchUpInside)
        menuView.addSubview(btn4)
        
        //MARK: fifth button
        image = UIImage(named: "ic_note_add_white")?.imageWithRenderingMode(.AlwaysTemplate)
        let btn5: FabButton = FabButton()
        btn5.depth = .None
        btn5.tintColor = MaterialColor.blue.accent3
        btn5.pulseColor = MaterialColor.grey.base
        btn5.borderColor = MaterialColor.blue.accent3
        btn5.backgroundColor = MaterialColor.pink.accent1
        btn5.borderWidth = 1
        btn5.setImage(image, forState: .Normal)
        btn5.setImage(image, forState: .Highlighted)
        btn5.addTarget(self, action: #selector(handleButton), forControlEvents: .TouchUpInside)
        menuView.addSubview(btn5)
        
        // Initialize the menu and setup the configuration options.
        menuView.menu.direction = .Up
        menuView.menu.baseSize = CGSizeMake(diameter, diameter)
        menuView.menu.views = [btn1, btn2, btn3, btn4, btn5]
    
        view.layout(menuView).width(diameter).height(diameter).bottom(16).right(5)
    }

}