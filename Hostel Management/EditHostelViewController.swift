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
        
        // Set up views if editing an existing NhaTro.
        if let nhatro = nhatro {
            navigationItem.title = nhatro.ten
            hostelName.text = nhatro.ten
            hostelAddress.text = nhatro.diachi
            emptyRoom.isHidden = false
            let s = "\(nhatro.sophong) phòng trống"
            emptyRoom.setTitle(s, for: .normal)
        }
        
        saveButton.isEnabled = false
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
            let name = hostelName.text ?? ""
            let address = hostelAddress.text ?? ""
            
            nhatro = NhaTro(diachi: address, ten: name)
            
            for ins in ChuNha.getInstance().nhatros!{
                if ins.ten == nhatro?.ten{
                    nhatro = nil
                    showPopUpMessage(title: "Không thể tạo nhà trọ", message: "Tên nhà trọ đã tồn tại!", view: self)
                    return false
                }
            }
            return true
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let button = sender as? GaiaUIButton, button === emptyRoom{
            let destViewController: RoomTableViewController = segue.destination as! RoomTableViewController
            destViewController.nhatro = self.nhatro
        }
    }
    
    // MARK: - Private methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let ten = hostelName.text ?? ""
        let diachi = hostelAddress.text ?? ""
        saveButton.isEnabled = (ten != nhatro?.ten) || (diachi != nhatro?.diachi)
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