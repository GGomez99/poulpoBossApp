//
//  ViewController.swift
//  Interface First try
//
//  Created by Guyllian Gomez on 10/12/2015.
//  Copyright © 2015 Guyllian Gomez. All rights reserved.
//

import UIKit

class accueilVC: UIViewController {
    
    @IBOutlet weak var menu: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        menu.target = self.revealViewController()
        menu.action = Selector("revealToggle:")
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.navigationController?.navigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

