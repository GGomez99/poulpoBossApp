//
//  arretsTableVC.swift
//  Interface First try
//
//  Created by Guyllian Gomez on 28/12/15.
//  Copyright © 2015 Guyllian Gomez. All rights reserved.
//

import UIKit

class arretsTableVC: UITableViewController {
    
    class arret: NSObject {
        let arretsList: String
        var section: Int?
        init(arretsList: String) {
            self.arretsList = arretsList
        }
    }
    class Section {
        var arrets: [arret] = []
        
        func addArret(Arret: arret) {
            self.arrets.append(Arret)
        }
    }

    var listArretStr : [String] = IOAPI.getListOfArret()
    internal static var indexPath: Int = 0
    
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

        //Use arret name to give the list of lines
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                print("set \(indexPath.row) à arretsTableVC.indexPath")
                print(sections)
                for indexPathSection in 0..<indexPath.section {
                    arretsTableVC.indexPath = arretsTableVC.indexPath + self.sections[indexPathSection].arrets.count
                    print("adding \(self.sections[indexPathSection].arrets.count) to arretsTableVC.indexPath")
                }
                arretsTableVC.indexPath = arretsTableVC.indexPath + indexPath.row
                print("arretTableVC.indexPath a été set à \(arretsTableVC.indexPath)")
            }
        }
    }
    // `UIKit` convenience class for sectioning a table
    let collation = UILocalizedIndexedCollation.currentCollation()
        as UILocalizedIndexedCollation
    
    // table sections
    var sections: [Section] {
        // return if already initialized
        if self._sections != nil {
            return self._sections!
        }
        
        let arrets: [arret] = listArretStr.map { arretsList in
            let Arret = arret(arretsList: arretsList)
            Arret.section = self.collation.sectionForObject(Arret, collationStringSelector: "arretsList")
            return Arret
        }
        
        // create empty sections
        var sections = [Section]()
        for _ in 0..<self.collation.sectionIndexTitles.count {
            sections.append(Section())
        }
        
        // put each Arret in a section
        for Arret in arrets {
            sections[Arret.section!].addArret(Arret)
        }
        
        // sort each section
        for section in sections {
            section.arrets = self.collation.sortedArrayFromArray(section.arrets, collationStringSelector: "arretsList") as! [arret]
        }
        
        self._sections = sections
        
        return self._sections!
        
    }
    var _sections: [Section]?
    
    // table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView)
        -> Int {
            return self.sections.count
    }
    
    override func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int)
        -> Int {
            return self.sections[section].arrets.count
    }
    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            let Arret = self.sections[indexPath.section].arrets[indexPath.row]
            
            let cell = tableView.dequeueReusableCellWithIdentifier("arretCell", forIndexPath: indexPath) as UITableViewCell
            cell.textLabel!.text = Arret.arretsList
            return cell
    }
    
    /* section headers
    appear above each `UITableView` section */
    override func tableView(tableView: UITableView,
        titleForHeaderInSection section: Int)
        -> String {
            // do not display empty `Section`s
            if !self.sections[section].arrets.isEmpty {
                return self.collation.sectionTitles[section] as String
            }
            return ""
    }
    
    /* section index titles
    displayed to the right of the `UITableView`*/
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
            return self.collation.sectionIndexTitles
    }
    
    override func tableView(tableView: UITableView,
        sectionForSectionIndexTitle title: String,
        atIndex index: Int)
        -> Int {
            return self.collation.sectionForSectionIndexTitleAtIndex(index)
    }
}