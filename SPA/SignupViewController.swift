//
//  SignupViewController.swift
//  SPA
//
//  Created by Coder on 2/2/16.
//  Copyright © 2016 OWA. All rights reserved.
//

import UIKit
import TextFieldEffects
import SwiftSpinner
import Stripe

class SignupViewController: UIViewController, UITextFieldDelegate, STPPaymentCardTextFieldDelegate {
    var emailUser = YokoTextField()
    var passwordUser = YokoTextField()
    var confirmPassword = YokoTextField()
    var signupButton = UIButton()
    let tapRecKeyBoardHider = UITapGestureRecognizer()
    let paymentTextField = STPPaymentCardTextField()
    var hasPunctuation = false
    var hasNumber = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Important Initializers
        let height = UIScreen.mainScreen().bounds.height
        let width = UIScreen.mainScreen().bounds.width
        view.backgroundColor = .blueColor()
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.title = "Signup"
        
        //Add Info Button
        let infoButton = UIBarButtonItem(title: "Help", style: .Plain, target: self, action: "signUpInfo")
        self.navigationItem.rightBarButtonItem = infoButton
        
        //Create the email signup Textfield
        emailUser = YokoTextField(frame: CGRectMake(5, 155, width-10, height/5))
        emailUser.placeholder = "Colby Email Address"
        emailUser.font = UIFont.italicSystemFontOfSize(26)
        emailUser.textColor = .whiteColor()
        emailUser.backgroundColor = .whiteColor()
        emailUser.layer.cornerRadius = 10
        emailUser.autocorrectionType = .No
        emailUser.autocapitalizationType = .None
        self.emailUser.delegate = self
        self.view.addSubview(emailUser)
        
        //Create the password signup Textfield
        passwordUser = YokoTextField(frame: CGRectMake(5, 160 + height/5, width-10, height/5))
        passwordUser.placeholder = "Password"
        passwordUser.font = UIFont.italicSystemFontOfSize(26)
        passwordUser.textColor = .grayColor()
        passwordUser.backgroundColor = .grayColor()
        passwordUser.layer.cornerRadius = 10
        passwordUser.secureTextEntry = true
        passwordUser.autocorrectionType = .No
        passwordUser.autocapitalizationType = .None
        self.passwordUser.delegate = self
        self.view.addSubview(passwordUser)
        
        //Create the password confirm signup Textfield
        confirmPassword = YokoTextField(frame: CGRectMake(5, 165 + height*2/5, width-10, height/5))
        confirmPassword.placeholder = "Cofirm Password"
        confirmPassword.font = UIFont.italicSystemFontOfSize(26)
        confirmPassword.textColor = .grayColor()
        confirmPassword.backgroundColor = .grayColor()
        confirmPassword.layer.cornerRadius = 10
        confirmPassword.autocorrectionType = .No
        confirmPassword.autocapitalizationType = .None
        confirmPassword.secureTextEntry = true
        self.confirmPassword.delegate = self
        self.view.addSubview(confirmPassword)
        
        //Create the signup button
        signupButton = UIButton(frame: CGRectMake(5, 70+height*3/5+50 + height/10, width-10, 35))
        signupButton.titleLabel!.font = UIFont(name: "Helvetica", size: 40)
        signupButton.setTitle("Signup", forState: UIControlState.Normal)
        signupButton.setTitleColor(.grayColor(), forState: UIControlState.Normal)
        signupButton.userInteractionEnabled = true
        signupButton.addTarget(self, action: "Signup:", forControlEvents: .TouchUpInside)
        self.view.addSubview(signupButton)
        
        //Create the cart button
        let logoutButton = UIBarButtonItem(title: "< Return", style: .Plain, target: self, action: "Return")
        self.navigationItem.leftBarButtonItem = logoutButton
        
