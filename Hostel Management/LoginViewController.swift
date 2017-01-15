//
//  ViewController.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 12/25/16.
//  Copyright © 2016 chuonghuynh. All rights reserved.
//

import UIKit
import GaiaSDKUIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    // MARK: - Outlets
    @IBOutlet weak var usernameTextField: GaiaUITextFieldValidation!
    @IBOutlet weak var passwordTextField: GaiaUITextFieldValidation!
    @IBOutlet weak var isChuNhaCheckBox: GaiaDesignableUICheckbox!
    
    // MARK: - Properties
    var moved = 0
    var start: CGFloat = 0
    var validator = Validator()
    
    // MARK : - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        // Move view when keyboard is shown
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        start = textField.convert(textField.frame.origin, to: self.view).y
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTage=textField.tag+1;
        // Try to find next responder
        let nextResponder=textField.superview?.viewWithTag(nextTage) as UIResponder!
        
        
        if (nextResponder != nil){
            // Found next responder, so set it.
            nextResponder?.becomeFirstResponder()
        }
        else
        {
            // Not found, so remove keyboard
            textField.resignFirstResponder()
        }
        return false // We do not want UITextField to insert line-breaks.
    }
    
    /// Move view when keyboard is shown
    ///
    /// - Parameter notification: for keyboard will show
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if moved == 0{
                self.view.frame.origin.y -= (keyboardSize.height/3*2 < start) ? keyboardSize.height/3*2 : start
                moved = -1 * Int(self.view.frame.origin.y)
            }
        }
        
    }
    
    /// Move view when keyboard is hide
    ///
    /// - Parameter notification: for keyboard will hide
    func keyboardWillHide(notification: NSNotification) {
        if moved != 0{
            self.view.frame.origin.y += CGFloat(moved)
            moved = 0
        }
    }
    
    // MARK: - Actions
    
    @IBAction func tapLoginButton(_ sender: GaiaUIButton) {
        let isValid = validator.validate(textFields: [usernameTextField, passwordTextField])
        if isValid{
            if isChuNhaCheckBox.checked == false{
                // TODO: - for NguoiThue account
                showPopUpMessage(title: "Đăng nhập cho người thuê", message: "Chức năng đang được xây dựng", view: self)
            }else{
                // Login to ChuNha account
                let (success, message) = ChuNha.login(tendangnhap: usernameTextField.text!, matkhau: passwordTextField.text!)
                if success {    // Login successful
                    // Write to sharepreferences
                    if writeToUserDefaults(username: usernameTextField.text!, password: passwordTextField.text!, isChuNha: true){
                        self.moveTo(viewController: "mainVC", animation: true)
                    }else{
                        print("Cannot save to user defaults")
                    }
                }else{  // Login failed
                    showPopUpMessage(title: "Đăng nhập cho chủ nhà", message: message, view: self)
                }
            }
        }
       
    }
    
    @IBAction func tapForgetPasswordButton(_ sender: GaiaUIButton) {
        showPopUpMessage(title: "Quên mật khẩu", message: "Chức năng đang được xây dựng", view: self)
    }
}

