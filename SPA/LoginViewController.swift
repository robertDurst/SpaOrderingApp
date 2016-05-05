//
//  LoginViewController.swift
//  SPA
//
//  Created by Coder on 2/1/16.
//  Copyright © 2016 OWA. All rights reserved.
//

import UIKit
import TextFieldEffects
import SwiftSpinner
import Stripe

let backendless = Backendless.sharedInstance()


class LoginViewController: UIViewController, UITextFieldDelegate, STPPaymentCardTextFieldDelegate {
    
    var usernameTextField = KaedeTextField()
    var passwordTextField = KaedeTextField()
    var loginButton = UIButton()
    var signupButton = UIButton()
    var loginOptionButton = UIButton()
    var signupOptionButton = UIButton()
    let tapRecKeyBoardHider = UITapGestureRecognizer()
    var imageView = UIImageView()
    var status = "Nothing"
    var returnButton = UIButton()
    var enterButton = UIButton()
    
    //For the signup screen 
    var emailUser = YokoTextField()
    var passwordUser = YokoTextField()
    var confirmPassword = YokoTextField()
    var signupButton2 = UIButton()
    let tapRecKeyBoardHider2 = UITapGestureRecognizer()
    let paymentTextField = STPPaymentCardTextField()
    var hasPunctuation = false
    var hasNumber = false
    var returnButton2 = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()


        
        //Important Initializers
        let height = UIScreen.mainScreen().bounds.height
        let width = UIScreen.mainScreen().bounds.width
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //Create Title Image for Login Page
        let imageName = "Spa.jpg"
        let image = UIImage(named: imageName)
        imageView = UIImageView(image: image!)
       // imageView.frame = CGRect(x: 5, y: 70, width: width-10, height: height-310)
        imageView.frame = CGRect(x: 0, y: 62, width: width, height: height)
        view.addSubview(imageView)

        //Below are all the things for the signup
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        
        //Add Info Button
        let infoButton = UIBarButtonItem(title: "Help", style: .Plain, target: self, action: "signUpInfo")
        
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
        
        //Create the password signup Textfield
        passwordUser = YokoTextField(frame: CGRectMake(5, 160 + height/5, width-10, height/5))
        passwordUser.placeholder = "Password"
        passwordUser.font = UIFont.italicSystemFontOfSize(26)
        passwordUser.textColor = .whiteColor()
        passwordUser.backgroundColor = .whiteColor()
        passwordUser.layer.cornerRadius = 10
        passwordUser.secureTextEntry = true
        passwordUser.autocorrectionType = .No
        passwordUser.autocapitalizationType = .None
        self.passwordUser.delegate = self
        
        //Create the password confirm signup Textfield
        confirmPassword = YokoTextField(frame: CGRectMake(5, 165 + height*2/5, width-10, height/5))
        confirmPassword.placeholder = "Cofirm Password"
        confirmPassword.font = UIFont.italicSystemFontOfSize(26)
        confirmPassword.textColor = .whiteColor()
        confirmPassword.backgroundColor = .whiteColor()
        confirmPassword.layer.cornerRadius = 10
        confirmPassword.autocorrectionType = .No
        confirmPassword.autocapitalizationType = .None
        confirmPassword.secureTextEntry = true
        self.confirmPassword.delegate = self
        
        //Create the signup button
        signupButton2 = UIButton(frame: CGRectMake(0, 70+height*3/5+50 + height/10, width/2, 35))
        signupButton2.titleLabel!.font = UIFont(name: "Helvetica", size: 40)
        signupButton2.setTitle("Signup", forState: UIControlState.Normal)
        signupButton2.setTitleColor(.blackColor(), forState: UIControlState.Normal)
        signupButton2.userInteractionEnabled = true
        signupButton2.addTarget(self, action: "Signup:", forControlEvents: .TouchUpInside)
        
        //Create the signup button
        returnButton2 = UIButton(frame: CGRectMake(width/2, 70+height*3/5+50 + height/10, width/2, 35))
        returnButton2.titleLabel!.font = UIFont(name: "Helvetica", size: 40)
        returnButton2.setTitle("Return", forState: UIControlState.Normal)
        returnButton2.setTitleColor(.blackColor(), forState: UIControlState.Normal)
        returnButton2.userInteractionEnabled = true
        returnButton2.addTarget(self, action: "Return:", forControlEvents: .TouchUpInside)
        
        
        //Create the cart button
        let logoutButton = UIBarButtonItem(title: "< Return", style: .Plain, target: self, action: "Return")
        
