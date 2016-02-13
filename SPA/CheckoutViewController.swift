//
//  CheckoutViewController.swift
//  SPA
//
//  Created by Coder on 2/8/16.
//  Copyright © 2016 OWA. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    var orderStringy = ""

    
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
        if orderCart.count > 0{
            self.navigationItem.rightBarButtonItem = menuButton
        }
            
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
            


        }
        //Create The Dividing Line
        let lineLabel = UILabel(frame:CGRectMake(5, CGFloat(70 + orderCart.count * 25 + 25), width-10, 25))
        lineLabel.text = "__________________________________________"
        lineLabel.textAlignment = .Center
        lineLabel.font = UIFont(name: "Times New Roman", size: 14)
        self.view.addSubview(lineLabel)

        
        let labelCart = UILabel(frame:CGRectMake(5, height-25, width-10, 25))
        labelCart.text = "Total $\(price)0"
        labelCart.textAlignment = .Right
        labelCart.font = UIFont(name: "Times New Roman", size: 30)
        self.view.addSubview(labelCart)
        
        }
    
    
    

    
    func orderTime(){
        
        
        orderCart = []
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("options") as? OptionsViewController
        self.navigationController?.showViewController(vc!, sender: true)
        
        
        
        let alertController = UIAlertController(title: "Success", message:
            "Your order is placed!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
   
        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
