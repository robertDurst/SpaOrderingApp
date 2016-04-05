//
//  OptionsViewController.swift
//  SPA
//
//  Created by Coder on 2/10/16.
//  Copyright © 2016 OWA. All rights reserved.
//

import UIKit
import MessageUI
import SimpleAlert

class OptionsViewController: UIViewController {

    var menuButton = UIButton()
    var settingsButton = UIButton()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Important Initializers
        let height = UIScreen.mainScreen().bounds.height
        let width = UIScreen.mainScreen().bounds.width
        self.title = "Home"
        //self.navigationController?.navigationBarHidden = true
        
        //Create the toolbar
        let toolbar = UIToolbar(frame: CGRectMake(0, height-50, width, 50))
        toolbar.backgroundColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.95)
        
        //Create the home button
        var btnName = UIButton()
        btnName.setImage(UIImage(named: "Home"), forState: .Normal)
        btnName.frame = CGRectMake(0, 0, 30, 30)
        btnName.addTarget(self, action: Selector("ToHome"), forControlEvents: .TouchUpInside)
        let acceptButton = UIBarButtonItem()
        acceptButton.customView = btnName
        
        //Create the menu button
        btnName = UIButton()
        btnName.setImage(UIImage(named: "Menu"), forState: .Normal)
        btnName.frame = CGRectMake(0, 0, 30, 30)
        btnName.addTarget(self, action: Selector("ToMenu"), forControlEvents: .TouchUpInside)
        let cancelButton = UIBarButtonItem()
        cancelButton.customView = btnName
        
        //Create the cart button
        btnName = UIButton()
        btnName.setImage(UIImage(named: "Cart"), forState: .Normal)
        btnName.frame = CGRectMake(0, 0, 30, 30)
        btnName.addTarget(self, action: Selector("ToCart"), forControlEvents: .TouchUpInside)
        let anotherButton = UIBarButtonItem()
        anotherButton.customView = btnName
        
        //Initialize the toolbar with the array of buttons and flexible space things
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil);
        toolbar.items = [acceptButton, flexibleSpace, cancelButton, flexibleSpace,anotherButton]
        self.view.addSubview(toolbar)
        
        //Create the menu button
        menuButton = UIButton(frame: CGRectMake(0, 64, width, height/2-32))
        menuButton.titleLabel!.font = UIFont(name: "Times New Roman", size: 50)
        menuButton.setTitle("New Order", forState: UIControlState.Normal)
        menuButton.setTitleColor(.grayColor(), forState: UIControlState.Normal)
        menuButton.userInteractionEnabled = true
        menuButton.backgroundColor = .blueColor()
        menuButton.addTarget(self, action: "returnToMenu", forControlEvents: .TouchUpInside)
        self.view.addSubview(menuButton)
        
        //Create the Check Order Status button
        settingsButton = UIButton(frame: CGRectMake(0, height/2+32, width, height/2-32-40))
        settingsButton.titleLabel!.font = UIFont(name: "Times New Roman", size: 30)
        settingsButton.setTitle("Check Order Status", forState: UIControlState.Normal)
        settingsButton.setTitleColor(.blueColor(), forState: UIControlState.Normal)
        settingsButton.backgroundColor = .grayColor()
        settingsButton.userInteractionEnabled = true
        settingsButton.addTarget(self, action: "Status", forControlEvents: .TouchUpInside)
        self.view.addSubview(settingsButton)
        
        //Create the cart button
        let logoutButton = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: "LogoutNow")
        self.navigationItem.leftBarButtonItem = logoutButton
        

        
        //Create the settings button
        btnName = UIButton()
        btnName.setImage(UIImage(named: "settings"), forState: .Normal)
        btnName.frame = CGRectMake(0, 0, 30, 30)
        btnName.addTarget(self, action: Selector("Settings"), forControlEvents: .TouchUpInside)
        
        //.... Set Right/Left Bar Button item
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = btnName
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    func returnToMenu(){
        orderCart = []
        //performSegueWithIdentifier("optionToMenu", sender: nil)
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("MenuTable") as? MenuTableViewController
        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    func LogoutNow(){
        orderCart = []
        performSegueWithIdentifier("optionToLogin", sender: nil)
        
        
    }
    
    func Settings(){
        performSegueWithIdentifier("optionsToSettings", sender: nil)
    }
    
    func Payment(){
        performSegueWithIdentifier("optionsToPayment", sender: nil)
    }
    
    func Status(){
         performSegueWithIdentifier("OptionsToStatus", sender: nil)
    }
    
    func logoutUserAsync() {
        
        backendless.userService.login(
            currentUser.email, password:currentUser.password,
            response: { ( user : BackendlessUser!) -> () in
                print("User has been logged in (ASYNC): \(user)")
                
                backendless.userService.logout(
                    { ( user : AnyObject!) -> () in
                        print("Current user session expired.")
                    },
                    error: { ( fault : Fault!) -> () in
                        print("Server reported an error: \(fault)")
                    }
                )
            },
            error: { ( fault : Fault!) -> () in
                print("Server reported an error: \(fault)")
            }
        )
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func ToCart(){
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("cart") as? CartTableViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    func ToMenu(){
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("MenuTable") as? MenuTableViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    func ToHome(){
        
    }
    

}
