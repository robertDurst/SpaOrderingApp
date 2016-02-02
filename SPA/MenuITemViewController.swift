//
//  MenuITemViewController.swift
//  SPA
//
//  Created by Coder on 2/2/16.
//  Copyright © 2016 OWA. All rights reserved.
//

import UIKit

class MenuITemViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    var itemName = UILabel()
    var itemDescription = UITextView()
    var itemPrice = UILabel()
    var itemQuantity = UILabel()
    var menuItem:[String] = []
    var Quantity = 1
    
    let popoverView =  menuButItemViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Important initializers
        let height = UIScreen.mainScreen().bounds.height
        let width = UIScreen.mainScreen().bounds.width
        view.backgroundColor = .grayColor()
        
        
        //Create label for the item name
        itemName = UILabel(frame: CGRectMake(5, 70, width-10, height/5))
        itemName.backgroundColor = .blueColor()
        itemName.textColor = .whiteColor()
        itemName.text = menuItem[0]
        itemName.font = UIFont(name: "Times New Roman", size: 30)
        itemName.textAlignment = .Center
        self.view.addSubview(itemName)
        
        //Create label for the item Description
        itemDescription = UITextView(frame: CGRectMake(5, 70+height/5+25, width-10, height/5))
        itemDescription.backgroundColor = .grayColor()
        itemDescription.textColor = .blackColor()
        itemDescription.text = menuItem[1]
        itemDescription.font = UIFont(name: "Times New Roman", size: 16)
        itemDescription.textAlignment = .Center
        self.view.addSubview(itemDescription)
        
        //Create label for the item price
        itemPrice = UILabel(frame: CGRectMake(width/2, height*9/10, width/2-5, height/10))
        itemPrice.backgroundColor = .grayColor()
        itemPrice.textColor = .blackColor()
        itemPrice.text = "$\(menuItem[2])"
        itemPrice.font = UIFont(name: "Times New Roman", size: 20)
        itemPrice.textAlignment = .Right
        self.view.addSubview(itemPrice)
        
        //Create label for the item quantity
        itemQuantity = UILabel(frame: CGRectMake(5, height*9/10, width/2-5, height/10))
        itemQuantity.backgroundColor = .grayColor()
        itemQuantity.textColor = .blackColor()
        itemQuantity.text = "Quantity: \(Quantity)"
        itemQuantity.font = UIFont(name: "Times New Roman", size: 20)
        itemQuantity.textAlignment = .Left
        self.view.addSubview(itemQuantity)
        
        //Create Pop up menu
        popoverView.modalPresentationStyle = .Popover
        popoverView.preferredContentSize = CGSizeMake(10, 10)
        
        //Bar Button on the right to use to buy item
        let camera = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "buyItem:")
        self.navigationItem.rightBarButtonItem = camera
        
    }
  
    
    func buyItem(sender: UIBarButtonItem){
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("PopupTimePickerViewController") as! menuButItemViewController
        vc.modalPresentationStyle = .Popover
        vc.preferredContentSize = CGSizeMake(200, 150)
        
        if let presentationController = vc.popoverPresentationController {
            presentationController.delegate = self
            presentationController.permittedArrowDirections = .Up
            presentationController.sourceView = self.view
            presentationController.sourceRect = CGRectMake(0, 0, 50, 50)
            
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController!) -> UIModalPresentationStyle {
        // Return no adaptive presentation style, use default presentation behaviour
        return .None
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
