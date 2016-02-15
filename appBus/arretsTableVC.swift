//
//  arretsTableVC.swift
//  Interface First try
//
//  Created by Guyllian Gomez on 28/12/15.
//  Copyright © 2015 Guyllian Gomez. All rights reserved.
//

import UIKit

class arretsTableVC: UITableViewController {

    var listArretStr : [String] = IOAPI.getListOfArret()
    internal static var indexPath: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add button menu
        let menuButtonImage = UIImage(named: "menubuttonV2")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuButtonImage, style: .Plain, target: self.revealViewController(), action: "revealToggle:")
        navigationItem.leftBarButtonItem?.tintColor = global.mainColorFont
        
        //définie le style du title
        let navbarFont = UIFont(name: global.mainFont, size: 25) ?? UIFont.systemFontOfSize(25)
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navbarFont, NSForegroundColorAttributeName: UIColor(hue: 0.905, saturation: 0.88, brightness: 0.78, alpha: 1)]
        navigationController?.navigationBar.barTintColor = UIColor(hue: 312/359, saturation: 10/100, brightness: 95/100, alpha: 1)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //number of cells
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listArretStr.count
    }
    
    //edit cells
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("arretCell", forIndexPath: indexPath)
        
        cell.textLabel!.text = "\(listArretStr[indexPath.row])"
        cell.textLabel!.font = UIFont(name: global.mainFont, size: 25)
        
        return cell
    }
    //Use arret name to give the list of lines
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                arretsTableVC.indexPath = indexPath.row
            }
        }
    }
}