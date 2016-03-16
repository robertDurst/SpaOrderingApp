//
//  PaymentViewController.swift
//  SPA
//
//  Created by Coder on 2/27/16.
//  Copyright © 2016 OWA. All rights reserved.
//

import UIKit
import Stripe

class PaymentViewController: UIViewController, STPPaymentCardTextFieldDelegate {
    
    
    let paymentTextField = STPPaymentCardTextField()
    var saveButton = UIButton()
    

    
    override func viewDidLoad() {
        super.viewDidLoad();
        paymentTextField.frame = CGRectMake(15, 50, CGRectGetWidth(self.view.frame) - 30, 44)
        paymentTextField.delegate = self
        view.addSubview(paymentTextField)
        
        saveButton = UIButton(frame: CGRectMake(5, 100, 100, 100))
        saveButton.titleLabel!.font = UIFont(name: "Times New Roman", size: 40)
        saveButton.setTitle("Save", forState: UIControlState.Normal)
        saveButton.setTitleColor(.grayColor(), forState: UIControlState.Normal)
        saveButton.userInteractionEnabled = true
        saveButton.addTarget(self, action: "getToken", forControlEvents: .TouchUpInside)
        self.view.addSubview(saveButton)


    }
    
    
    
    func getToken(){

        
        if let card = paymentTextField.card {
            do {
               
                STPAPIClient.sharedClient().createTokenWithCard(card) { (token, error) -> Void in
                    if let error = error  {
                        //handleError(error)
                        print(error)
                    }
                    else if let token = token {
                        //createBackendChargeWithToken(token) { status in
                        print(token)
                    }
                }
            } catch {
                
            }

            }
        
}
}
        

    



