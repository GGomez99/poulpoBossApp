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
    @IBOutlet var lineTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view loaded")
        
        //set title view
        self.title = self.listOfArret[arretsTableVC.indexPath]
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)) { [unowned self] in
            
        //Request to Adrien
            self.horaireArret = IOAPI.getTime(self.listOfArret[arretsTableVC.indexPath])
            print("get horaires arret : \(self.horaireArret)")
            print("choubidou" + self.listOfArret[arretsTableVC.indexPath])
        //Set number of cells
            self.numberOfCells = self.horaireArret.horaires.count
        
        //Refresh the TableView
            
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                self.lineTableView.reloadData()
                print("refresh tableview")
            }
        }
    }
    
        //Number of cells
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("setting number of cells to \(numberOfCells)")
        return numberOfCells
    }
        // Configure the cell...
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "arretTableVCCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! arretTableVCCell
        var minuteP1 = " minutes"
        var minuteP2 = " minutes"
        
        
        cell.lineNumber.text = ELine.listOflineNo[horaireArret.horaires[indexPath.row].line]
        cell.lineNumber.font = UIFont(name: global.mainFont, size: 40)
        
        cell.viaLabel.text = horaireArret.horaires[indexPath.row].via
        
        if horaireArret.horaires[indexPath.row].time0 == "1" {
            minuteP1 = " minute"
        }
        cell.passage1label.text = "Passage dans : " + horaireArret.horaires[indexPath.row].time0 + minuteP1
        
        if horaireArret.horaires[indexPath.row].time1 == "1" {
            minuteP2 = " minute"
        }
        cell.passage2label.text = "Prochain passage dans : " + horaireArret.horaires[indexPath.row].time1 + minuteP2
        
        if horaireArret.horaires[indexPath.row].time0 == horaireArret.horaires[indexPath.row].time1 {
            cell.passage2label.text = "Pas de prochain passage"
        }
        cell.DirectionLabel.text = horaireArret.horaires[indexPath.row].direction
        
        cell.lineImage.image = UIImage(named: "line\(ELine.listOflineNo[horaireArret.horaires[indexPath.row].line]!)")
        
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
