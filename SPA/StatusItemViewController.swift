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

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Important Initializers
        let height = UIScreen.mainScreen().bounds.height
        let width = UIScreen.mainScreen().bounds.width
        view.backgroundColor = .blueColor()
        self.title = orderInfo[1] as! String
       
        
        //Create Approving Label
        progressLabelApproving = UILabel(frame: CGRectMake(0, 150, width/4, 45))
        progressLabelApproving?.text = "Approving"
        progressLabelApproving?.font = UIFont(name: "Times New Roman", size: 15)
        progressLabelApproving?.textAlignment = NSTextAlignment.Center
        progressLabelApproving?.backgroundColor = .grayColor()
        view.addSubview(progressLabelApproving!)
        
        
        //Create Charging Label
        progressLabelCharging = UILabel(frame: CGRectMake(width/4, 150, width/4, 45))
        progressLabelCharging?.text = "Charging"
        progressLabelCharging?.font = UIFont(name: "Times New Roman", size: 15)
        progressLabelCharging?.textAlignment = NSTextAlignment.Center
        progressLabelCharging?.backgroundColor = .grayColor()
        view.addSubview(progressLabelCharging!)
        
        
        //Create Cooking Label
        progressLabelCooking = UILabel(frame: CGRectMake(width*2/4, 150, width/4, 45))
        progressLabelCooking!.text = "Cooking"
        progressLabelCooking?.font = UIFont(name: "Times New Roman", size: 15)
        progressLabelCooking?.textAlignment = NSTextAlignment.Center
        progressLabelCooking?.backgroundColor = .grayColor()
        view.addSubview(progressLabelCooking!)
        
        
        //Create Ready for Pickup Label
        progressLabelPickup = UILabel(frame: CGRectMake(width*3/4, 150, width/4, 45))
        progressLabelPickup?.text = "Completed"
        progressLabelPickup?.font = UIFont(name: "Times New Roman", size: 15)
        progressLabelPickup?.textAlignment = NSTextAlignment.Center
        progressLabelPickup?.backgroundColor = .grayColor()
        view.addSubview(progressLabelPickup!)

        //Alters the label backgrouynd of the current stage and sets the progress percent
        if orderInfo[1] as! String == "Approving"{
            progressLabelApproving?.backgroundColor = .greenColor()
            progressToSet = 0.25
        }
        else if orderInfo[1] as! String == "Charging"{
            progressLabelCharging?.backgroundColor = .greenColor()
            progressToSet = 0.5
        }
        else if orderInfo[1] as! String == "Cooking"{
            progressLabelCooking?.backgroundColor = .greenColor()
            progressToSet = 0.75
        }
        else{
            progressLabelPickup?.backgroundColor = .greenColor()
            progressToSet = 1
        }
        

        
        // Create Progress View Control
        progressView = UIProgressView(frame: CGRectMake(0, 210, width, 60))
        progressView?.setProgress(progressToSet!, animated: true)
        progressView?.transform = CGAffineTransformScale(progressView!.transform, 1, 10)
        //progressView?.center = self.view.center
        view.addSubview(progressView!)
        
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
        var totalSum = 0
        
        for i in words{
            if counter == 0{
                oLabels = UILabel(frame: CGRectMake(5, CGFloat(275+30*stepper), width*6/10-10, 30))
                iFixed = i
            }
            else if counter == 2{
                 oLabels = UILabel(frame: CGRectMake(width*6/10-20, CGFloat(275+30*stepper), width*2/10+10, 30))
                 oLabels?.textAlignment = NSTextAlignment.Center
                 iFixed = i
                
            }
            else{
                if stepper > 0 {
                    let num1 = Int(i)
                    let num2 = Int(words[2 + (3 * stepper)])
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
        lineLabel.font = UIFont(name: "Times New Roman", size: 14)
        self.view.addSubview(lineLabel)
        
        stepper += 1
        
        //Create the total price label
        orderTotalLabel = UILabel(frame: CGRectMake(width*5/10, CGFloat(275+30*stepper), width*5/10-10, 30))
        orderTotalLabel!.text = "Order Total: $\(totalSum)"
        view.addSubview(orderTotalLabel!)
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
