//
//  PDFDetailViewController.swift
//  appBus
//
//  Created by Guyllian Gomez on 01/01/16.
//  Copyright © 2016 Guyllian Gomez. All rights reserved.
//

import UIKit
import WebKit
import CoreData

class PDFDetailViewController: UIViewController {
    
    var webView: WKWebView!
    var listLinesID: [String] = ELine.getListOfLinesNo()
    
    //initialize coredata
    var PDFList = [NSManagedObject]()
    
    //load WK
    override func loadView() {
        webView = WKWebView()
        view = webView
        
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
    
    //give PDF to WK to load it
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //set localPDFLink
        var localPDFLink = NSURL()
        
        //set parameters for the link
        var serverP = ""
        var serverID = ""
        
        if (listLinesID[PDFTableVC.indexPath].rangeOfString("vac") != nil) {
            serverP = "vac"
            serverID = listLinesID[PDFTableVC.indexPath].stringByReplacingOccurrencesOfString("vac", withString: "")
        } else if (listLinesID[PDFTableVC.indexPath].rangeOfString("nuit") != nil) {
            serverP = "nuit"
            serverID = listLinesID[PDFTableVC.indexPath].stringByReplacingOccurrencesOfString("nuit", withString: "")
        } else {
            serverID = listLinesID[PDFTableVC.indexPath]
        }
        
        
        //check if line was already saved
        let isLineSaved = readPDFsSaved(listLinesID[PDFTableVC.indexPath])
        print(isLineSaved)
        if isLineSaved == false {
            
            //get pdf link
            //let URL = NSURL(string: "http://envibus.kyrandia.org/PDFs/?id=" + serverID + "&p=" + serverP)
            let URL = NSURL(string: "http://envibus.kyrandia.org/PDFs/L001_PS_janv16.pdf")
            print("url is \(URL)")
            
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)) { [unowned self] in
                HttpDownloader.loadFileSync(URL!, completion: {(path: String, error: NSError!) in
                
                    print("pdf downloaded in \(path)")
                    self.savePDFsSaved(self.listLinesID[PDFTableVC.indexPath], keyBoolean: true)
                
                    //Get the local PDF directory
                    localPDFLink = self.getPDFLink(serverID, pLine: serverP)
                
                    /*let filePath = NSBundle.mainBundle().pathForResource("L001_PS_janv16", ofType:"pdf")
                    let data = NSData(contentsOfFile:filePath!)
                    print(filePath)
                    print(data)*/
                    print(NSURL(string: path))
                    
                    //load pdf
                    let finalRequest = NSURLRequest(URL: NSURL(string: path)!)
                    print(finalRequest)
                    dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                        self.webView.loadRequest(finalRequest)
                    }
                })
            }
            //if isLineSaved == true
        } else {
            //Get the local PDF directory
            localPDFLink = self.getPDFLink(serverID, pLine: serverP)
            
            print(localPDFLink)
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                self.webView.loadRequest(NSURLRequest(URL: localPDFLink))
            }
        }
        
    }

}
