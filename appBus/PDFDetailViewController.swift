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

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var loadingIcon: UIActivityIndicatorView!
    
    var listLinesID: [String] = ELine.getListOfLinesNo()
    
    //initialize coredata
    var PDFList = [NSManagedObject]()
    
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
            
        }
        
        let PDFSKey = "Line" + PDFSID
        var finalBool = Bool()
        
        for PDFListObject in PDFList as [NSManagedObject] {
            if let PDFListObjectBool = PDFListObject.valueForKey(PDFSKey) as? Bool {
                finalBool = PDFListObjectBool
            }
        }
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

        var directoryContents = [NSURL]()
        
        let documentsUrl =  NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
        do {
            directoryContents = try NSFileManager.defaultManager().contentsOfDirectoryAtURL(documentsUrl, includingPropertiesForKeys: nil, options: NSDirectoryEnumerationOptions())
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        let searchPrefix = "/" + numberLine + "_" + pLine + ".pdf"
        print(searchPrefix)
        var finalURL = NSURL()
        
        for url in directoryContents {
            let urlString = "\(url)"
            if (urlString.rangeOfString(searchPrefix) != nil) {
                finalURL = url
            }
        }
        return finalURL
    }
    
    //load PDF in WebView
    
    func loadPDF() {
        //set loading icon visible and webview invisible
        webView.alpha = CGFloat(0)
        loadingIcon.alpha = CGFloat(1)
        
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
            serverP = "PS"
            serverID = listLinesID[PDFTableVC.indexPath]
        }
        
        
        //check if line was already saved
        let isLineSaved = readPDFsSaved(listLinesID[PDFTableVC.indexPath])
        
        if isLineSaved == false {
            
            //get pdf link
            let URL = NSURL(string: "http://envibus.kyrandia.org/" + serverID + "_" + serverP + ".pdf")
            print("url is \(URL)")
            
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)) { [unowned self] in
                HttpDownloader.loadFileAsync(URL!, completion: {(path: String, error: NSError!) in
                    
                    self.savePDFsSaved(self.listLinesID[PDFTableVC.indexPath], keyBoolean: true)
                    
                    //Get the local PDF directory
                    localPDFLink = self.getPDFLink(serverID, pLine: serverP)
                    
                    print(NSURL(string: path))
                    
                    //load pdf
                    print(localPDFLink)
                    dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                        
                        //set loading icon invisible
                        self.loadingIcon.alpha = CGFloat(0)
                        
                        //load PDF on webview
                        self.webView.loadRequest(NSURLRequest(URL: localPDFLink))
                        
                        //set webview visible
                        self.webView.alpha = CGFloat(1)
                    }
                })
            }
            //if isLineSaved == true
        } else {
            //Get the local PDF directory
            localPDFLink = self.getPDFLink(serverID, pLine: serverP)
            
            print(localPDFLink)
            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                
                //set loading icon invisible and webview visible
                self.loadingIcon.alpha = CGFloat(0)
                
                //load PDF on webview
                self.webView.loadRequest(NSURLRequest(URL: localPDFLink))
                
                //set webview visible
                self.webView.alpha = CGFloat(1)
            }
        }
    }
    
    func reloadPDF() {
        
        //set loading icon visible and webview invisible
        webView.alpha = CGFloat(0)
        loadingIcon.alpha = CGFloat(1)
        
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
            serverP = "PS"
            serverID = listLinesID[PDFTableVC.indexPath]
        }
        
        //check if line was already saved
        let isLineSaved = readPDFsSaved(listLinesID[PDFTableVC.indexPath])
        
        if isLineSaved == false {
            
            //get pdf link
            let URL = NSURL(string: "http://envibus.kyrandia.org/" + serverID + "_" + serverP + ".pdf")
            print("url is \(URL)")
            
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)) { [unowned self] in
                HttpDownloader.loadFileAsync(URL!, completion: {(path: String, error: NSError!) in
                    
                    self.savePDFsSaved(self.listLinesID[PDFTableVC.indexPath], keyBoolean: true)
                    
                    //Get the local PDF directory
                    localPDFLink = self.getPDFLink(serverID, pLine: serverP)
                    
                    print(NSURL(string: path))
                    
                    //load pdf
                    print(localPDFLink)
                    dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                        
                        //set loading icon invisible
                        self.loadingIcon.alpha = CGFloat(0)
                        
                        //load PDF on webview
                        self.webView.loadRequest(NSURLRequest(URL: localPDFLink))
                        
                        //set webview visible
                        self.webView.alpha = CGFloat(1)
                    }
                })
            }
            //if isLineSaved == true
        } else {
            //Get the local PDF directory
            localPDFLink = self.getPDFLink(serverID, pLine: serverP)
            
            //delete PDF
            do {
                try NSFileManager.defaultManager().removeItemAtPath("\(localPDFLink)".stringByReplacingOccurrencesOfString("file:///private", withString: ""))
            } catch let error as NSError {
                print("error while deleting: \(error)")
            }
            print(localPDFLink)
            
            //download PDF
            let URL = NSURL(string: "http://envibus.kyrandia.org/" + serverID + "_" + serverP + ".pdf")
            print("url is \(URL)")
            
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)) { [unowned self] in
                HttpDownloader.loadFileAsync(URL!, completion: {(path: String, error: NSError!) in
                    
                    self.savePDFsSaved(self.listLinesID[PDFTableVC.indexPath], keyBoolean: true)
                    
                    //Get the local PDF directory
                    localPDFLink = self.getPDFLink(serverID, pLine: serverP)
                    
                    print(NSURL(string: path))
                    
                    //load pdf
                    print(localPDFLink)
                    dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                        
                        //set loading icon invisible
                        self.loadingIcon.alpha = CGFloat(0)
                        
                        //load PDF on webview
                        self.webView.loadRequest(NSURLRequest(URL: localPDFLink))
                        
                        //set webview visible
                        self.webView.alpha = CGFloat(1)
                    }
                })
            }
        }

    }
    
    //refresh PDF when button activated
    
    @IBAction func Refresh(sender: AnyObject) {
        reloadPDF()
    }
    
    //give PDF to WK to load it
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPDF()
    }

}
