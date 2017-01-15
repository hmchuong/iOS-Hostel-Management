//
//  AccountViewController.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/1/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import UIKit
import GaiaSDKUIKit

class AccountViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var usernameTextField: GaiaUITextFieldIcon!
    @IBOutlet weak var emailTextField: GaiaUITextFieldIcon!
    @IBOutlet weak var fullnameTextField: GaiaUITextFieldIcon!
    @IBOutlet weak var phoneTextField: GaiaUITextFieldIcon!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = mainHexColor.colorWithHexString()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Load Account information
        usernameTextField.text = ChuNha.getInstance().getTendangnhap()
        emailTextField.text = ChuNha.getInstance().getEmail()
        fullnameTextField.text = ChuNha.getInstance().hoten
        phoneTextField.text = ChuNha.getInstance().sodienthoai
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func signOut(){
        // TODO: - Mark sign out in 
        if writeToUserDefaults(username: "", password: "", isChuNha: true){
            ChuNha.getInstance().signOut()
            self.navigationController!.viewControllers.removeAll()
            self.changeTo(viewController: "loginNaviVC", animation: true)
        }
    }
    
    // MARK - Actions
    @IBAction func tapSignOut(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Đăng xuất", message: "Bạn muốn đăng xuất?", preferredStyle: UIAlertControllerStyle.alert)
        
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            (UIAlertAction) -> Void in (self.signOut())
        }
        alert.addAction(OKAction)
        
        let cancelAction = UIAlertAction(title: "Bỏ qua", style: UIAlertActionStyle.default)
        {
            (UIAlertAction) -> Void in
        }
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        {
            () -> Void in
        }
    }
    
    
}
