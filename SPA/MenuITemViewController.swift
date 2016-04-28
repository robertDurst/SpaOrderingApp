//
//  MenuITemViewController.swift
//  SPA
//
//  Created by Coder on 2/2/16.
//  Copyright © 2016 OWA. All rights reserved.
//

import UIKit

class MenuITemViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate  {
    var itemName = UILabel()
    var itemDescription = UITextView()
    var itemPrice = UILabel()
    var itemPricePerQuantity = UILabel()
    var pickerView = UIPickerView()
    var colors = ["1","2","3","4","5"] //For the view picker
    var menuItem:[String] = []
    var Quantity = "1"
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Important initializers
        let height = UIScreen.mainScreen().bounds.height
        let width = UIScreen.mainScreen().bounds.width
        view.backgroundColor = .grayColor()
        
        //Create Title Image for Login Page
        let imageName = String(menuItem[0]) 
        let image = UIImage(named: imageName)
        imageView = UIImageView(image: image!)
        // imageView.frame = CGRect(x: 5, y: 70, width: width-10, height: height-310)
        imageView.frame = CGRect(x: 0, y:  70+height/10+20 + height/8, width: width, height: height*8/10-(70+height/10+5 + height/6-20))
        view.addSubview(imageView)
        
        //Create label for the item name
        itemName = UILabel(frame: CGRectMake(5, 70, width-10, height/10))
        itemName.backgroundColor = .blueColor()
        itemName.textColor = .whiteColor()
        itemName.text = menuItem[0]
        itemName.font = UIFont(name: "Helvetica", size: 25)
        itemName.textAlignment = .Center
        self.view.addSubview(itemName)
        
        //Create label for the item Description
        itemDescription = UITextView(frame: CGRectMake(5, 70+height/10+5, width-10, height/8+10))
        itemDescription.backgroundColor = .grayColor()
        itemDescription.textColor = .blackColor()
        itemDescription.text = menuItem[1]
        itemDescription.font = UIFont(name: "Helvetica", size: 16)
        itemDescription.textAlignment = .Center
        itemDescription.editable = false
        itemDescription.userInteractionEnabled = false
        self.view.addSubview(itemDescription)
        
        //Create label for the item price
        itemPrice = UILabel(frame: CGRectMake(width/2, height*8/10, width/2-5, height/10))
        itemPrice.backgroundColor = .clearColor()
        itemPrice.textColor = .blackColor()
        itemPrice.text = "$\(menuItem[2])"
        itemPrice.font = UIFont(name: "Helvetica", size: 20)
        itemPrice.textAlignment = .Right
        self.view.addSubview(itemPrice)
        
        //Create label for the item price per Quantity
        itemPricePerQuantity = UILabel(frame: CGRectMake(5, height*8/10, width/2-5, height/10))
        itemPricePerQuantity.backgroundColor = .clearColor()
        itemPricePerQuantity.textColor = .blackColor()
        itemPricePerQuantity.text = "Price:"
        itemPricePerQuantity.font = UIFont(name: "Helvetica", size: 20)
        itemPricePerQuantity.textAlignment = .Left
        self.view.addSubview(itemPricePerQuantity)
        
        //Create the picker for the quantity selection
        pickerView = UIPickerView(frame: CGRectMake(5,height*9/10, width-10, height/10-5))
        pickerView.backgroundColor = .blueColor()
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        self.view.addSubview(pickerView)
        
        
        //Bar Button on the right to use to buy item
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "buyItem:")
        self.navigationItem.rightBarButtonItem = addButton
        
    }
  
    //What happens when the upper right bar button is pressed
    func buyItem(sender: UIBarButtonItem){
        
        //Testing if the type of food is already in order and acting based on that
        var orderAlreadyThere = false
        var counter = 0
        for order in orderCart{
            if menuItem[0] == order[0]{
                let already = order[2]
                let newToAdd = Quantity
                let sum = Int(already)! + Int(newToAdd)!
                orderCart[counter][2] = String(sum)
                orderAlreadyThere = true
            }
            counter += 1
        }
        if orderAlreadyThere == false{
            orderCart.append([menuItem[0],menuItem[2],Quantity])
        }
    
        
        for order in orderCart{
            print(order)
        }
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("cart") as? CartTableViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colors[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Quantity = colors[row]
        let price = Double(menuItem[2])
        let sum = Double(Quantity)!*price!
        itemPrice.text = "$\(sum)"
    }

}
