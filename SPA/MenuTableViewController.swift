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
let currentUser = backendless.userService.currentUser


class MenuTableViewController: UITableViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.title = "Menu"
        tableView.tableFooterView = UIView()

        //Create the cart button
        let menuButton = UIBarButtonItem(title: "Cart", style: .Plain, target: self, action: "goToCart:")
        //self.navigationItem.rightBarButtonItem = menuButton
        
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
        let imageName = menu[row][0]
        cell.menuImage.image = UIImage(named: imageName)
        return cell
    }
    
    func goToCart(sender:UIBarButtonItem){
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("cart") as? CartTableViewController
        self.navigationController?.pushViewController(vc!, animated: true)
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
    
    func ToCart(){
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("cart") as? CartTableViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    func ToOptions(){
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("options") as? OptionsViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func ToMenu(){
        
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
        btnName.backgroundColor = .greenColor()
        let cancelButton = UIBarButtonItem()
        cancelButton.customView = btnName
        
        //Create the cart button
        btnName = UIButton()
        btnName.setImage(UIImage(named: "Cart"), forState: .Normal)
        btnName.frame = CGRectMake(0, 0, 100, 45)
        btnName.addTarget(self, action: Selector("ToCart"), forControlEvents: .TouchUpInside)
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
    
    

}
