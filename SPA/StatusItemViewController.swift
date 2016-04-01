//
//  StatusItemViewController.swift
//  SPA
//
//  Created by Coder on 4/1/16.
//  Copyright © 2016 OWA. All rights reserved.
//

import UIKit

class StatusItemViewController: UIViewController {

    var orderStatus: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = orderStatus

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
