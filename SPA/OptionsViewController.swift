//
//  OptionsViewController.swift
//  SPA
//
//  Created by Coder on 2/10/16.
//  Copyright © 2016 OWA. All rights reserved.
//

import UIKit
import MessageUI

class OptionsViewController: UIViewController {

    var menuButton = UIButton()
    var settingsButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Important Initializers
        let height = UIScreen.mainScreen().bounds.height
        let width = UIScreen.mainScreen().bounds.width
        //self.navigationController?.navigationBarHidden = true
        
        //Create the menu button
        menuButton = UIButton(frame: CGRectMake(0, 64, width, height/2-32))
        menuButton.titleLabel!.font = UIFont(name: "Times New Roman", size: 50)
        menuButton.setTitle("Order", forState: UIControlState.Normal)
        menuButton.setTitleColor(.grayColor(), forState: UIControlState.Normal)
        menuButton.userInteractionEnabled = true
        menuButton.backgroundColor = .blueColor()
        menuButton.addTarget(self, action: "returnToMenu", forControlEvents: .TouchUpInside)
        self.view.addSubview(menuButton)
        
        //Create the Settings button
        settingsButton = UIButton(frame: CGRectMake(0, height/2+32, width, height/2-32))
        settingsButton.titleLabel!.font = UIFont(name: "Times New Roman", size: 40)
        settingsButton.setTitle("Edit Payment Info", forState: UIControlState.Normal)
        settingsButton.setTitleColor(.blueColor(), forState: UIControlState.Normal)
        settingsButton.backgroundColor = .grayColor()
        settingsButton.userInteractionEnabled = true
        settingsButton.addTarget(self, action: "Payment", forControlEvents: .TouchUpInside)
        self.view.addSubview(settingsButton)
        
        //Create the cart button
        let logoutButton = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: "LogoutNow")
        self.navigationItem.leftBarButtonItem = logoutButton
        
        //Create the settings button
        let btnName = UIButton()
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
        performSegueWithIdentifier("optionToMenu", sender: nil)
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
    

}
