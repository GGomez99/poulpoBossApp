//
//  BackTableVC.swift
//  Interface First try
//
//  Created by Guyllian Gomez on 10/12/2015.
//  Copyright © 2015 Guyllian Gomez. All rights reserved.
//

import Foundation

class backTableVC: UITableViewController {
    
    var TableArray = [String]()
    var menuBGColor = UIColor(red: 231/255, green: 52/255, blue: 155/255, alpha: 1)
    
    
    override func viewDidLoad() {
        TableArray = ["Accueil", "Arrêts"]
        self.tableView.separatorColor = menuBGColor
        self.tableView.backgroundColor = menuBGColor
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TableArray[indexPath.row], forIndexPath: indexPath) as UITableViewCell
        
        //set nom de chaque cell
        cell.textLabel?.text = TableArray[indexPath.row]
        
        //set font de chaque cell
        let cellFont = UIFont(name: "Century Gothic", size: 25) ?? UIFont.systemFontOfSize(25)

        cell.textLabel?.font = cellFont
        cell.textLabel?.textColor = UIColor(red: 242/255, green: 217/255, blue: 237/255, alpha: 1)
        cell.backgroundColor = menuBGColor
        
        let menuBGColorSelected = UIView()
        menuBGColorSelected.backgroundColor = UIColor(red: 231/255, green: 117/255, blue: 183/255, alpha: 1)
        cell.selectedBackgroundView = menuBGColorSelected
        
        
        return cell
    }
    
    
    
}