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
    var logoutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Important Initializers
        let height = UIScreen.mainScreen().bounds.height
        let width = UIScreen.mainScreen().bounds.width
        self.navigationController?.navigationBarHidden = true
        
        //Create the menu button
        menuButton = UIButton(frame: CGRectMake(0, 0, width, height/2))
        menuButton.titleLabel!.font = UIFont(name: "Times New Roman", size: 50)
        menuButton.setTitle("Order Again", forState: UIControlState.Normal)
        menuButton.setTitleColor(.grayColor(), forState: UIControlState.Normal)
        menuButton.userInteractionEnabled = true
        menuButton.backgroundColor = .blueColor()
        menuButton.addTarget(self, action: "returnToMenu", forControlEvents: .TouchUpInside)
        self.view.addSubview(menuButton)
        
        //Create the logout button
        logoutButton = UIButton(frame: CGRectMake(0, height/2, width, height/2))
        logoutButton.titleLabel!.font = UIFont(name: "Times New Roman", size: 50)
        logoutButton.setTitle("Logout", forState: UIControlState.Normal)
        logoutButton.setTitleColor(.blueColor(), forState: UIControlState.Normal)
        logoutButton.backgroundColor = .grayColor()
        logoutButton.userInteractionEnabled = true
        logoutButton.addTarget(self, action: "LogoutNow", forControlEvents: .TouchUpInside)
        self.view.addSubview(logoutButton)
        
    }
    
    func returnToMenu(){
        orderCart = []
        performSegueWithIdentifier("optionToMenu", sender: nil)
    }
    
    func LogoutNow(){
        orderCart = []
        performSegueWithIdentifier("optionToLogin", sender: nil)
        
        
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
