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

let backendless = Backendless.sharedInstance()


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var usernameTextField = KaedeTextField()
    var passwordTextField = KaedeTextField()
    var loginButton = UIButton()
    var signupButton = UIButton()
    let tapRecKeyBoardHider = UITapGestureRecognizer()
    var imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()


        
        //Important Initializers
        let height = UIScreen.mainScreen().bounds.height
        let width = UIScreen.mainScreen().bounds.width
        view.backgroundColor = .blueColor()
        
        //Create Title Image for Login Page
        
        let imageName = "Spa.jpg"
        let image = UIImage(named: imageName)
        imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 5, y: 70, width: width-10, height: height-310)
        view.addSubview(imageView)
        
        //Create the username Textfield
        usernameTextField = KaedeTextField(frame: CGRectMake(5, 70+height-310+5, width-10, 60))
        usernameTextField.placeholder = "Username"
        usernameTextField.placeholderFontScale = 0.8
        usernameTextField.font = UIFont.italicSystemFontOfSize(26)
        usernameTextField.textColor = .blackColor()
        usernameTextField.backgroundColor = .grayColor()
        usernameTextField.layer.cornerRadius = 10
        usernameTextField.autocorrectionType = .No
        usernameTextField.autocapitalizationType = .None
        self.usernameTextField.delegate = self
        self.view.addSubview(usernameTextField)
        
        //Create the password Textfield
        passwordTextField = KaedeTextField(frame: CGRectMake(5, 70+height-310 + 70, width-10, 60))
        passwordTextField.placeholder = "Password"
        passwordTextField.placeholderFontScale = 0.8
        passwordTextField.font = UIFont.italicSystemFontOfSize(26)
        passwordTextField.textColor = .blackColor()
        passwordTextField.backgroundColor = .grayColor()
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.secureTextEntry = true
        passwordTextField.autocorrectionType = .No
        passwordTextField.autocapitalizationType = .None
        self.passwordTextField.delegate = self
        self.view.addSubview(passwordTextField)
        
        //Create the login button
        loginButton = UIButton(frame: CGRectMake(5,70+height-310 + 65 + 75, width-10, 35))
        loginButton.titleLabel!.font = UIFont(name: "Times New Roman", size: 40)
        loginButton.setTitle("Login", forState: UIControlState.Normal)
        loginButton.setTitleColor(.grayColor(), forState: UIControlState.Normal)
        loginButton.userInteractionEnabled = true
        loginButton.addTarget(self, action: "Login:", forControlEvents: .TouchUpInside)
        self.view.addSubview(loginButton)
        
        //Create the signup button
        signupButton = UIButton(frame: CGRectMake(5, 70+height-310 + 75+65 + 50, width-10, 35))
        signupButton.titleLabel!.font = UIFont(name: "Times New Roman", size: 40)
        signupButton.setTitle("Signup", forState: UIControlState.Normal)
        signupButton.setTitleColor(.grayColor(), forState: UIControlState.Normal)
        signupButton.userInteractionEnabled = true
        signupButton.addTarget(self, action: "Signup:", forControlEvents: .TouchUpInside)
        self.view.addSubview(signupButton)
        
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
    
    //Login function called when login button is tapped
    func Login(sender: UIButton){
        SwiftSpinner.show("Logging In")
        loginUserAsync()
        
    }
    
    //Signup function called when signup button is tapped
    func Signup(sender: UIButton){
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("Signup") as? SignupViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    //Login function
    func loginUserAsync() {
        backendless.userService.login(
            String(usernameTextField.text!), password:String(passwordTextField.text!),
            response: { (let registeredUser : BackendlessUser!) -> () in
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("MenuTable") as? MenuTableViewController
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
        animateViewMoving(true, moveValue: 110)
    }
    func textFieldDidEndEditing(textField: UITextField) {
        animateViewMoving(false, moveValue: 110)
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
