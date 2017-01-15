//
//  EditAccountViewController.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/1/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import UIKit
import GaiaSDKUIKit

class EditAccountViewController: UIViewController, UITextFieldDelegate {
    // MARK: - Outlets
    @IBOutlet weak var fullnameTextField: GaiaUITextFieldIcon!
    @IBOutlet weak var phoneTextField: GaiaUITextFieldIcon!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load account information
        fullnameTextField.text = ChuNha.getInstance().hoten
        phoneTextField.text = ChuNha.getInstance().sodienthoai
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Actions
    @IBAction func tapCancel(_ sender: UIBarButtonItem) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    @IBAction func tapSave(_ sender: UIBarButtonItem) {
        ChuNha.getInstance().hoten = fullnameTextField.text
        ChuNha.getInstance().sodienthoai = phoneTextField.text
        if ChuNha.getInstance().update(){
            _ = self.navigationController?.popViewController(animated: true)
        }else{
            showPopUpMessage(title: "Cập nhật", message: "Không thành công", view: self)
        }
    }
}
