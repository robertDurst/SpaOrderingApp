//
//  CartTableViewController.swift
//  SPA
//
//  Created by Coder on 2/2/16.
//  Copyright © 2016 OWA. All rights reserved.
//

import UIKit
import SimpleAlert

class CartTableViewController: UITableViewController {
    
    var checkoutButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initializers
        self.title = "Cart"
        self.navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.leftBarButtonItem = editButtonItem()
        tableView.tableFooterView = UIView()
        self.view.backgroundColor = .blackColor()
            
        //Create the menu back button
        let menuButton = UIBarButtonItem(title: "< Menu", style: .Plain, target: self, action: "returnToMenu:")
        //self.navigationItem.leftBarButtonItem = menuButton
        
        //Create the bar button for going to the cart
        checkoutButton = UIBarButtonItem(title: "Checkout", style: .Plain, target: self, action: "goToCheckout:")
        if orderCart.count > 0{
            self.navigationItem.rightBarButtonItem = checkoutButton
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.blackColor()
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
        
        cell.cartLabel.textColor = .whiteColor()
        cell.cartQuantityLabel.textColor = .whiteColor()
        
        if row < orderCart.count{
            cell.cartLabel.text = orderCart[row][0]
            cell.cartQuantityLabel.text = "Quantity: \(orderCart[row][2])"
        }
        else{
            cell.cartLabel.text = "Price: $\(price)"
            cell.cartQuantityLabel.text = ""
        }
        
        return cell
    }
    
    func returnToMenu(sender:UIBarButtonItem){
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("MenuTable") as? MenuTableViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func goToCheckout(sender:UIBarButtonItem){
        if orderCart.count >= 1{
            let alertController = UIAlertController(title: "Order Confirmation", message: "Are you sure you would like to place this order?", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                
            }
            alertController.addAction(cancelAction)
            
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                self.orderTime()
            }
            alertController.addAction(OKAction)
            
            self.presentViewController(alertController, animated: true) {
                // ...

            }}
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
    
    func ToMenu(){
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("MenuTable") as? MenuTableViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    func ToOptions(){
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("options") as? OptionsViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func ToCart(){
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        //Create the toolbar
        let height = UIScreen.mainScreen().bounds.height
        let width = UIScreen.mainScreen().bounds.width
        
        let toolbar = UIToolbar(frame: CGRectMake(0, height-50, width, 50))
        toolbar.backgroundColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.95)
        
        //Create the home button
        var btnName = UIButton()
        btnName.setImage(UIImage(named: "Home"), forState: .Normal)
        btnName.frame = CGRectMake(0, 0, 100, 45)
        btnName.addTarget(self, action: Selector("ToOptions"), forControlEvents: .TouchUpInside)
        let acceptButton = UIBarButtonItem()
        acceptButton.customView = btnName
        
        //Create the menu button
        btnName = UIButton()
        btnName.setImage(UIImage(named: "Menu"), forState: .Normal)
        btnName.frame = CGRectMake(0, 0, 100, 45)
        btnName.addTarget(self, action: Selector("ToMenu"), forControlEvents: .TouchUpInside)
        let cancelButton = UIBarButtonItem()
        cancelButton.customView = btnName
        
        //Create the cart button
        btnName = UIButton()
        btnName.setImage(UIImage(named: "Cart"), forState: .Normal)
        btnName.frame = CGRectMake(0, 0, 100, 45)
        btnName.addTarget(self, action: Selector("ToCart"), forControlEvents: .TouchUpInside)
        btnName.backgroundColor = .greenColor()
        let anotherButton = UIBarButtonItem()
        anotherButton.customView = btnName
        
        //Initialize the toolbar with the array of buttons and flexible space things
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil);
        toolbar.items = [acceptButton, flexibleSpace, cancelButton, flexibleSpace,anotherButton]
        self.view.addSubview(toolbar)
        self.setToolbarItems([acceptButton, flexibleSpace, cancelButton, flexibleSpace,anotherButton]
            , animated: false)
        self.navigationController?.setToolbarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated);
        self.navigationController?.setToolbarHidden(true, animated: animated)
    }
    
    
    
    func orderTime(){
        
        
        
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("options") as? OptionsViewController
        self.navigationController?.showViewController(vc!, sender: true)
        
        //Have to convert Array into string to send to Backendless
        var orderCartString = "[ "
        for item in orderCart{
            
            var countLev2 = 1
            var counter = 1
            for thing in item{
                if counter == 1{
                    orderCartString += "[\(thing), "
                }else if counter == 3{
                    orderCartString += "\(thing)]  "
                }
                counter += 1
            }
            countLev2 += 1
        }
        
        orderCartString += "]"
        
        
        let order = toApprove()
        order.item = String(orderCart)
        backendless.persistenceService.of(toApprove.ofClass()).save(order)
        
        orderCart = []
        
        let alertController = UIAlertController(title: "Success", message:
            "Your order is placed!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
        
    }

    
}
