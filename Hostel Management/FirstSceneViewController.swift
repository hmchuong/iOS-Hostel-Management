//
//  FirstSceneViewController.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 12/31/16.
//  Copyright © 2016 chuonghuynh. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class FirstSceneViewController: UIViewController {

    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Add something to database 
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if #available(iOS 10.0, *) {
            let context = appDelegate.persistentContainer.viewContext
            
            // Save default information to GioiTinh database
            saveToGioiTinhDB(context: context)
            
            // Save default information to TinhTrang database
            saveToTinhTrangDB(context: context)
            
            // Save default information to LoaiDichVu database
            saveToLoaiDichVuDB(context: context)
        } else {
            print("ios must be 10.0")
        }
        checkFirstView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// Move to the main view of apps
    func checkFirstView(){
        // Check share preferences for key username and password
        // if key == nil or empty --> show login, otherwise show main
        let (username, password, isChuNha) = readAccountFromUserDefaults()
        
        // If the first time login or logged out
        if username == nil || (username?.isEmpty)! || password == nil || (password?.isEmpty)!{
            self.moveTo(viewController: "loginScreenVC", animation: false)
            self.dismiss(animated: true, completion: {})
        }else{
            // Log in with ChuNha account
            if isChuNha!{
                // Move to main screen for ChuNha
                let (success, _): (Bool, String) = ChuNha.login(tendangnhap: username!, matkhau: password!)
                
                // if login successful
                if success {
                    self.moveTo(viewController: "mainVC", animation: false)
                    self.dismiss(animated: true, completion: {})
                }else{
                    self.moveTo(viewController: "loginScreenVC", animation: false)
                    self.dismiss(animated: true, completion: {})
                }
            }else{
                // TODO: - Move to main screen for NguoiThue
            }
        }
    }
    
    /// Save information to GioiTinh database
    ///
    /// - Parameter context: context to save
    func saveToGioiTinhDB(context: NSManagedObjectContext){
        
        let fetchRequest: NSFetchRequest<GioiTinhDB> = GioiTinhDB.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        let values = [GioiTinh.nam.rawValue, GioiTinh.nu.rawValue]
        // Save each value to database
        for value in values{
            let predicate = NSPredicate(format: "%K == %@", "mota", value)
            fetchRequest.predicate = predicate
            
            do{
                let result = try context.fetch(fetchRequest)
                if result.count == 0{
                    let entity = NSEntityDescription.entity(forEntityName: "GioiTinh", in: context)
                    let record = GioiTinhDB(entity: entity!, insertInto: context)
                    
                    record.mota = value
                    
                    _ = saveContext(context, with: value)
                }
            } catch {
                let fetchError = error as NSError
                print(fetchError)
            }
        }
    }
    
    /// Save information to TinhTrang database
    ///
    /// - Parameter context: context to save
    func saveToTinhTrangDB(context: NSManagedObjectContext){
        
        let fetchRequest: NSFetchRequest<TinhTrangDB> = TinhTrangDB.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        let values = [TinhTrang.trong.rawValue, TinhTrang.daThue.rawValue, TinhTrang.suaChua.rawValue]
        // Save each value to database
        for value in values{
            let predicate = NSPredicate(format: "%K == %@", "mota", value)
            fetchRequest.predicate = predicate
            
            do{
                let result = try context.fetch(fetchRequest)
                if result.count == 0{
                    let entity = NSEntityDescription.entity(forEntityName: "TinhTrang", in: context)
                    let record = TinhTrangDB(entity: entity!, insertInto: context)
                    
                    record.mota = value
                    
                    _ = saveContext(context, with: value)
                }
            } catch {
                let fetchError = error as NSError
                print(fetchError)
            }
        }
    }
    
    /// Save information to LoaiDichVu database
    ///
    /// - Parameter context: context to save
    func saveToLoaiDichVuDB(context: NSManagedObjectContext){
        
        let fetchRequest: NSFetchRequest<LoaiDichVuDB> = LoaiDichVuDB.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        let values = [LoaiDichVu.dien.rawValue, LoaiDichVu.nuoc.rawValue, LoaiDichVu.internet.rawValue]
        // Save each value to database
        for value in values{
            let predicate = NSPredicate(format: "%K == %@", "ten", value)
            fetchRequest.predicate = predicate
            
            do{
                let result = try context.fetch(fetchRequest)
                if result.count == 0{
                    let entity = NSEntityDescription.entity(forEntityName: "LoaiDichVu", in: context)
                    let record = LoaiDichVuDB(entity: entity!, insertInto: context)
                    
                    record.ten = value
                    
                    _ = saveContext(context, with: value)
                }
            } catch {
                let fetchError = error as NSError
                print(fetchError)
            }
        }
    }
    
}
