//
//  CreateAccountViewController.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 12/29/16.
//  Copyright © 2016 chuonghuynh. All rights reserved.
//

import UIKit
import GaiaSDKUIKit

class CreateAccountViewController: UIViewController , UITextFieldDelegate{
    // MARK: - Outlets
    @IBOutlet weak var usernameTextField: GaiaUITextFieldValidation!
    @IBOutlet weak var emailTextField: GaiaUITextFieldValidation!
    @IBOutlet weak var passwordTextField: GaiaUITextFieldValidation!
    @IBOutlet weak var confirmPasswordTextField: GaiaUITextFieldValidation!
    @IBOutlet weak var fullnameTextField: GaiaUITextFieldValidation!
    @IBOutlet weak var phoneTextField: GaiaUITextFieldValidation!
    var validator = Validator()
    // MARK: - Properties
    var moved = 0
    var start: CGFloat = 0
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Move view when keyboard is shown
        NotificationCenter.default.addObserver(self, selector: #selector(CreateAccountViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CreateAccountViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
        } else {
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
                self.view.frame.origin.y -= (keyboardSize.height/3*2 < start/3) ? keyboardSize.height/3*2 : start/3
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
    @IBAction func cancelTap(_ sender: UIBarButtonItem) {
        self.moveTo(viewController: "loginScreenVC", animation: true)
    }

    @IBAction func tapRegisterButton(_ sender: GaiaUIButton) {
        // TODO: - Check acceptable account
        let isValid = validator.validate(textFields: [usernameTextField, emailTextField, fullnameTextField, passwordTextField, confirmPasswordTextField, phoneTextField])
        if isValid{
            let newAccount = ChuNha(tendangnhap: usernameTextField.text, matkhau: passwordTextField.text, hoten: fullnameTextField.text, sodienthoai: phoneTextField.text, email: emailTextField.text)
            let (_, message) = newAccount.signUp()
            showPopUpMessage(title: "Đăng ký", message: message, view: self)
        }
    }
}
