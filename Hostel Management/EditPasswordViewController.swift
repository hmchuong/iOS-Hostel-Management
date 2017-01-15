//
//  EditPasswordViewController.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/1/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import UIKit
import GaiaSDKUIKit

class EditPasswordViewController: UIViewController, UITextFieldDelegate {
    // MARK: - Outlets
    @IBOutlet weak var oldPasswordTextField: GaiaUITextFieldValidation!
    @IBOutlet weak var newPasswordTextField: GaiaUITextFieldValidation!
    @IBOutlet weak var confirmPasswordTextField: GaiaUITextFieldValidation!

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Delegate
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
        return false
    }
    

    // MARK: - Actions
    @IBAction func tapCancelButton(_ sender: UIBarButtonItem) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    @IBAction func tapSaveButton(_ sender: UIBarButtonItem) {
        let validator = Validator()
        let isValid = validator.validate(controller: self)
        if isValid{
            let (success, message) = ChuNha.getInstance().updatePassword(old: oldPasswordTextField.text!, new: newPasswordTextField.text!)
            if !success{
                oldPasswordTextField.toFailed(msg: message)
            }else{
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
