//
//  MenuTableViewController.swift
//  SPA
//
//  Created by Coder on 2/2/16.
//  Copyright © 2016 OWA. All rights reserved.
//

import UIKit

let manager = MenuDataSource()
let menu = manager.fetchingFirstPage()
var orderCart: Array<[String]> = []


class MenuTableViewController: UITableViewController {
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.title = "Menu"
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell =
        self.tableView.dequeueReusableCellWithIdentifier(
            "MenuTableCell", forIndexPath: indexPath)
            as! MenuTableViewCell
        
        let row = indexPath.row
        cell.menuLabel.text = menu[row][0]
        return cell
    }
   
    override func prepareForSegue(segue: UIStoryboardSegue,
        sender: AnyObject?) {
            if segue.identifier == "menuToItem" {
                if let detailViewController = segue.destinationViewController
                    as? MenuITemViewController{
                        let myIndexPath = self.tableView.indexPathForSelectedRow
                        let row = myIndexPath!.row
                        detailViewController.menuItem = menu[row]
                        
                }
                
                
            }
    }

}
