//
//  PDFTableVC.swift
//  appBus
//
//  Created by Guyllian Gomez on 01/01/16.
//  Copyright © 2016 Guyllian Gomez. All rights reserved.
//

import UIKit

class PDFTableVC: UITableViewController {
    
    var listLines = ["1", "2", "30", "31"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add button menu
        let menuButtonImage = UIImage(named: "menubuttonV2")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuButtonImage, style: .Plain, target: self.revealViewController(), action: "revealToggle:")
        navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 198/255, green: 23/255, blue: 124/255, alpha: 1)
        
        //définie le style du title
        let navbarFont = UIFont(name: g.mainFont, size: 25) ?? UIFont.systemFontOfSize(25)
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navbarFont, NSForegroundColorAttributeName: UIColor(hue: 0.905, saturation: 0.88, brightness: 0.78, alpha: 1)]
        navigationController?.navigationBar.barTintColor = UIColor(hue: 312/359, saturation: 10/100, brightness: 95/100, alpha: 1)


        //permet d'accéder au menu en swipant
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    //number of cells
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listLines.count
    }

    //edit cells
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("lineCell", forIndexPath: indexPath)

        cell.textLabel!.text = "Ligne \(listLines[indexPath.row])"
        cell.textLabel!.font = UIFont(name: g.mainFont, size: 25)

        return cell
    }
    
    //envoie sur le PDFDetailViewController (segue)

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! PDFDetailViewController
                
                //envoyer le path du pdf (temporaire)
                controller.PDFDetail = "\(NSBundle.mainBundle().resourcePath!)/ligne9.pdf"
                
                //add button menu
                let menuButtonImage = UIImage(named: "menubuttonV2")
                controller.navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuButtonImage, style: .Plain, target: self.revealViewController(), action: "revealToggle:")
                controller.navigationItem.leftBarButtonItem?.tintColor = UIColor(red: 198/255, green: 23/255, blue: 124/255, alpha: 1)
                
                //définie le style du title
                let navbarFont = UIFont(name: g.mainFont, size: 25) ?? UIFont.systemFontOfSize(25)
                controller.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navbarFont, NSForegroundColorAttributeName: UIColor(hue: 0.905, saturation: 0.88, brightness: 0.78, alpha: 1)]
                controller.navigationController?.navigationBar.barTintColor = UIColor(hue: 312/359, saturation: 10/100, brightness: 95/100, alpha: 1)
            }
        }
    }
    
    //pour passer au PDFDEtailViewController
    
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    
}