        //All that is needed for the payment info textfield
        paymentTextField.frame = CGRectMake(5, 70, CGRectGetWidth(self.view.frame) - 10, 80)
        paymentTextField.backgroundColor = .grayColor()
        paymentTextField.textColor = .blackColor()
        paymentTextField.placeholderColor = .darkGrayColor()
        paymentTextField.font = UIFont.italicSystemFontOfSize(26)
        paymentTextField.delegate = self
        view.addSubview(paymentTextField)
            
        
        
        
        //Create the tap recognition for the action to hide keyboard
        tapRecKeyBoardHider.addTarget(self, action: "dismissKeyboard")
        view.addGestureRecognizer(tapRecKeyBoardHider)
        

    }
    
    //Hide the space key if space is pressed
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //Whenever you tap somewhere outside the TextField
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //What happens when you hit the signup button - you try to create an account. If successful, return to the login page.
    func Signup(sender: UIButton){
        hasPunctuation = false
        hasNumber = false
        let str = String(emailUser.text)
        var length = str.characters.count
        if length >= 22{
            var index1 = str.startIndex.advancedBy(length-12)
            let substring1 = str.substringFromIndex(index1)
            length = substring1.characters.count
            index1 = str.startIndex.advancedBy(length-2)
            let substring2 = substring1.substringToIndex(index1)
            
            
            if substring2 == "@colby.edu" {
                //Here I work on adhering to the Colby Password requirements
                
                if passwordUser.text?.characters.count > 7{
                    if passwordUser.text?.characters.count < 31{
                        for char in (passwordUser.text?.characters)!{
                            
                            if char == "!" || char == "?" || char == "." || char == "," || char == "@" || char == "%"{
                                hasPunctuation = true
                                
                                for char in (passwordUser.text?.characters)!{
                                    if char == "1" || char == "2" || char == "3" || char == "4" || char == "5" || char == "6" || char == "7" || char == "8" || char == "9" || char == "0"{
                                        hasNumber = true
                                    
                                }
                            }
                            
}
                    
                    }
                        if hasNumber == true{
                            
                            if hasPunctuation{
                
                        if passwordUser.text == confirmPassword.text{
                            
                            //SwiftSpinner.show("Confirming")
                            // registerUserAsync()
                        }
                        else{
                            SwiftSpinner.show("Confirming")
                            SwiftSpinner.hide()
                            JSSAlertView().show(
                                self,
                                title: "Error",
                                text: "Passwords Do Not Match",
                                buttonText: "OK",
                                color: UIColor.redColor()
                            )
                                }}
                        else{
                                SwiftSpinner.show("Confirming")
                                SwiftSpinner.hide()
                                JSSAlertView().show(
                                    self,
                                    title: "Error",
                                    text: "Must have Punctuation",
                                    buttonText: "OK",
                                    color: UIColor.redColor()
                                )
                            }}
                    else{
                            SwiftSpinner.show("Confirming")
                            SwiftSpinner.hide()
                            JSSAlertView().show(
                                self,
                                title: "Error",
                                text: "Must have Number and Punctuation",
                                buttonText: "OK",
                                color: UIColor.redColor()
                            )
                        }}
                    else {
                        SwiftSpinner.show("Confirming")
                        SwiftSpinner.hide()
                        JSSAlertView().show(
                            self,
                            title: "Error",
                            text: "Please Enter a Valid Password Shorter Than 31 Characters",
                            buttonText: "OK",
                            color: UIColor.redColor()
                        )
                        }}
                
                else{
                    SwiftSpinner.show("Confirming")
                    SwiftSpinner.hide()
                    JSSAlertView().show(
                        self,
                        title: "Error",
                        text: "Please Enter a Valid Password Longer Than 7 Characters",
                        buttonText: "OK",
                        color: UIColor.redColor()
                    )
                }}
            
    
        
            else{
                SwiftSpinner.show("Confirming")
                SwiftSpinner.hide()
                JSSAlertView().show(
                    self,
                    title: "Error",
                    text: "Please Enter a Valid Colby Email",
                    buttonText: "OK",
                    color: UIColor.redColor()
                )
            }}
        
        else{
        SwiftSpinner.show("Confirming")
        SwiftSpinner.hide()
        JSSAlertView().show(
            self,
            title: "Error",
            text: "Please Enter a Valid Colby Email",
            buttonText: "OK",
            color: UIColor.redColor()
        )
        }
    }
    
    //Method for singing up
    func registerUserAsync() {
        
        let card = paymentTextField.card
        
        STPAPIClient.sharedClient().createTokenWithCard(card!) { (token, error) -> Void in
            if let error = error  {
                //handleError(error)
            }
            else if let token = token {
                //createBackendChargeWithToken(token) { status in
                let user = BackendlessUser()
                user.email = self.emailUser.text
                user.password = self.passwordUser.text
                user.setProperty("stripeToken", object: String(token))
                
                backendless.userService.registering(user,
                    response: { (registeredUser : BackendlessUser!) -> () in
                        SwiftSpinner.hide()
                        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Login") as? LoginViewController
                        self.navigationController?.pushViewController(vc!, animated: true)
                        JSSAlertView().success(
                            self,
                            title: "Successful Signup",
                            text: "Please Check Your Email to Confirm and Then Login",
                            buttonText: "OK")
                        
                    },
                    error: { ( fault : Fault!) -> () in
                        SwiftSpinner.hide()
                        JSSAlertView().show(
                            self,
                            title: "Error",
                            text: "\(fault.detail)",
                            buttonText: "OK",
                            color: UIColor.redColor()
                        )
                    } 
                )
                
                
            }
            
            
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.isEqual(confirmPassword){
            animateViewMoving(true, moveValue: 175)
        }
        else if textField.isEqual(passwordUser){
            animateViewMoving(true, moveValue: 75)
        }
    }
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.isEqual(confirmPassword){
            animateViewMoving(false, moveValue: 175)
        }
        else if textField.isEqual(passwordUser){
            animateViewMoving(false, moveValue: 75)
        }
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        var movementDuration:NSTimeInterval = 0.3
        var movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
        UIView.commitAnimations()
    }
    
    func Return(){
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Login") as? LoginViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func signUpInfo(){
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("signupHelp") as? SingupHelpViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    //To get the Stripe Token

}

