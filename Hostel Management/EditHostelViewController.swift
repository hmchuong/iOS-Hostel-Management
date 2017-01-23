//
//  EditHostelViewController.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/7/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import UIKit
import GaiaSDKUIKit

class EditHostelViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    // MARK: - Properties
    var nhatro: NhaTro?
    
    @IBOutlet weak var hostelName: UITextField!
    @IBOutlet weak var hostelAddress: GaiaDesignablePlaceholderTextView!
    @IBOutlet weak var emptyRoom: GaiaUIButton!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emptyRoom.isHidden = true
        
        
        saveButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Set up views if editing an existing NhaTro.
        if let nhatro = nhatro {
            nhatro.getPhongTro()
            navigationItem.title = nhatro.ten
            hostelName.text = nhatro.ten
            hostelAddress.text = nhatro.diaChi
            emptyRoom.isHidden = false
            let s = "\(nhatro.soPhongTrong) phòng trống"
            emptyRoom.setTitle(s, for: .normal)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        if(text == "\n")
        {
            view.endEditing(true)
            return false
        }
        else
        {
            return true
        }
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let button = sender as? UIBarButtonItem
        if button === saveButton{
            let isAdd = nhatro == nil
            let name = hostelName.text ?? ""
            let address = hostelAddress.text ?? ""
            
            nhatro = NhaTro(manhatro: "", diachi: address, ten: name)
            if isAdd{
                let (ok, message) = ChuNha.getInstance().addNhaTro(nhatro!)
                if ok == false{
                    nhatro = nil
                    showPopUpMessage(title: "Không thể tạo nhà trọ", message: message, view: self)
                    return false
                }
            }
            return true
        }
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let button = sender as? GaiaUIButton, button === emptyRoom{
            updateCurrentNhaTro()
            NhaTro.current = self.nhatro
        }
    }
    
    // MARK: - Private methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let ten = hostelName.text ?? ""
        let diachi = hostelAddress.text ?? ""
        saveButton.isEnabled = (ten != nhatro?.ten) || (diachi != nhatro?.diaChi)
    }
    
    // MARK: - Actions
    @IBAction func tapCanel(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The EditHostelViewController is not inside a navigation controller.")
        }
    }
    
}
