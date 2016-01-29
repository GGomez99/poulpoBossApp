//
//  PDFTableVC.swift
//  appBus
//
//  Created by Guyllian Gomez on 01/01/16.
//  Copyright © 2016 Guyllian Gomez. All rights reserved.
//

import UIKit
import CoreData

class PDFTableVC: UITableViewController {
    
    var listLinesStr: [String] = ELine.getListOfLines()
    var listLinesID: [String] = ELine.getListOfLinesNo()
    
    //initialize coredata
    var PDFList = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add button menu
        let menuButtonImage = UIImage(named: "menubuttonV2")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuButtonImage, style: .Plain, target: self.revealViewController(), action: "revealToggle:")
        navigationItem.leftBarButtonItem?.tintColor = g.mainColorFont
        
        //définie le style du title
        let navbarFont = UIFont(name: g.mainFont, size: 25) ?? UIFont.systemFontOfSize(25)
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: navbarFont, NSForegroundColorAttributeName: UIColor(hue: 0.905, saturation: 0.88, brightness: 0.78, alpha: 1)]
        navigationController?.navigationBar.barTintColor = UIColor(hue: 312/359, saturation: 10/100, brightness: 95/100, alpha: 1)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    //number of cells
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listLinesStr.count
    }

    //edit cells
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("lineCell", forIndexPath: indexPath)

        cell.textLabel!.text = "\(listLinesStr[indexPath.row])"
        cell.textLabel!.font = UIFont(name: g.mainFont, size: 25)

        return cell
    }
    
    func readPDFsSaved() -> [NSManagedObject] {
        //call appDelegate
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //call managedObject
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "PDFsSaved")
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            PDFList = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        //set to false if empty
        if (PDFList == []) {
        }
        
        
        return PDFList
    }
    
    
    //envoie sur le PDFDetailViewController (segue)

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                

                //initialize stuff
                
                var PDFList = [NSManagedObject]()
                
                //call appDelegate
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                
                //call managedObject
                let managedContext = appDelegate.managedObjectContext
                
                
                //write PDFsSaved
                
                //set entity
                let entity =  NSEntityDescription.entityForName("PDFsSaved", inManagedObjectContext:managedContext)
                
                let Line9 = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
                
                Line9.setValue(false, forKey: "Line9")
                
                do {
                    try managedContext.save()
                    
                    PDFList.append(Line9)
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                }
                
                
                
                //read PDFsSaved
                
                let fetchRequest = NSFetchRequest(entityName: "PDFsSaved")
                do {
                    let results = try managedContext.executeFetchRequest(fetchRequest)
                    PDFList = results as! [NSManagedObject]
                } catch let error as NSError {
                    print("Could not fetch \(error), \(error.userInfo)")
                }
                
                if (PDFList == []) {
                }
                
                print(PDFList)
                
                
                //envoyer le path du pdf (temporaire)
                PDFDetailViewController().PDFDetail = "\(NSBundle.mainBundle().resourcePath!)/ligne9.pdf"
                
            }
        }
    }
    
}
