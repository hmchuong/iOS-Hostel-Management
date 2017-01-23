//
//  ViewController.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 12/31/16.
//  Copyright © 2016 chuonghuynh. All rights reserved.
//

import UIKit
import GaiaSDKUIKit

class RentRoomViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: - Outlets
    @IBOutlet weak var hostelTextField: UITextField!
    @IBOutlet weak var roomTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rentButton: GaiaUIButton!
    @IBOutlet weak var copyInfoButton: GaiaUIButton!
    @IBOutlet weak var hostelChoosenPickerView: UIPickerView!
    @IBOutlet weak var roomChoosenPickerView: UIPickerView!
    
    var isRented = false
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextField.isEnabled = false
        passwordTextField.isEnabled = false
        rentButton.isEnabled = false
        copyInfoButton.isEnabled = false
        
        navigationController?.navigationBar.barTintColor = mainHexColor.colorWithHexString()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Get list of hostels
    ///
    /// - Returns: list of hostels' name
    func listOfHostel()->[NhaTro]{
        return ChuNha.getInstance().nhaTro!
    }
    
    /// Get list of rooms in hostel
    ///
    /// - Parameter hostel: Hostel id
    /// - Returns: list of rooms' name
    func listOfRoomOf()->[Phong]{
        if hostelTextField.text != ""{
            NhaTro.current?.getPhongTro()
            return (NhaTro.current?.phongTro)!
        }
        return []
    }
    
    /// Get account of room
    ///
    /// - Parameters:
    ///   - room: Room id
    ///   - hostel: hostel id
    /// - Returns: tuple of username and password of room
    func getAccountOfRoom() -> (String, String) {
        // Update username and password
        if Phong.current?.thuePhong != nil{
            print (Phong.current?.ten)
            return ((Phong.current?.thuePhong?.taiKhoanPhong?.id)!, (Phong.current?.thuePhong?.taiKhoanPhong?.matoken)!)
        }
        return ("","")
    }
    
    /// Update UI when choosen hostel and room
    ///
    /// - Parameters:
    ///   - textField: textfield want to update
    ///   - value: text to update
    func updateTextField(_ textField: UITextField, with value: String){
        textField.text = value
        if textField == hostelTextField{
            roomTextField.text = ""
            usernameTextField.text = nonAccount
            passwordTextField.text = nonAccount
        }
        
        if !(hostelTextField.text?.isEmpty)! && !(roomTextField.text?.isEmpty)!{
            let account = getAccountOfRoom()
            if account != ("", ""){
                copyInfoButton.isEnabled = true
                usernameTextField.text = account.0
                passwordTextField.text = account.1

            }else{
                usernameTextField.text = nonAccount
                passwordTextField.text = nonAccount
                rentButton.isEnabled = true
            }
        }else{
            rentButton.isEnabled = false
            copyInfoButton.isEnabled = false
        }
    }
    
    /// Generate account and save to database
    func generateAccount(){
        // TODO: - Generate account and save to database
        usernameTextField.text = Phong.current?.maPhong.replacingOccurrences(of: "_", with: "-")
        let temp: String = Phong.current?.maPhong.replacingOccurrences(of: "_", with: "") ?? ""
        let temp1: String = String(temp.characters.reversed())
        passwordTextField.text = temp1
        NguoiThueTroDB.add(id: usernameTextField.text!, token: passwordTextField.text!)
        Phong.current?.thuePhong = ThuePhong(id: usernameTextField.text!, token: passwordTextField.text!)
        NhaTro.current?.updatePhongTro(old: Phong.current!, new: Phong.current!)
        
    }
    
    /// Get string to copy to clipboard
    ///
    /// - Returns: string of account's information
    func getInfoToCopy() -> String{
        var result = "THÔNG TIN TÀI KHOẢN \n"
        result += "Nhà trọ " + hostelTextField.text! + "\n"
        result += "Phòng " + roomTextField.text! + "\n"
        result += "Tên đăng nhập: " + usernameTextField.text! + "\n"
        result += "Mật khẩu: " + passwordTextField.text! + "\n"
        return result
    }
    
    // MARK: - Delegate
    
    // Text Field Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == hostelTextField{
            self.hostelChoosenPickerView.isHidden = false
            self.roomChoosenPickerView.isHidden = true
        }
        if textField == roomTextField{
            self.roomChoosenPickerView.isHidden = false
            self.hostelChoosenPickerView.isHidden = true
        }
        textField.endEditing(true)
    }
    
    // Picker View Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == hostelChoosenPickerView{
            return listOfHostel().count
        }
        if pickerView == roomChoosenPickerView {
            return listOfRoomOf().count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == hostelChoosenPickerView{
            return listOfHostel()[row].ten
        }
        if pickerView == roomChoosenPickerView {
            return listOfRoomOf()[row].ten
        }
        return nil

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
        if pickerView == hostelChoosenPickerView{
            
            updateCurrentNhaTro()
            NhaTro.current = listOfHostel()[row]
            roomChoosenPickerView.reloadAllComponents()
            updateTextField(hostelTextField, with: listOfHostel()[row].ten!)
        }
        if pickerView == roomChoosenPickerView {
            if listOfRoomOf().count > 0{
                updateCurrentPhongTro()
                Phong.current = listOfRoomOf()[row]
            }
            updateTextField (roomTextField, with: listOfRoomOf()[row].ten)

        }
        pickerView.isHidden = true
    }
    
    
    
    // MARK: - Actions
    
    @IBAction func tapRentButton(_ sender: GaiaUIButton) {
        copyInfoButton.isEnabled = true
        sender.isEnabled = false
        generateAccount()

        showPopUpMessage(title: "Đã cho thuê phòng", message: getInfoToCopy(), view: self)
    }
    
    @IBAction func tapCopyButton(_ sender: GaiaUIButton) {
        let pasteBoard = UIPasteboard.general
        pasteBoard.string = getInfoToCopy()
        showPopUpMessage(title: "Đã sao chép", message: getInfoToCopy(), view: self)
    }
    

}
