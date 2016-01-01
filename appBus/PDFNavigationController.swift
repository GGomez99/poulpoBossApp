//
//  PDFViewController.swift
//  appBus
//
//  Created by Guyllian Gomez on 01/01/16.
//  Copyright © 2016 Guyllian Gomez. All rights reserved.
//

import UIKit

class PDFNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set l'action du bouton menu
        //menu.target = self.revealViewController()
        //menu.action = Selector("revealToggle:")
        
        //définie le style du title
        let navbarFont = UIFont(name: "Century Gothic", size: 25) ?? UIFont.systemFontOfSize(25)
        
        
        //.titleTextAttributes = [NSFontAttributeName: navbarFont, NSForegroundColorAttributeName: UIColor(hue: 0.905, saturation: 0.88, brightness: 0.78, alpha: 1)]
        
        //permet d'accéder au menu en swipant
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}
