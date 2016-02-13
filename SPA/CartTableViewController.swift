//
//  CartTableViewController.swift
//  SPA
//
//  Created by Coder on 2/2/16.
//  Copyright © 2016 OWA. All rights reserved.
//

import UIKit

class CartTableViewController: UITableViewController {
    
    var checkoutButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cart"
        self.navigationItem.setHidesBackButton(true, animated: false)
            
        //Create the menu back button
        let menuButton = UIBarButtonItem(title: "< Menu", style: .Plain, target: self, action: "returnToMenu:")
        self.navigationItem.leftBarButtonItem = menuButton
        
        //Create the bar button for going to the cart
        checkoutButton = UIBarButtonItem(title: "Checkout", style: .Plain, target: self, action: "goToCheckout:")
        self.navigationItem.rightBarButtonItem = checkoutButton
        
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
        return orderCart.count+1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var price = 0.00
        for item in orderCart{
            price += Double(item[1])! * Double(item[2])!
            
        }
        
        let cell =
        self.tableView.dequeueReusableCellWithIdentifier(
            "CartCell", forIndexPath: indexPath)
            as! CartTableViewCell
        
        let row = indexPath.row
        
        if row < orderCart.count{
            cell.cartLabel.text = orderCart[row][0]
            cell.cartQuantityLabel.text = "Quantity: \(orderCart[row][2])"
        }
        else{
            cell.cartLabel.text = "Price: $\(price)0"
            cell.cartQuantityLabel.text = ""
        }
        
        return cell
    }
    
    func returnToMenu(sender:UIBarButtonItem){
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("MenuTable") as? MenuTableViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func goToCheckout(sender:UIBarButtonItem){
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("checkout") as? CheckoutViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
/*
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    
    {
        if editingStyle == .Delete && orderCart.count > 0 && indexPath.row < orderCart.count
        {
            orderCart.removeAtIndex(indexPath.row)
            self.tableView.reloadData()
        }
    }
    
*/
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if orderCart.count > 0 && indexPath.row < orderCart.count{
            return true
        }
        else{
            return false
        }
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete && orderCart.count > 0 && indexPath.row < orderCart.count
        {
            orderCart.removeAtIndex(indexPath.row)
            self.tableView.reloadData()
        }
    }

}
