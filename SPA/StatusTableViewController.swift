//
//  StatusTableViewController.swift
//  SPA
//
//  Created by Coder on 4/1/16.
//  Copyright © 2016 OWA. All rights reserved.
//

import UIKit

let manager3 = StatusChecker()
var statusesOfOrders = manager3.fetchingFirstPage(currentUser.objectId)

class StatusTableViewController: UITableViewController {
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Order Status"
        
        statusesOfOrders = manager3.fetchingFirstPage(currentUser.objectId)
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl!.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        //self.tableView.addSubview(self.refreshControl!) // not required when using UITableViewController



        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return statusesOfOrders.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell =
        self.tableView.dequeueReusableCellWithIdentifier(
            "StatusTableCell", forIndexPath: indexPath)
            as! StatusTableViewCell
        
        let row = indexPath.row
        cell.StatusLabel.text = "\(row+1)) \(statusesOfOrders[row][1])"
        return cell
    }
    
    func refresh(sender:AnyObject)
    {
        statusesOfOrders = manager3.fetchingFirstPage(currentUser.objectId)
        self.tableView.reloadData()
        self.refreshControl!.endRefreshing()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue,
        sender: AnyObject?) {
            if segue.identifier == "statusToItem" {
                if let detailViewController = segue.destinationViewController
                    as? StatusItemViewController{
                        let myIndexPath = self.tableView.indexPathForSelectedRow
                        let row = myIndexPath!.row
                        detailViewController.orderStatus = statusesOfOrders[row][1]
                        
                }
                
                
            }
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