        //All that is needed for the payment info textfield
        paymentTextField.frame = CGRectMake(5, 70, CGRectGetWidth(self.view.frame) - 10, 80)
        paymentTextField.backgroundColor = .whiteColor()
        paymentTextField.textColor = .blackColor()
        paymentTextField.placeholderColor = .grayColor()
        paymentTextField.font = UIFont.italicSystemFontOfSize(26)
        paymentTextField.delegate = self
        
        
        
        
        //Create the tap recognition for the action to hide keyboard
        tapRecKeyBoardHider2.addTarget(self, action: "dismissKeyboard")
       
 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        //Create the username Textfield
        usernameTextField = KaedeTextField(frame: CGRectMake(5, 70+height-200+5-50, width-10, 60))
        usernameTextField.placeholder = "Username"
        usernameTextField.placeholderFontScale = 0.8
        usernameTextField.font = UIFont.italicSystemFontOfSize(26)
        usernameTextField.textColor = .blackColor()
        usernameTextField.backgroundColor = .whiteColor()
        usernameTextField.layer.cornerRadius = 10
        usernameTextField.autocorrectionType = .No
        usernameTextField.autocapitalizationType = .None
        self.usernameTextField.delegate = self
        
        //Create the password Textfield
        passwordTextField = KaedeTextField(frame: CGRectMake(5, 70+height-200 + 70-50, width-10, 60))
        passwordTextField.placeholder = "Password"
        passwordTextField.placeholderFontScale = 0.8
        passwordTextField.font = UIFont.italicSystemFontOfSize(26)
        passwordTextField.textColor = .blackColor()
        passwordTextField.backgroundColor = .whiteColor()
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.secureTextEntry = true
        passwordTextField.autocorrectionType = .No
        passwordTextField.autocapitalizationType = .None
        self.passwordTextField.delegate = self
        
        //Return Button
        returnButton = UIButton(frame: CGRectMake(width/2, 70+height-310 + 75+65 + 50+5, width/2, 35))
        returnButton.titleLabel!.font = UIFont(name: "Helvetica", size: 30)
        returnButton.setTitle("Return", forState: UIControlState.Normal)
        returnButton.setTitleColor(.blackColor(), forState: UIControlState.Normal)
        returnButton.titleLabel?.textAlignment = .Center
        returnButton.userInteractionEnabled = true
        returnButton.addTarget(self, action: "Return:", forControlEvents: .TouchUpInside)
        
        //Enter (Login) Button
        enterButton = UIButton(frame: CGRectMake(0, 70+height-310 + 75+65 + 50+5, width/2, 35))
        enterButton.titleLabel!.font = UIFont(name: "Helvetica", size: 30)
        enterButton.setTitle("Login", forState: UIControlState.Normal)
        enterButton.setTitleColor(.blackColor(), forState: UIControlState.Normal)
        enterButton.titleLabel?.textAlignment = .Center
        enterButton.userInteractionEnabled = true
        enterButton.addTarget(self, action: "Login:", forControlEvents: .TouchUpInside)
        
        //Create the login option button
        loginOptionButton = UIButton(frame: CGRectMake(10, 70+height-310 + 75+65 + 50+5-30, width/3-10, 60))
        loginOptionButton.titleLabel!.font = UIFont(name: "Helvetica", size: 30)
        loginOptionButton.setTitle("Login", forState: UIControlState.Normal)
        loginOptionButton.setTitleColor(.blackColor(), forState: UIControlState.Normal)
        loginOptionButton.titleLabel?.textAlignment = .Center
        loginOptionButton.userInteractionEnabled = true
        loginOptionButton.backgroundColor = .whiteColor()
        loginOptionButton.layer.borderWidth = 1
        loginOptionButton.layer.cornerRadius = 5
        loginOptionButton.addTarget(self, action: "LoginOption:", forControlEvents: .TouchUpInside)
        
