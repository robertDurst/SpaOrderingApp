//
//  menuButItemViewController.swift
//  SPA
//
//  Created by Coder on 2/2/16.
//  Copyright © 2016 OWA. All rights reserved.
//

import UIKit



class menuButItemViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var buyButton = UIButton()
    var pickerView = UIPickerView()
    var pickerDataSource = ["1", "2", "3", "4","5"]
    




    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Important Initializers
        
        //view.backgroundColor = .blueColor()
        
        //Create the buy button
        buyButton = UIButton(frame: CGRectMake(5, 100, 190, 45))
        buyButton.titleLabel!.font = UIFont(name: "Times New Roman", size: 20)
        buyButton.setTitle("Add To Cart", forState: UIControlState.Normal)
        buyButton.setTitleColor(.blackColor(), forState: UIControlState.Normal)
        buyButton.userInteractionEnabled = true
        buyButton.addTarget(self, action: "goToCart:", forControlEvents: .TouchUpInside)
        buyButton.backgroundColor = .grayColor()
        self.view.addSubview(buyButton)
        
        pickerView = UIPickerView(frame: CGRectMake(5, 0, 190, 95))
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        self.view.addSubview(pickerView)

    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerDataSource[row]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToCart(sender: UIButton){
        dismissViewControllerAnimated(true, completion: nil)
    }

}
