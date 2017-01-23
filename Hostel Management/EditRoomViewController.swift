//
//  EditRoomViewController.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/15/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import UIKit
import GaiaSDKUIKit

class EditRoomViewController: UIViewController,UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource  {

    // MARK: - Properties
    var phongtro: Phong?
    var currentState: TinhTrang = .trong
    
    @IBOutlet weak var roomNameTextField: UITextField!
    @IBOutlet weak var roomAreaTextField: UITextField!
    @IBOutlet weak var roomPriceTextField: UITextField!
    @IBOutlet weak var imagesButton: GaiaUIButton!
    @IBOutlet weak var humansButton: GaiaUIButton!
    @IBOutlet weak var billsButton: GaiaUIButton!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var stateButton: GaiaUIButton!
    @IBOutlet weak var statePickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagesButton.isHidden = true
        humansButton.isHidden = true
        billsButton.isHidden = true
        stateButton.isHidden = true
        statePickerView.isHidden = true
        saveButton.isEnabled = false
        
        if let phongtro = phongtro {
            navigationItem.title = "Phòng \(phongtro.ten)"
            roomNameTextField.text = phongtro.ten
            roomAreaTextField.text = String(phongtro.dienTich)
            roomPriceTextField.text = String(describing: phongtro.giaPhong)
            currentState = phongtro.tinhTrang
            stateButton.setTitle("Tình trạng: \(currentState.rawValue)", for: .normal)
            imagesButton.isHidden = false
            humansButton.isHidden = false
            billsButton.isHidden = false
            stateButton.isHidden = false
            if currentState == .trong {
                stateButton.isEnabled = false
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        if textField == roomNameTextField{
            updateSaveButtonState()
            let name: String = textField.text ?? ""
            navigationItem.title = "Phòng \(name)"
        }
    }
    
    // MARK: - Private methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let maphong = roomNameTextField.text!
        let dientich = roomAreaTextField.text!
        let giaphong = roomPriceTextField.text!
        saveButton.isEnabled = (maphong != phongtro?.maPhong) || (Double(dientich) != phongtro?.dienTich) || (giaphong != String(describing: phongtro?.giaPhong))
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let button = sender as? UIBarButtonItem
        if button === saveButton{
            let isAdd = phongtro == nil
            let ten = roomNameTextField.text ?? ""
            let dientich = Double(roomAreaTextField.text!) ?? 0
            let giaphong = decimalWithString(string: roomPriceTextField.text!) 
            let tinhtrang = currentState
            let nguoithue: String = phongtro?.thuePhong?.taiKhoanPhong?.id ?? ""
            let maphong: String = phongtro?.maPhong ?? ""
            phongtro = Phong(maphong: maphong, ten: ten, dientich: dientich, giaphong: giaphong, tinhtrang: tinhtrang, nguoithue: nguoithue)
            if isAdd{
                let (ok, message) = (NhaTro.current?.addPhongTro(phongtro!))!
                if ok == false{
                    phongtro = nil
                    showPopUpMessage(title: "Không thể tạo phòng trọ", message: message, view: self)
                    return false
                }
            }
            return true
        }
        return true
    }

    // MARK: - Picker View Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let tinhtrang = [TinhTrang.daThue.rawValue, TinhTrang.suaChua.rawValue, TinhTrang.trong.rawValue]
        return tinhtrang[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let tinhtrang = [TinhTrang.daThue, TinhTrang.suaChua, TinhTrang.trong]
        currentState = tinhtrang[row]
        stateButton.setTitle("Tình trạng: \(currentState.rawValue)", for: .normal)
        // TODO: - Ask user when making room emptying or repairing
        pickerView.isHidden = true
    }

    // MARK: - Actions
    @IBAction func tapCancel(_ sender: UIBarButtonItem) {
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
    
    @IBAction func tapStateButton(_ sender: GaiaUIButton) {
        statePickerView.isHidden = false
    }
    
    
    

}
