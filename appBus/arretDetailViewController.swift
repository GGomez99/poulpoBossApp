//
//  arretDetailViewController.swift
//  appBus
//arret.horaire,count
//Arret.horaire[numérocell]
//  Created by Clement ROIG on 08/02/2016.
//  Copyright © 2016 Guyllian Gomez. All rights reserved.
//

import UIKit

class arretDetailViewController: UITableViewController {
    
    var listOfArret: [String] = IOAPI.getListOfArret()
    var arretNumber = arretsTableVC.indexPath
    var numberOfCells = 0
    var horaireArret: Arret = Arret(name: "",horaires:[])
    
    override func viewDidLoad() {
        super.viewDidLoad()
          dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)) { [unowned self] in
            
        //Défninir le nombre de cells
            self.horaireArret = IOAPI.getTime(self.listOfArret[arretsTableVC.indexPath])
            self.numberOfCells = self.horaireArret.horaires.count
        }
        
        //Refresh the TableView
        dispatch_async(dispatch_get_main_queue()) { [unowned self] in
            self.refreshControl
        }
    }
    
        //Number of cells
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numberOfCells
    }
        // Configure the cell...
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "arretTableVCCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! arretTableVCCell
        
        cell.lineNumber.text = ELine.listOflineNo[horaireArret.horaires[indexPath.row].line]
        cell.lineNumber.font = UIFont(name: global.mainFont, size: 12)
        
        cell.viaLabel.text = horaireArret.horaires[indexPath.row].via
        
        cell.passage1label.text = horaireArret.horaires[indexPath.row].time0
        
        cell.passage2label.text = horaireArret.horaires[indexPath.row].time1
        
        cell.DirectionLabel.text = horaireArret.horaires[indexPath.row].direction
        
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
