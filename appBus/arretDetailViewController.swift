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
    var numberOfCells = 1
    var horaireArret: Arret = Arret(name: "",horaires:[])
    var horaireGet: Bool = false
    @IBOutlet var lineTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view loaded")		
        
        //définie le style du title
        let navbarFont = UIFont(name: global.mainFont, size: 25) ?? UIFont.systemFontOfSize(25)
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navbarFont, NSForegroundColorAttributeName: UIColor(hue: 0.905, saturation: 0.88, brightness: 0.78, alpha: 1)]
        navigationController?.navigationBar.barTintColor = UIColor(hue: 312/359, saturation: 10/100, brightness: 95/100, alpha: 1)
        
        //Sort alphabetically ListOfArret
        listOfArret.sortInPlace(){ $0 < $1 }
        
        //set title view
        self.title = self.listOfArret[arretsTableVC.indexPath]
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)) { [unowned self] in
            
            print(self.listOfArret)
            print(self.listOfArret[arretsTableVC.indexPath])
            
        //Request to Adrien
            self.horaireArret = IOAPI.getTime(self.listOfArret[arretsTableVC.indexPath])
            
            print(self.horaireArret)
        //Set number of cells
            self.numberOfCells = self.horaireArret.horaires.count

        
        //Refresh the TableView
            
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                self.horaireGet = true
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
        
        if horaireGet == false {
            
            //set visible loading icon
            cell.loadingIcon.alpha = CGFloat(1)
            
            //Set labels invisible when loading
            cell.DirectionLabel.alpha = CGFloat(0)
            cell.viaLabel.alpha = CGFloat(0)
            cell.passage1label.alpha = CGFloat(0)
            cell.passage2label.alpha = CGFloat(0)
            cell.lineNumber.alpha = CGFloat(0)
            cell.versLabel.alpha = CGFloat(0)
            cell.viaPrefixeLabel.alpha = CGFloat(0)
        } else {
            
            //set invisible loading icon
            cell.loadingIcon.alpha = CGFloat(0)
            
            //set labels visible
            cell.DirectionLabel.alpha = CGFloat(1)
            cell.viaLabel.alpha = CGFloat(1)
            cell.passage1label.alpha = CGFloat(1)
            cell.passage2label.alpha = CGFloat(1)
            cell.lineNumber.alpha = CGFloat(1)
            cell.versLabel.alpha = CGFloat(1)
            cell.viaPrefixeLabel.alpha = CGFloat(1)
            
            //Edit the line Number
            cell.lineNumber.text = ELine.listOflineNo[horaireArret.horaires[indexPath.row].line]
            cell.lineNumber.font = UIFont(name: global.mainFont, size: 40)
        
            //Edit next bus stops

            cell.passage1label.text = "Passage : " + horaireArret.horaires[indexPath.row].time0 + " min"
        
            cell.passage2label.text = " puis " + horaireArret.horaires[indexPath.row].time1 + " min"
        
            if horaireArret.horaires[indexPath.row].time0 == horaireArret.horaires[indexPath.row].time1 {
                cell.passage2label.text = " "
            }
            
            //Edit the Via Label
            cell.viaLabel.text = "\(horaireArret.horaires[indexPath.row].via)\n"
            if cell.viaLabel == " " {
                //cell.viaLabel == cell.passage1label.text! + cell.passage2label.text!
            }
            
            //Edit Direction Label
            cell.DirectionLabel.text = horaireArret.horaires[indexPath.row].direction
        
            //Edit line Image
            cell.lineImage.image = UIImage(named: "line\(ELine.listOflineNo[horaireArret.horaires[indexPath.row].line]!)")
        }
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
