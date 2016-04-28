//
//  StatusTableViewController.swift
//  SPA
//
//  Created by Coder on 4/1/16.
//  Copyright © 2016 OWA. All rights reserved.
//

import UIKit
import SwiftSpinner

let manager3 = StatusChecker()
var statusesOfOrders = manager3.fetchingFirstPage(currentUser.objectId)

class StatusTableViewController: UITableViewController {
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Your Orders"
        
        statusesOfOrders = manager3.fetchingFirstPage(currentUser.objectId)
        
        //Create the refresh button
        let btnName = UIButton()
        btnName.setImage(UIImage(named: "Refresh"), forState: .Normal)
        btnName.frame = CGRectMake(0, 0, 30, 30)
        btnName.addTarget(self, action: Selector("refresh:"), forControlEvents: .TouchUpInside)
        
        //.... Set Right/Left Bar Button item
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = btnName
        self.navigationItem.rightBarButtonItem = rightBarButton


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
        SwiftSpinner.show("Refreshing")
        let seconds = 1.0
        let delay = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            
            SwiftSpinner.hide()

            
        })

        statusesOfOrders = manager3.fetchingFirstPage(currentUser.objectId)
        self.tableView.reloadData()
            }
    
    override func prepareForSegue(segue: UIStoryboardSegue,
        sender: AnyObject?) {
            if segue.identifier == "statusToItem" {
                if let detailViewController = segue.destinationViewController
                    as? StatusItemViewController{
                        let myIndexPath = self.tableView.indexPathForSelectedRow
                        let row = myIndexPath!.row
                        detailViewController.orderInfo = statusesOfOrders[row]
                        detailViewController.theCurrentOrderPlaceInArray = row
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
