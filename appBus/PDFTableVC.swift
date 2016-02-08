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
    
    //load stuff from PDFsSaved
    
    func readPDFsSaved(PDFSID: String) -> Bool {
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
            
            let entity =  NSEntityDescription.entityForName("PDFsSaved", inManagedObjectContext:managedContext)
            
            let LineKey = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
            
            for IDLine in listLinesID {
                
                LineKey.setValue(false, forKey: "Line" + IDLine)
            
            }
            
            do {
                //save
                try managedContext.save()
                
                //reload
                let results = try managedContext.executeFetchRequest(fetchRequest)
                PDFList = results as! [NSManagedObject]
            } catch let error as NSError  {
                print("Could not save and reload \(error), \(error.userInfo)")
            }
            
            print(PDFList)
        }
        
        let PDFSKey = "Line" + PDFSID
        var finalBool = Bool()
        
        for PDFListObject in PDFList as [NSManagedObject] {
            if let PDFListObjectBool = PDFListObject.valueForKey(PDFSKey) as? Bool {
                finalBool = PDFListObjectBool
            }
        }
        print(PDFList)
        return finalBool
    }
    
    //save stuff in PDFsSaved
    
    func savePDFsSaved(PDFSID: String, keyBoolean: Bool) {
        //call appDelegate
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //call managedObject
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entityForName("PDFsSaved", inManagedObjectContext:managedContext)
        
        let LineKey = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        //set PDFSKey

        let PDFSKey = "Line" + PDFSID
        
        LineKey.setValue(keyBoolean,forKey: PDFSKey)
        
        //save
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        print("set \(PDFSKey) to \(keyBoolean)")
    }
    
    //check and get PDF local link
    
    func getPDFLink(numberLine: String, pLine: String) -> NSURL {
        let fm = NSFileManager.defaultManager()
        let path = NSBundle.mainBundle().resourcePath!
        let items = try! fm.contentsOfDirectoryAtPath(path)
        print("items :")
        print(items)
        let docURL = ((NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)).last as NSURL!)//.URLByAppendingPathComponent("PDFs/")
        print("docURL :")
        print(docURL)
        let searchPrefix = "L" + String(format: "%03d", Int(numberLine)!) + "_" + pLine
        print(searchPrefix)
        var finalURL = NSURL()
        
        for item in items {
            if item.hasPrefix(searchPrefix) {
                finalURL = NSURL(fileURLWithPath: item, relativeToURL: docURL)
            }
        }
        return finalURL
    }
    
    //envoie sur le PDFDetailViewController (segue)

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                //set localPDFLink
                var localPDFLink = NSURL()
                
                //set parameters for the link
                var serverP = ""
                var serverID = ""
                
                if (listLinesID[indexPath.row].rangeOfString("vac") != nil) {
                    serverP = "vac"
                    serverID = listLinesID[indexPath.row].stringByReplacingOccurrencesOfString("vac", withString: "")
                } else if (listLinesID[indexPath.row].rangeOfString("nuit") != nil) {
                    serverP = "nuit"
                    serverID = listLinesID[indexPath.row].stringByReplacingOccurrencesOfString("nuit", withString: "")
                } else {
                    serverID = listLinesID[indexPath.row]
                }

                
                //check if line was already saved
                let isLineSaved = readPDFsSaved(listLinesID[indexPath.row])
                print(isLineSaved)
                if isLineSaved == false {
                    
                    //get pdf link
                    //let URL = NSURL(string: "http://envibus.kyrandia.org/PDFs/?id=" + serverID + "&p=" + serverP)
                    let URL = NSURL(string: "http://envibus.kyrandia.org/PDFs/L001_PS_janv16.pdf")
                    print("url is \(URL)")
                        
                    HttpDownloader.loadFileAsync(URL!, completion: {(path: String, error: NSError!) in
                        
                        print("pdf downloaded in \(path)")
                        self.savePDFsSaved(self.listLinesID[indexPath.row], keyBoolean: true)
                            
                        //Get the local PDF directory
                        localPDFLink = self.getPDFLink(serverID, pLine: serverP)
                            
                        /*let filePath = NSBundle.mainBundle().pathForResource("L001_PS_janv16", ofType:"pdf")
                        let data = NSData(contentsOfFile:filePath!)
                        print(filePath)
                        print(data)*/
                        print(NSURL(string: path))
                        //envoyer le path du pdf
                        PDFDetailViewController().PDFDetail = NSURL(string: path)
                        
                    })
                    //if isLineSaved == true
                } else {
                    //Get the local PDF directory
                    localPDFLink = self.getPDFLink(serverID, pLine: serverP)
                    
                    print(localPDFLink)
                    //envoyer le path du pdf
                    PDFDetailViewController().PDFDetail = localPDFLink
                }
            }
        }
    }
    
}
