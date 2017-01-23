//
//  PhongDB+CoreDataProperties.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/16/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation
import CoreData


extension PhongDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhongDB> {
        return NSFetchRequest<PhongDB>(entityName: "Phong");
    }

    @NSManaged public var dientich: Double
    @NSManaged public var giaphong: NSDecimalNumber?
    @NSManaged public var maphong: String?
    @NSManaged public var ten: String?
    @NSManaged public var nhatro: String?
    @NSManaged public var tinhtrang: Int16
    @NSManaged public var nguoithue: String?
    
    public static func getEntityDescription(context: NSManagedObjectContext)-> NSEntityDescription{
        return NSEntityDescription.entity(forEntityName: "Phong", in: context)!
    }
    
    
    /// Get PhongTro list of nhatro
    ///
    /// - Parameter nhatro: manhatro to get
    /// - Returns: list of PhongTro
    public static func getPhongTroOf(_ nhatro: String)->[Phong]{
        var phongtro = [Phong]()
        let context = getContext()
        if context == nil{
            return []
        }
        let fetchRequest: NSFetchRequest<PhongDB> = PhongDB.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "%K == %@", "nhatro", nhatro)
        fetchRequest.predicate = predicate
        
        do{
            let result = try context?.fetch(fetchRequest)
            for ins in result!{
                phongtro.append(Phong(maphong: ins.maphong!, ten: ins.ten!, dientich: ins.dientich, giaphong: ins.giaphong, tinhtrang: TinhTrang.fromHashValue(hashValue: Int(ins.tinhtrang)), nguoithue: ins.nguoithue!))
            }
            return phongtro
        } catch {
            let fetchError = error as NSError
            print(fetchError)
            return []
        }
        
    }
    
    /// Add new PhongTro to database
    ///
    /// - Parameters:
    ///   - phongtro: new PhongTro to add
    ///   - nhatro: nhatro contain
    /// - Returns: true or false
    public static func add(phongtro: Phong, of nhatro: String)->Bool{
        let context = getContext()
        if context == nil{
            return false
        }
        let entity = PhongDB.getEntityDescription(context: context!)
        let record = PhongDB(entity: entity, insertInto: context!)
        
        record.dientich = phongtro.dienTich
        record.giaphong = phongtro.giaPhong
        record.maphong = phongtro.maPhong
        record.nguoithue = ""
        record.ten = phongtro.ten
        record.tinhtrang = Int16(phongtro.tinhTrang.hashValue)
        record.nhatro = nhatro
        return saveContext(context!, with: phongtro.ten)
    }
    
    /// Delete phong
    ///
    /// - Parameter phong: phong to delete
    /// - Returns: true or false
    public static func delete(phong: Phong)->Bool  {
        let context = getContext()
        if context == nil{
            return false
        }
        let fetchRequest: NSFetchRequest<PhongDB> = PhongDB.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "%K == %@", "maphong", phong.maPhong)
        fetchRequest.predicate = predicate
        
        do{
            let result = try context?.fetch(fetchRequest)
            context?.delete((result?[0])!)
            return saveContext(context!, with: phong.maPhong)
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return false
    }
    
    /// Update Phong information
    ///
    /// - Parameters:
    ///   - old: old Phong
    ///   - new: new Phong
    /// - Returns: true or false
    public static func update(old: Phong, new: Phong, of nhatro: String) -> Bool{
        let context = getContext()
        if context == nil{
            return false
        }
        let fetchRequest: NSFetchRequest<PhongDB> = PhongDB.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        
        let predicate = NSPredicate(format: "%K == %@", "maphong", old.maPhong)
        fetchRequest.predicate = predicate
        
        do{
            let result = try context?.fetch(fetchRequest)
            
            let phong = result?[0]
            phong?.ten = new.ten
            phong?.dientich = new.dienTich
            phong?.giaphong = new.giaPhong
            phong?.nhatro = nhatro
            phong?.nguoithue = new.thuePhong?.taiKhoanPhong?.id ?? ""
            phong?.tinhtrang = Int16(new.tinhTrang.hashValue)
            
            do {
                try phong?.managedObjectContext?.save()
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
