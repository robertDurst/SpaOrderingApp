//
//  SingupHelpViewController.swift
//  SPA
//
//  Created by Coder on 4/14/16.
//  Copyright © 2016 OWA. All rights reserved.
//

import UIKit

class SingupHelpViewController: UIViewController {
    
    var signupHelpCreditCard = UITextView()
    var signupHelpEmail = UITextView()
    var signupHelpPassword = UITextView()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Important Initializers
        let height = UIScreen.mainScreen().bounds.height
        let width = UIScreen.mainScreen().bounds.width
        view.backgroundColor = .blueColor()
        self.title = "Signup Help"
        
        //Create label for the help Description
        signupHelpCreditCard = UITextView(frame: CGRectMake(5, 70, width-10, height/5+100))
        signupHelpCreditCard.backgroundColor = .grayColor()
        signupHelpCreditCard.textColor = .blackColor()
        signupHelpCreditCard.text = "Credit Card: Enter your credit card information in the text field. This will be securely stored as a part of your user information. It will allow for quick and easy SPA purchases."
        signupHelpCreditCard.font = UIFont(name: "Times New Roman", size: 16)
        signupHelpCreditCard.textAlignment = .Center
        self.view.addSubview(signupHelpCreditCard)
        
        //Create label for the help Description
        signupHelpEmail = UITextView(frame: CGRectMake(5, 70+height/5+100, width-10, height/5))
        signupHelpEmail.backgroundColor = .grayColor()
        signupHelpEmail.textColor = .blackColor()
        signupHelpEmail.text = "Email: Enter a valid Colby email address. Your username for logging in will be your email."
        signupHelpEmail.font = UIFont(name: "Times New Roman", size: 16)
        signupHelpEmail.textAlignment = .Center
        self.view.addSubview(signupHelpEmail)
        
        //Create label for the help Description
        signupHelpPassword = UITextView(frame: CGRectMake(5, 70+height*2/5+100, width-10, height*2/5-95))
        signupHelpPassword.backgroundColor = .grayColor()
        signupHelpPassword.textColor = .blackColor()
        signupHelpPassword.text = "Password: Enter a memorable password that fullfills the following requirements: must be between 8 and 30 characters and must contain a number and a punctuation mark."
        signupHelpPassword.font = UIFont(name: "Times New Roman", size: 16)
        signupHelpPassword.textAlignment = .Center
        self.view.addSubview(signupHelpPassword)
        
        
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
