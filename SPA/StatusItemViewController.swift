//
//  StatusItemViewController.swift
//  SPA
//
//  Created by Coder on 4/1/16.
//  Copyright © 2016 OWA. All rights reserved.
//

import UIKit

class StatusItemViewController: UIViewController {

    //Info of the selected order
    var orderInfo = []
    
    //Labels and Progress Bar
    var progressView: UIProgressView?
    var progressLabelApproving: UILabel?
    var progressLabelCharging: UILabel?
    var progressLabelCooking: UILabel?
    var progressLabelPickup: UILabel?
    var pageTitle: UILabel?
    var progressToSet: Float?
    var orderTotalLabel: UILabel?
    var orderItemsTitleLabel: UILabel?
    var oLabels: UILabel?
    var counter = 1
    var theCurrentOrderPlaceInArray  = 1
    var imageView = UIImageView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        var statusesOfOrders = manager3.fetchingFirstPage(currentUser.objectId)
        
        //Important Initializers
        let height = UIScreen.mainScreen().bounds.height
        let width = UIScreen.mainScreen().bounds.width
        view.backgroundColor = .whiteColor()
        self.title = orderInfo[1] as! String
        
        //Create Title Image for Login Page
        let imageName = "StatusBackground"
        let image = UIImage(named: imageName)
        imageView = UIImageView(image: image!)
        // imageView.frame = CGRect(x: 5, y: 70, width: width-10, height: height-310)
        imageView.frame = CGRect(x: 0, y: 62, width: width, height: height)
        view.addSubview(imageView)
        
       
        //Timer to make blinking
        let timer1 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "checkOrder", userInfo: nil, repeats: true)
        
        //Create Approving Label
        progressLabelApproving = UILabel(frame: CGRectMake(0, 150, width/4, 45))
        progressLabelApproving?.text = "Approving"
        progressLabelApproving?.font = UIFont(name: "Helvetica", size: 15)
        progressLabelApproving?.textAlignment = NSTextAlignment.Center
        progressLabelApproving?.textColor = .whiteColor()
        progressLabelApproving?.backgroundColor =  .blackColor()
        view.addSubview(progressLabelApproving!)
        
        
        //Create Charging Label
        progressLabelCharging = UILabel(frame: CGRectMake(width/4, 150, width/4, 45))
        progressLabelCharging?.text = "Charging"
        progressLabelCharging?.font = UIFont(name:"Helvetica", size: 15)
        progressLabelCharging?.textAlignment = NSTextAlignment.Center
        progressLabelCharging?.textColor = .whiteColor()
        progressLabelCharging?.backgroundColor =  .blackColor()
        view.addSubview(progressLabelCharging!)
        
        
        //Create Cooking Label
        progressLabelCooking = UILabel(frame: CGRectMake(width*2/4, 150, width/4, 45))
        progressLabelCooking!.text = "Cooking"
        progressLabelCooking?.font = UIFont(name: "Helvetica", size: 15)
        progressLabelCooking?.textAlignment = NSTextAlignment.Center
        progressLabelCooking?.backgroundColor = .blackColor()
        progressLabelCooking?.textColor = .whiteColor()
        view.addSubview(progressLabelCooking!)
        
        
        //Create Ready for Pickup Label
        progressLabelPickup = UILabel(frame: CGRectMake(width*3/4, 150, width/4, 45))
        progressLabelPickup?.text = "Completed"
        progressLabelPickup?.font = UIFont(name: "Helvetica", size: 15)
        progressLabelPickup?.textAlignment = NSTextAlignment.Center
        progressLabelPickup?.backgroundColor =  .blackColor()
        progressLabelPickup?.textColor = .whiteColor()
        view.addSubview(progressLabelPickup!)

        //Alters the label backgrouynd of the current stage and sets the progress percent
        if orderInfo[1] as! String == "Approving"{
            progressLabelApproving?.backgroundColor = .greenColor()
            progressToSet = 0.25
        }
        else if orderInfo[1] as! String == "Charging"{
            progressLabelCharging?.backgroundColor = .greenColor()
            progressLabelApproving?.backgroundColor = .greenColor()
            progressToSet = 0.5
        }
        else if orderInfo[1] as! String == "Cooking"{
            progressLabelCooking?.backgroundColor = .greenColor()
            progressLabelCharging?.backgroundColor = .greenColor()
            progressLabelApproving?.backgroundColor = .greenColor()
            progressToSet = 0.75
        }
        else{
            progressLabelPickup?.backgroundColor = .greenColor()
            progressLabelCooking?.backgroundColor = .greenColor()
            progressLabelCharging?.backgroundColor = .greenColor()
            progressLabelApproving?.backgroundColor = .greenColor()
            progressToSet = 1
        }
        

        
        // Create Progress View Control
        progressView = UIProgressView(frame: CGRectMake(0, 210, width, 60))
        progressView?.setProgress(progressToSet!, animated: true)
        progressView?.transform = CGAffineTransformScale(progressView!.transform, 1, 10)
        //progressView?.center = self.view.center
        //view.addSubview(progressView!)
        
        //Create Page Title - Order Status
        pageTitle = UILabel(frame: CGRectMake(5, 70, width-10, 75))
        pageTitle!.text = "Order Status"
        pageTitle!.font = UIFont(name: "Times New Roman", size: 60)
        pageTitle?.textAlignment = NSTextAlignment.Center
        view.addSubview(pageTitle!)
        
        //Create the title for the pseudo reciept
        orderItemsTitleLabel = UILabel(frame: CGRectMake(5, 215, width-10, 75))
        orderItemsTitleLabel!.text = "Order Details"
        orderItemsTitleLabel!.font = UIFont(name: "Times New Roman", size: 40)
        orderItemsTitleLabel?.textAlignment = NSTextAlignment.Center
        view.addSubview(orderItemsTitleLabel!)
       
        var currentOrder = String(orderInfo[0])
        var stepper = 0
        var word = ""
        var words: [String] = ["           Item","Price","Quantity"]
        
        for i in currentOrder.characters{
            if (i == "," || i == "]" || i == "[") && word.characters.count > 2{
                var stepper2 = 0
                var wordFix = ""
                for character in word.characters{
                    if stepper2 > 0 && stepper2 < word.characters.count - 1 {
                        wordFix.append(character)
                    }
                    stepper2 += 1
                }
                words.append(wordFix)
                word = ""
            }
            else if i == " " && word.characters.count > 2{
                word.append(i)

            }
            else if (i == "," || i == "[" || i == " " || i == "]"){
                word = ""
            }
            else if stepper >= 1{
                word.append(i)
            }
            stepper += 1
        }
        
        
        stepper = 0
        var counter = 0
        var iFixed = ""
        var totalSum = 0.00
        
        for i in words{
            if counter == 0{
                oLabels = UILabel(frame: CGRectMake(5, CGFloat(275+30*stepper), width*6/10-10, 30))
                iFixed = i
            }
            else if counter == 2{
                 oLabels = UILabel(frame: CGRectMake(width*6/10-20, CGFloat(275+30*stepper), width*2/10+10, 30))
                 oLabels!.font = UIFont(name: "Helvetica", size: 20)
                 oLabels?.textAlignment = NSTextAlignment.Center
                 iFixed = i
                
            }
            else{
                if stepper > 0 {
                    let num1 = Double(i)
                    let num2 = Double(words[2 + (3 * stepper)])
                    let sum = num1! * num2!
                    iFixed = String(sum)
                    totalSum += sum
                }
                else{
                    iFixed = i
                }

                oLabels = UILabel(frame: CGRectMake(width*8/10, CGFloat(275+30*stepper), width*2/10-10, 30))
            }
           
            oLabels!.text = iFixed
            oLabels!.font = UIFont(name: "Helvetica", size: 12)
            view.addSubview(oLabels!)
            
            counter += 1
            if counter == 3{
                counter = 0
                stepper += 1
            }
        }
        
        //stepper += 1
        
        //Create Dividing Lines
        let lineLabel = UILabel(frame: CGRectMake(0, CGFloat(275+30*stepper), width, 30))
        lineLabel.text = "__________________________________________"
        lineLabel.textAlignment = .Center
        lineLabel.font = UIFont(name: "Helvetica", size: 14)
        self.view.addSubview(lineLabel)
        
        stepper += 1
        
        //Create the total price label
        orderTotalLabel = UILabel(frame: CGRectMake(width*5/10, CGFloat(275+30*stepper), width*5/10-40
            , 30))
        orderTotalLabel!.text = "Order Total:  $\(totalSum)"
        orderTotalLabel!.font = UIFont(name: "Helvetica", size: 12)
        orderTotalLabel!.textAlignment = .Right
        view.addSubview(orderTotalLabel!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkOrder(){
        
        //Refresh Order To get Up to Date Status
        statusesOfOrders = manager3.fetchingFirstPage(currentUser.objectId)
        orderInfo = statusesOfOrders[theCurrentOrderPlaceInArray]
        
        counter += 1
        
        if counter%2 == 0{
            progressLabelApproving?.backgroundColor = .blackColor()
            progressLabelCharging?.backgroundColor = .blackColor()
            progressLabelCooking?.backgroundColor = .blackColor()
            progressLabelPickup?.backgroundColor = .blackColor()
        }
        else{
            if orderInfo[1] as! String == "Approving"{
                progressLabelApproving?.backgroundColor = .greenColor()
                progressToSet = 0.25
            }
            else if orderInfo[1] as! String == "Charging"{
                progressLabelCharging?.backgroundColor = .greenColor()
                progressLabelApproving?.backgroundColor = .greenColor()
                progressToSet = 0.5
            }
            else if orderInfo[1] as! String == "Cooking"{
                progressLabelCooking?.backgroundColor = .greenColor()
                progressLabelCharging?.backgroundColor = .greenColor()
                progressLabelApproving?.backgroundColor = .greenColor()
                progressToSet = 0.75
            }
            else{
                progressLabelPickup?.backgroundColor = .greenColor()
                progressLabelCooking?.backgroundColor = .greenColor()
                progressLabelCharging?.backgroundColor = .greenColor()
                progressLabelApproving?.backgroundColor = .greenColor()
                progressToSet = 1
            }
        }
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
