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
        let cell = tableView.dequeueReusableCellWithIdentifier("lineCell", forIndexPath: indexPath)
        
        cell.textLabel!.text = "\(listArretStr[indexPath.row])"
        cell.textLabel!.font = UIFont(name: global.mainFont, size: 25)
        
        return cell
    }


    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
