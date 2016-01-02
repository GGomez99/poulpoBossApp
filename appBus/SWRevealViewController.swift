//
//  SWRevealViewController.swift
//  appBus
//
//  Created by Guyllian Gomez on 02/01/16.
//  Copyright © 2016 Guyllian Gomez. All rights reserved.
//

import UIKit

class SWRevealViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //fix bug interaction menu/tableView
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.revealViewController().view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.revealViewController().frontViewController.revealViewController().tapGestureRecognizer()
        self.revealViewController().frontViewController.view.userInteractionEnabled = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.revealViewController().frontViewController.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.revealViewController().frontViewController.view.userInteractionEnabled = true
    }

}
