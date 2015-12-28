//
//  ViewController.swift
//  Interface First try
//
//  Created by Guyllian Gomez on 10/12/2015.
//  Copyright © 2015 Guyllian Gomez. All rights reserved.
//

import UIKit

class accueilVC: UIViewController {
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var menu: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set l'action du bouton menu
        menu.target = self.revealViewController()
        menu.action = Selector("revealToggle:")
        
        //définie le style du title
        let navbarFont = UIFont(name: "Century Gothic", size: 25) ?? UIFont.systemFontOfSize(25)
        
        navBar.titleTextAttributes = [NSFontAttributeName: navbarFont, NSForegroundColorAttributeName: UIColor(hue: 0.905, saturation: 0.88, brightness: 0.78, alpha: 1)]
        
        //permet d'accéder au menu en swipant
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
