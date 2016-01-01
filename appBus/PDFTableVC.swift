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


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listLines.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("lineCell", forIndexPath: indexPath)

        cell.textLabel!.text = "Ligne \(listLines[indexPath.row])"
        cell.textLabel!.font = UIFont(name: g.mainFont, size: 25)

        return cell
    }
    

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
