//
//  ChuNhaDB+CoreDataProperties.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/16/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension ChuNhaDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChuNhaDB> {
        return NSFetchRequest<ChuNhaDB>(entityName: "ChuNha");
    }

    @NSManaged public var email: String?
    @NSManaged public var hoten: String?
    @NSManaged public var matkhau: String?
    @NSManaged public var sodienthoai: String?
    @NSManaged public var tendangnhap: String?
    
    public static func getEntityDescription(context: NSManagedObjectContext)-> NSEntityDescription{
        return NSEntityDescription.entity(forEntityName: "ChuNha", in: context)!
    }
    
    /// Check database to log in to system
    ///
    /// - Returns: ChuNha instance if it's existed and nil if it's not existed
    public static  func login(tendangnhap: String, matkhau: String) -> (ChuNha?, String) {
        let context = getContext()
        if context == nil{
            return(nil,undefinedError)
        }
        if let chunha = getFromDB(tendangnhap: tendangnhap, matkhau: matkhau, with: context!){
            return (chunha, successfulLogin)
        }else{
            return (nil, wrongAccount)
        }
    }
    
    /// Update hoten and sodienthoai to database
    public static func update(tendangnhap: String, hoten: String, sodienthoai: String, matkhau: String) -> Bool{
        let context = getContext()
        if context == nil{
            return false
        }
        let fetchRequest: NSFetchRequest<ChuNhaDB> = ChuNhaDB.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "%K == %@", "tendangnhap", tendangnhap)
        fetchRequest.predicate = predicate
        
        do{
            let result = try context?.fetch(fetchRequest)
            
            let chunha = result?[0]
            chunha?.hoten = hoten
            chunha?.sodienthoai = sodienthoai
            chunha?.matkhau = matkhau
            
            do {
                try chunha?.managedObjectContext?.save()
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
        return false

    }
    
    /// Sign up this account to database
    ///
    /// - Returns: (True, message) if successful or (False, Message) if unsuccessful
    public static func signUp(tendangnhap: String, matkhau: String, hoten: String, email: String, sodienthoai: String) -> (Bool, String){
        let context = getContext()
        if context == nil {
            return(false,undefinedError)
        }
        // Check the unique account on database
        if !notYetInDB(tendangnhap: tendangnhap, with: context!){
            return (false, existedAccount)
        }
        // If account isn't there yet, insert to database, return successful
        if addToDB(tendangnhap: tendangnhap, matkhau: matkhau, hoten: hoten, email: email, sodienthoai: sodienthoai, context!){
            return (true, successfulSignUp)
        }else{
            return (false, undefinedError)
        }
    
    }


    /// Get account from database
    ///
    /// - Parameter context: context
    /// - Returns: true if successful, false if otherwise
    private static func getFromDB(tendangnhap: String, matkhau: String, with context: NSManagedObjectContext) -> ChuNha?{
        
        let fetchRequest: NSFetchRequest<ChuNhaDB> = ChuNhaDB.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "%K == %@ AND %K == %@", "tendangnhap", tendangnhap, "matkhau", matkhau)
        fetchRequest.predicate = predicate
        
        do{
            let result = try context.fetch(fetchRequest)
            if result.count == 0{
                return nil
            }else{
                let hoten = result[0].hoten
                let email = result[0].email
                let sodienthoai = result[0].sodienthoai
                
                return ChuNha(tendangnhap: tendangnhap, matkhau: matkhau, hoten: hoten, sodienthoai: sodienthoai, email: email)
            }
        } catch {
            let fetchError = error as NSError
            print(fetchError)
            return nil
        }
        
    }

    
    /// Check account is existed
    ///
    /// - Parameter context: NSManagedObjectContext
    /// - Returns: true if account is not existed in DB, false if otherwise
    private static func notYetInDB(tendangnhap: String, with context: NSManagedObjectContext) -> Bool{
        let fetchRequest: NSFetchRequest<ChuNhaDB> = ChuNhaDB.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "%K == %@", "tendangnhap", tendangnhap)
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
    private static func addToDB(tendangnhap: String, matkhau: String, hoten: String, email: String, sodienthoai: String, _ context: NSManagedObjectContext) -> Bool{
        let entity = ChuNhaDB.getEntityDescription(context: context)
        let record = ChuNhaDB(entity: entity, insertInto: context)
        
        record.tendangnhap = tendangnhap
        record.matkhau = matkhau
        record.hoten = hoten
        record.sodienthoai = sodienthoai
        record.email = email
        
        return saveContext(context, with: tendangnhap)
        
    }

    
}
