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
        TableArray = ["Accueil", "Arrêts", "Lignes"]
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
        cell.textLabel?.font = UIFont(name: global.mainFont, size: 25)
        cell.textLabel?.textColor = UIColor(red: 242/255, green: 217/255, blue: 237/255, alpha: 1)
        cell.backgroundColor = menuBGColor
        
        let menuBGColorSelected = UIView()
        menuBGColorSelected.backgroundColor = UIColor(red: 231/255, green: 117/255, blue: 183/255, alpha: 1)
        cell.selectedBackgroundView = menuBGColorSelected
        
        
        return cell
    }
    
    //active l'interaction avec l'interface uniquement quand le menu est fermé
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.revealViewController().view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.revealViewController().frontViewController.revealViewController().tapGestureRecognizer()
        self.revealViewController().frontViewController.view.userInteractionEnabled = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.revealViewController().frontViewController.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.revealViewController().frontViewController.view.userInteractionEnabled = true
    }
}