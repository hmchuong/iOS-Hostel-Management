//
//  NhaTroDB+CoreDataProperties.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/16/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation
import CoreData


extension NhaTroDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NhaTroDB> {
        return NSFetchRequest<NhaTroDB>(entityName: "NhaTro");
    }

    @NSManaged public var diachi: String?
    @NSManaged public var ten: String?
    @NSManaged public var manhatro: String?
    @NSManaged public var chunha: String?
    
    public static func getEntityDescription(context: NSManagedObjectContext)-> NSEntityDescription{
        return NSEntityDescription.entity(forEntityName: "NhaTro", in: context)!
    }
    
    /// Get NhaTro list of chunha in DB
    ///
    /// - Parameter chunha: tendangnhap of ChuNha
    /// - Returns: list of NhaTro
    public static func getNhaTroOf(_ chunha: String)->[NhaTro]{
        var nhatro = [NhaTro]()
        let context = getContext()
        if context == nil{
            return []
        }
        let fetchRequest: NSFetchRequest<NhaTroDB> = NhaTroDB.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "%K == %@", "chunha", chunha)
        fetchRequest.predicate = predicate
        
        do{
            let result = try context?.fetch(fetchRequest)
            for ins in result!{
                nhatro.append(NhaTro(manhatro: ins.manhatro!, diachi: ins.diachi!, ten: ins.ten!))
            }
            return nhatro
        } catch {
            let fetchError = error as NSError
            print(fetchError)
            return []
        }

    }
    
    /// Add new NhaTro to database
    ///
    /// - Parameters:
    ///   - nhatro: new NhaTro to add
    ///   - chunha: ChuNha of NhaTro
    /// - Returns: true or false
    public static func add(nhatro: NhaTro, of chunha: String)->Bool{
        let context = getContext()
        if context == nil{
            return false
        }
        let entity = NhaTroDB.getEntityDescription(context: context!)
        let record = NhaTroDB(entity: entity, insertInto: context!)
        
        record.chunha = chunha
        record.diachi = nhatro.diaChi
        record.manhatro = nhatro.maNhaTro
        record.ten = nhatro.ten
        
        return saveContext(context!, with: nhatro.ten!)
    }
    
    /// Delete NhaTro
    ///
    /// - Parameter nhatro: nhatro to delete
    /// - Returns: true or false
    public static func delete(nhatro: NhaTro)->Bool  {
        let context = getContext()
        if context == nil{
            return false
        }
        let fetchRequest: NSFetchRequest<NhaTroDB> = NhaTroDB.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
    
        let predicate = NSPredicate(format: "%K == %@", "manhatro", nhatro.maNhaTro)
        fetchRequest.predicate = predicate
    
        do{
            let result = try context?.fetch(fetchRequest)
            context?.delete((result?[0])!)
            return saveContext(context!, with: nhatro.maNhaTro)
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return false
    }
    
    /// Update NhaTro information
    ///
    /// - Parameters:
    ///   - old: old NhaTro
    ///   - new: new NhaTro
    /// - Returns: true or false
    public static func update(old: NhaTro, new: NhaTro) -> Bool{
        let context = getContext()
        if context == nil{
            return false
        }
        let fetchRequest: NSFetchRequest<NhaTroDB> = NhaTroDB.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "%K == %@", "manhatro", old.maNhaTro)
        fetchRequest.predicate = predicate
        
        do{
            let result = try context?.fetch(fetchRequest)
            
            let nhatro = result?[0]
            nhatro?.ten = new.ten
            nhatro?.diachi = new.diaChi
            
            do {
                try nhatro?.managedObjectContext?.save()
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
}
