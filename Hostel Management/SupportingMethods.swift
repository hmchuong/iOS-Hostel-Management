//
//  SupportingMethods.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/1/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation
import UIKit
import CoreData

/// Show pop up message for user
///
/// - Parameters:
///   - title: Title to show
///   - message: message to show
func showPopUpMessage(title: String, message: String, view: UIViewController){
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(defaultAction)
    
    view.present(alertController, animated: true, completion: nil)
}

/// Save NSManagedObjectContext
///
/// - Parameters:
///   - context: context to save
///   - noti: notification to show when save successfully
func saveContext( _ context: NSManagedObjectContext, with noti: String) -> Bool{
    do{
        try context.save()
        print("SAVED \(noti)")
        return true
    }catch{
        let saveError = error as NSError
        print(saveError)
        return false
    }
}

/// Get account information from UserDefaults
///
/// - Returns: username, password, isChuNha
func readAccountFromUserDefaults() -> (String?, String?, Bool?){
    let preferences = UserDefaults.standard
    let username: String? = preferences.object(forKey: KEYUSERNAME) as! String?
    let password: String? = preferences.object(forKey: KEYPASSWORD) as! String?
    let isChuNha: Bool? = preferences.object(forKey: KEYISCHUNHA) as! Bool?
    return (username, password, isChuNha)
}

/// Write current user information to share preferences
///
/// - Parameters:
///   - username: current username
///   - password: current password
///   - isChuNha: chunha account or not
/// - Returns: true if successful, false if otherwise
func writeToUserDefaults(username: String, password: String, isChuNha: Bool) -> Bool{
    let preferences = UserDefaults.standard
    preferences.set(username, forKey: KEYUSERNAME)
    preferences.set(password, forKey: KEYPASSWORD)
    preferences.set(isChuNha, forKey: KEYISCHUNHA)
    return preferences.synchronize()
}

extension UIViewController{
    /// Push another view controller
    ///
    /// - Parameters:
    ///   - viewController: view controller to push
    ///   - animation: with or without animation
    public func moveTo( viewController: String, animation: Bool){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let idLogin = viewController
        let destination = storyboard.instantiateViewController(withIdentifier: idLogin)
        navigationController?.pushViewController(destination, animated: animation)
    }
    
    /// Present another view controller
    ///
    /// - Parameters:
    ///   - viewController: view controller to present
    ///   - animation: with or without animation
    public func changeTo( viewController: String, animation: Bool){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let idLogin = viewController
        let destination = storyboard.instantiateViewController(withIdentifier: idLogin)
        self.present(destination, animated: true, completion: nil)

    }
}

extension NSDate
{
    convenience
    init(dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        let d = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:d)
    }
}

func decimalWithString(string: String) -> NSDecimalNumber {
    let formatter = NumberFormatter()
    formatter.generatesDecimalNumbers = true
    return formatter.number(from: string) as? NSDecimalNumber ?? 0
}

func getContext() -> NSManagedObjectContext?{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    if #available(iOS 10.0, *) {
        return appDelegate.persistentContainer.viewContext
        
    } else {
        print("ios must be 10.0")
        return nil
    }
}

func updateCurrentNhaTro(){
    if NhaTro.current != nil{
        let len: Int = ChuNha.getInstance().nhaTro?.count ?? 0
        for i in 0..<len{
            if ChuNha.getInstance().nhaTro?[i].maNhaTro == NhaTro.current?.maNhaTro{
                ChuNha.getInstance().nhaTro?[i] = NhaTro.current!
            }
        }
    }
}

func updateCurrentPhongTro(){
    if Phong.current != nil{
        let len: Int = NhaTro.current?.phongTro.count ?? 0
        for i in 0..<len{
            if NhaTro.current?.phongTro[i].maPhong == Phong.current?.maPhong{
                NhaTro.current?.phongTro[i] = Phong.current!
            }
        }
    }
}
