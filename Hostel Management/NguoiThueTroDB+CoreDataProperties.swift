//
//  NguoiThueTroDB+CoreDataProperties.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/16/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation
import CoreData


extension NguoiThueTroDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NguoiThueTroDB> {
        return NSFetchRequest<NguoiThueTroDB>(entityName: "NguoiThueTro");
    }

    @NSManaged public var id: String?
    @NSManaged public var matoken: String?
    
    public static func getEntityDescription(context: NSManagedObjectContext)-> NSEntityDescription{
        return NSEntityDescription.entity(forEntityName: "NguoiThueTro", in: context)!
    }
    
    /// Get TaiKhoanPhong by id
    ///
    /// - Parameter id: id of TaiKhoanPhong
    /// - Returns: TaiKhoanPhong or nil
    public static func get(with id: String)->TaiKhoanPhong?{
        let context = getContext()
        if context == nil{
            return nil
        }
        let fetchRequest: NSFetchRequest<NguoiThueTroDB> = NguoiThueTroDB.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "%K == %@", "id", id)
        fetchRequest.predicate = predicate
        
        do{
            let result = try context?.fetch(fetchRequest)
            if (result?.count)! > 0{
                return TaiKhoanPhong(id: id, matoken: (result?[0].matoken!)!)
            }
        } catch {
            let fetchError = error as NSError
            print(fetchError)
            return nil
        }
        return nil
    }
    
    /// Add new NguoiThueTro
    ///
    /// - Parameters:
    ///   - id: id value
    ///   - token: matoken value
    /// - Returns: true or false
    public static func add(id: String, token: String)->Bool{
        let context = getContext()
        if context == nil{
            return false
        }
        let entity = NguoiThueTroDB.getEntityDescription(context: context!)
        let record = NguoiThueTroDB(entity: entity, insertInto: context!)
        
        record.id = id
        record.matoken = token
        
        return saveContext(context!, with: id)
    }
    
    /// Delete NguoiThueTro
    ///
    /// - Parameter id: id to delete
    /// - Returns: true or false
    public static func delete(id: String)->Bool  {
        let context = getContext()
        if context == nil{
            return false
        }
        let fetchRequest: NSFetchRequest<NguoiThueTroDB> = NguoiThueTroDB.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "%K == %@", "id", id)
        fetchRequest.predicate = predicate
        
        do{
            let result = try context?.fetch(fetchRequest)
            context?.delete((result?[0])!)
            return saveContext(context!, with: id)
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return false
    }

}
