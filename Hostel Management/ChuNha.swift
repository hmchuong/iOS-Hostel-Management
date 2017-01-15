//
//  ChuNha.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/6/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ChuNha{
    // MARK: - Properties
    private var tendangnhap: String?
    private var matkhau: String?
    private var email: String?
    public var hoten: String?
    public var sodienthoai: String?
    public var nhatros: [NhaTro]?
    
    static var instance: ChuNha? = nil
    
    
    // MARK: - Methods
    public init(tendangnhap: String?, matkhau: String?, hoten: String?, sodienthoai: String?, email: String?){
        self.tendangnhap = tendangnhap
        self.matkhau = matkhau
        self.hoten = hoten
        self.sodienthoai = sodienthoai
        self.email = email
        self.nhatros = []
    }
    
    public init(){
        self.tendangnhap = ""
        self.matkhau = ""
        self.email = ""
        self.hoten = ""
        self.sodienthoai = ""
        self.nhatros = []
    }
    
    // Get information methods
    public func getTendangnhap()-> String?{
        return self.tendangnhap
    }
    
    public func getEmail()-> String?{
        return self.email
    }
    
    /// Get instance of current ChuNha
    ///
    /// - Returns: current ChuNha
    public static func getInstance()->ChuNha {
        if instance == nil{
            instance = ChuNha()
        }
        return instance!
    }
    
    /// Login and get account information
    ///
    /// - Parameters:
    ///   - tendangnhap: tendangnhap of account to login
    ///   - matkhau: matkhau of account to login
    /// - Returns: true/false and message
    public static func login(tendangnhap: String, matkhau: String)-> (Bool, String){
        if tendangnhap.isEmpty || matkhau.isEmpty{
            return (false, unsuccessfulLogin)
        }
        ChuNha.getInstance().tendangnhap = tendangnhap
        ChuNha.getInstance().matkhau = matkhau
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if #available(iOS 10.0, *) {
            let context = appDelegate.persistentContainer.viewContext
            if ChuNha.getInstance().getFromDB(with: context){
                return (true, successfulLogin)
            }else{
                return (false, wrongAccount)
            }
            
        } else {
            print("ios must be 10.0")
        }
        return(false,undefinedError)
    }
    
    /// Sign up this account to database
    ///
    /// - Returns: (True, message) if successful or (False, Message) if unsuccessful
    public func signUp() -> (Bool, String){
        if tendangnhap == nil || matkhau == nil{
            return (false, unsuccessfulSignUp)
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if #available(iOS 10.0, *) {
            let context = appDelegate.persistentContainer.viewContext
            // Check the unique account on database
            if !notYetInDB(with: context){
                return (false, existedAccount)
            }
            // If account isn't there yet, insert to database, return successful
            if addToDB(context){
                return (true, successfulSignUp)
            }else{
                return (false, undefinedError)
            }
            
        } else {
            print("ios must be 10.0")
        }
        return(false,undefinedError)
    }
    
    /// Sign out
    public func signOut(){
        ChuNha.instance = nil
    }
    
    /// Update new pasword
    ///
    /// - Parameters:
    ///   - old: old pasword
    ///   - new: new password
    /// - Returns: true/false and message
    public func updatePassword(old: String, new: String) -> (Bool, String){
        if old != self.matkhau{
            return (false, "Mật khẩu không khớp")
        }
        self.matkhau = new
        _ = update()
        return (true, "Đổi mật khẩu thành công")
    }
    
    /// Update hoten and sodienthoai to database
    public func update() -> Bool{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if #available(iOS 10.0, *) {
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest: NSFetchRequest<ChuNhaDB> = ChuNhaDB.fetchRequest()
            fetchRequest.returnsObjectsAsFaults = false
            
            let predicate = NSPredicate(format: "%K == %@", "tendangnhap", self.tendangnhap!)
            fetchRequest.predicate = predicate
            
            do{
                let result = try context.fetch(fetchRequest)
                
                let chunha = result[0]
                chunha.hoten = self.hoten
                chunha.sodienthoai = self.sodienthoai
                chunha.matkhau = self.matkhau
                
                do {
                    try chunha.managedObjectContext?.save()
                    print ("UPDATE successfully")
                    return true
                }catch{
                    let saveError = error as NSError
                    print(saveError)
                }
            } catch {
                let fetchError = error as NSError
                print(fetchError)
            }

        } else {
            print("ios must be 10.0")
        }
        return false
    }
    
    /// Check account is existed
    ///
    /// - Parameter context: NSManagedObjectContext
    /// - Returns: true if account is not existed in DB, false if otherwise
    private func notYetInDB(with context: NSManagedObjectContext) -> Bool{
        let fetchRequest: NSFetchRequest<ChuNhaDB> = ChuNhaDB.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "%K == %@", "tendangnhap", self.tendangnhap!)
        fetchRequest.predicate = predicate
        
        do{
            let result = try context.fetch(fetchRequest)
            if result.count == 0{
                return true
            }else{
                return false
            }
        } catch {
            let fetchError = error as NSError
            print(fetchError)
            return false
        }

    }
    
    /// Add new account to database
    ///
    /// - Parameter context: NSManagedObjectContext
    /// - Returns: true if successful, false if otherwise
    private func addToDB(_ context: NSManagedObjectContext) -> Bool{
        let entity = NSEntityDescription.entity(forEntityName: "ChuNha", in: context)
        let record = ChuNhaDB(entity: entity!, insertInto: context)
        
        record.tendangnhap = self.tendangnhap
        record.matkhau = self.matkhau
        record.hoten = self.hoten
        record.sodienthoai = self.sodienthoai
        record.email = self.email
        
        return saveContext(context, with: self.tendangnhap!)

    }
    
    /// Get account from database
    ///
    /// - Parameter context: context
    /// - Returns: true if successful, false if otherwise
    private func getFromDB(with context: NSManagedObjectContext) -> Bool{
        
        let fetchRequest: NSFetchRequest<ChuNhaDB> = ChuNhaDB.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "%K == %@ AND %K == %@", "tendangnhap", self.tendangnhap!, "matkhau", self.matkhau!)
        fetchRequest.predicate = predicate
        
        do{
            let result = try context.fetch(fetchRequest)
            if result.count == 0{
                return false
            }else{
                self.hoten = result[0].hoten
                self.email = result[0].email
                self.sodienthoai = result[0].sodienthoai
                
                // Get NhaTro(s)
                let nhatros: Set<NhaTroDB> = result[0].nhatro! as! Set<NhaTroDB>
                for nhatro in nhatros{
                    self.nhatros?.append(NhaTro(diachi: nhatro.diachi!, ten: nhatro.ten!))
                }
                
                return true
            }
        } catch {
            let fetchError = error as NSError
            print(fetchError)
            return false
        }
        
    }
    
    /// Add new NhaTro to databse
    ///
    /// - Parameter nhatro: new NhaTro
    /// - Returns: true or false
    public func addNhaTro(_ nhatro: NhaTro)->Bool{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if #available(iOS 10.0, *) {
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest: NSFetchRequest<ChuNhaDB> = ChuNhaDB.fetchRequest()
            fetchRequest.returnsObjectsAsFaults = false
            
            let predicate = NSPredicate(format: "%K == %@", "tendangnhap", self.tendangnhap!)
            fetchRequest.predicate = predicate
            
            do{
                let result = try context.fetch(fetchRequest)
                let entityDescription = NSEntityDescription.entity(forEntityName: "NhaTro", in: context)
                let nhatroDB = NhaTroDB(entity: entityDescription!, insertInto: context)
                nhatroDB.diachi = nhatro.diachi
                nhatroDB.ten = nhatro.ten
                
                result[0].addToNhatro(nhatroDB)
                
                
                do {
                    try result[0].managedObjectContext?.save()
                    print ("Add new NhaTro successfully")
                    return true
                }catch{
                    let saveError = error as NSError
                    print(saveError)
                }
            } catch {
                let fetchError = error as NSError
                print(fetchError)
            }

        } else {
            print("ios must be 10.0")
        }
        return false
    }
    
    /// Delete NhaTro element
    ///
    /// - Parameter nhatro: NhaTro to delete
    /// - Returns: true or false
    public func deleteNhaTro(_ nhatro: NhaTro)->Bool{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if #available(iOS 10.0, *) {
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest: NSFetchRequest<ChuNhaDB> = ChuNhaDB.fetchRequest()
            fetchRequest.returnsObjectsAsFaults = false
            
            let predicate = NSPredicate(format: "%K == %@", "tendangnhap", self.tendangnhap!)
            fetchRequest.predicate = predicate
            
            do{
                let result = try context.fetch(fetchRequest)
                let nhatros: Set<NhaTroDB> = result[0].nhatro! as! Set<NhaTroDB>
                for ins in nhatros{
                    if ins.diachi == nhatro.diachi && ins.ten == nhatro.ten{
                        result[0].removeFromNhatro(ins)
                    }
                }
                
                do {
                    try result[0].managedObjectContext?.save()
                    print ("Delete NhaTro successfully")
                    return true
                }catch{
                    let saveError = error as NSError
                    print(saveError)
                }
            } catch {
                let fetchError = error as NSError
                print(fetchError)
            }
            
        } else {
            print("ios must be 10.0")
        }
        return false
    }
    
    public func updateNhaTro(old: NhaTro, new: NhaTro)-> Bool{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if #available(iOS 10.0, *) {
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest: NSFetchRequest<ChuNhaDB> = ChuNhaDB.fetchRequest()
            fetchRequest.returnsObjectsAsFaults = false
            
            let predicate = NSPredicate(format: "%K == %@", "tendangnhap", self.tendangnhap!)
            fetchRequest.predicate = predicate
            
            do{
                let result = try context.fetch(fetchRequest)
                let nhatros: Set<NhaTroDB> = result[0].nhatro! as! Set<NhaTroDB>
                for ins in nhatros{
                    if ins.diachi == old.diachi && ins.ten == old.ten{
                        ins.diachi = new.diachi
                        ins.ten = new.ten
                    }
                }
                result[0].nhatro = nhatros as NSSet?
                
                do {
                    try result[0].managedObjectContext?.save()
                    print ("Update NhaTro successfully")
                    return true
                }catch{
                    let saveError = error as NSError
                    print(saveError)
                }
            } catch {
                let fetchError = error as NSError
                print(fetchError)
            }
            
        } else {
            print("ios must be 10.0")
        }
        return false
    }
    
}
