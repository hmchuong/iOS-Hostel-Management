//
//  MainViewController.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 12/31/16.
//  Copyright © 2016 chuonghuynh. All rights reserved.
//

import UIKit
import GaiaSDKUIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.tintColor = mainHexColor.colorWithHexString()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
