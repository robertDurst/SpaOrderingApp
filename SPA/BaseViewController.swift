//
//  BaseViewController.swift
//  SPA
//
//  Created by Coder on 3/31/16.
//  Copyright © 2016 OWA. All rights reserved.
//

import UIKit
import PageMenu

class BaseViewController: UIViewController {
    
    var pageMenu : CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Array to keep track of controllers in page menu
        var controllerArray : [UIViewController] = []
        
        // Create variables for all view controllers you want to put in the
        // page menu, initialize them, and add each to the controller array.
        // (Can be any UIViewController subclass)
        // Make sure the title property of all view controllers is set
        // Example:
       
        var controller : UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier("options") as! OptionsViewController
        controller.title = "Options"
        controllerArray.append(controller)
        
        controller = self.storyboard?.instantiateViewControllerWithIdentifier("Menu") as! UINavigationController
        controller.title = "Menu"
        controllerArray.append(controller)
        
        controller = self.storyboard?.instantiateViewControllerWithIdentifier("cart") as! CartTableViewController
        controller.title = "Cart"
        controllerArray.append(controller)
        
        // Customize page menu to your liking (optional) or use default settings by sending nil for 'options' in the init
        // Example:
        var parameters: [CAPSPageMenuOption] = [
            .MenuItemSeparatorWidth(0),
            .UseMenuLikeSegmentedControl(true),
            .MenuItemSeparatorPercentageHeight(0.1)
        ]
        
        // Initialize page menu with controller array, frame, and optional parameters
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        
        // Lastly add page menu as subview of base view controller view
        // or use pageMenu controller in you view hierachy as desired
        self.view.addSubview(pageMenu!.view)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
