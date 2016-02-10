//
//  CheckoutViewController.swift
//  SPA
//
//  Created by Coder on 2/8/16.
//  Copyright © 2016 OWA. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    var orderStringy = ""
    var checkoutPopover = CheckoutOptionViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var price = 0.00
        for item in orderCart{
            price += Double(item[1])!*Double(item[2])!
            for thing in item{
               orderStringy += " \(thing)"
            }
            
        }
        
        //Create the placeOrder button
        let menuButton = UIBarButtonItem(title: "PlaceOrder", style: .Plain, target: self, action: "orderTime")
        self.navigationItem.rightBarButtonItem = menuButton
        
        //Important Initializers
        let height = UIScreen.mainScreen().bounds.height
        let width = UIScreen.mainScreen().bounds.width
        view.backgroundColor = .grayColor()
        self.title = "Checkout"
        

        //Add all the menu items to the checkout
        if orderCart.count > 0{
            for x in (0...orderCart.count-1){
                var orderString = ""
                var counter = 0
                for item in orderCart[x]{
                    if counter == 0{
                        orderString += " \(item)   "
                    }
                    if counter == 1{
                        orderString += "Price: $\(item)   "
                    }
                    if counter == 2{
                        orderString += "Quantity: \(item)"
                    }
                    counter += 1
                }
                
                let labelCart = UILabel(frame:CGRectMake(5, CGFloat(70 + x * 25), width-10, CGFloat(50 + x * 25)))
                labelCart.text = orderString
                labelCart.font = UIFont(name: "Times New Roman", size: 14)
                
                
                self.view.addSubview(labelCart)
            }
            
            //Create the properties for the popover
            checkoutPopover.modalPresentationStyle = .Popover
            checkoutPopover.preferredContentSize = CGSizeMake(200, 200)
            

        }
        //Create The Dividing Line
        let lineLabel = UILabel(frame:CGRectMake(5, CGFloat(70 + orderCart.count * 25 + 25), width-10, 25))
        lineLabel.text = "__________________________________________"
        lineLabel.textAlignment = .Center
        lineLabel.font = UIFont(name: "Times New Roman", size: 14)
        self.view.addSubview(lineLabel)

        
        let labelCart = UILabel(frame:CGRectMake(5, height-25, width-10, 25))
        labelCart.text = "Total $\(price)"
        labelCart.textAlignment = .Right
        labelCart.font = UIFont(name: "Times New Roman", size: 30)
        self.view.addSubview(labelCart)
        
        }
    
    func orderTime(){
        checkoutPopover.popoverPresentationController?.sourceView = self.view
        let popoverMenuViewController = checkoutPopover.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = .Up
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceRect = CGRect(
            x: 250,
            y: 70,
            width: 1,
            height: 1)
        presentViewController(
            checkoutPopover,
            animated: true,
            completion: nil)
    }
    
    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController!) -> UIModalPresentationStyle {
            return .None
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