        //Create the signup button
        signupButton = UIButton(frame: CGRectMake(10 + width/3, 70+height-310 + 75+65 + 50+5-30, width*2/3-10-10, 60))
        signupButton.titleLabel!.font = UIFont(name: "Helvetica", size: 30)
        signupButton.setTitle("Signup", forState: UIControlState.Normal)
        signupButton.setTitleColor(.blackColor(), forState: UIControlState.Normal)
        signupButton.titleLabel?.textAlignment = .Center
        signupButton.userInteractionEnabled = true
        signupButton.backgroundColor = .whiteColor()
        signupButton.layer.borderWidth = 1
        signupButton.layer.cornerRadius = 5
        signupButton.addTarget(self, action: "SignupOption:", forControlEvents: .TouchUpInside)
        //self.view.addSubview(signupButton)
        
        //Create the tap recognition for the action to hide keyboard
        tapRecKeyBoardHider.addTarget(self, action: "dismissKeyboard")
        view.addGestureRecognizer(tapRecKeyBoardHider)
        
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        //Status for adding in the correct textfields and buttons
        if status == "Nothing"{
            self.view.addSubview(loginOptionButton)
            self.view.addSubview(signupButton)
            self.title = "Welcome to the SPA"
        }
        else if status == "Login"{
            self.title = "Login"
            self.view.addSubview(enterButton)
            self.view.addSubview(returnButton)
            self.view.addSubview(passwordTextField)
            self.view.addSubview(usernameTextField)
        }
        else if status == "Signup"{
            
            //This is the pop up that tells the specs for the password
            let alertController = UIAlertController(title: "Password Requirements", message:
                "Must be between 8 and 30 characters, contain one punctuation mark, and one number.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            
            self.title = "Signup"
            self.view.addSubview(emailUser)
            self.view.addSubview(passwordUser)
            self.view.addSubview(confirmPassword)
            self.view.addSubview(signupButton2)
            view.addSubview(paymentTextField)
            view.addGestureRecognizer(tapRecKeyBoardHider2)
            self.view.addSubview(returnButton2)
        }
        
    }
    
    //Login Option Function called when login option button is tapped
    func LoginOption(sender:UIButton){
        status = "Login"
        self.viewDidLoad()
    }
    
    //Signup Option Function called when Signup button is tapped
    func SignupOption(sender:UIButton){
        status = "Signup"
        self.viewDidLoad()
    }
    
    //Return Function back to options
    func Return(sender:UIButton){
        status = "Nothing"
        self.viewDidLoad()
    }
    
    //Login function called when login button is tapped
    func Login(sender: UIButton){
        SwiftSpinner.show("Logging In")
        loginUserAsync()
        
    }
    
    //Login function
    func loginUserAsync() {
        backendless.userService.login(
            String(usernameTextField.text!), password:String(passwordTextField.text!),
            response: { (let registeredUser : BackendlessUser!) -> () in
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("options") as? OptionsViewController
                SwiftSpinner.hide()
                backendless.userService.setStayLoggedIn( true )

                self.navigationController?.pushViewController(vc!, animated: true)
                           },
            error: { (let fault : Fault!) -> () in
                SwiftSpinner.hide()
       
                
                let alertController = UIAlertController(title: "Incorrect Login", message:
                    "Please Try Again", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                self.passwordTextField.text = ""

            }
        )
    }
    


    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.isEqual(confirmPassword){
            animateViewMoving(true, moveValue: 175)
        }
        else if textField.isEqual(passwordUser){
            animateViewMoving(true, moveValue: 75)
        }
        else if textField.isEqual(usernameTextField) || textField.isEqual(passwordTextField){
            animateViewMoving(true, moveValue: 180)
        }
    }
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.isEqual(confirmPassword){
            animateViewMoving(false, moveValue: 175)
        }
        else if textField.isEqual(passwordUser){
            animateViewMoving(false, moveValue: 75)
        }
        
        else if textField.isEqual(usernameTextField) || textField.isEqual(passwordTextField){
            animateViewMoving(false, moveValue: 180)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                                    
                                    SwiftSpinner.show("Confirming")
                                    registerUserAsync()
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
    


}
