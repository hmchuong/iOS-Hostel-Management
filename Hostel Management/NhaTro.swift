//
//  NhaTro.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/12/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import Foundation

public class NhaTro{
    // MARK: - Properties
    var soPhongTrong: Int
    var diaChi: String? = nil
    var ten: String? = nil
    var maNhaTro: String
    var phongTro: [Phong] = []{
        didSet{
            soPhongTrong = 0
            for ins in self.phongTro{
                if ins.tinhTrang == .trong{
                    soPhongTrong += 1
                }
            }
        }
    }
    public static var current: NhaTro? = nil
    
    // MARK: - Methods
    public init(manhatro: String, diachi: String, ten: String){
        self.diaChi = diachi
        self.ten = ten
        self.soPhongTrong = 0
        self.maNhaTro = manhatro
    }
    
    /// Get list of PhongTro
    public func getPhongTro(){
        self.phongTro = PhongDB.getPhongTroOf(self.maNhaTro)
    }
    
    /// Add new PhongTro to database
    ///
    /// - Parameter phong: new Phong
    /// - Returns: true or false
    public func addPhongTro(_ phong: Phong) -> (Bool, String){
        for ins in self.phongTro{
            if ins.ten == phong.ten{
                return (false, existedRoom)
            }
        }
        phong.maPhong = generateMaPhongTro()
        if PhongDB.add(phongtro: phong, of: self.maNhaTro){
            self.phongTro.append(phong)
            return (true, "")
        }else{
            return (false, errorDB)
        }
    }
    
    /// Update PhongTro value
    ///
    /// - Parameters:
    ///   - old: old value
    ///   - new: new value
    /// - Returns: true or false
    public func updatePhongTro(old: Phong, new: Phong)-> Bool{
        return PhongDB.update(old: old, new: new, of: self.maNhaTro)
    }

    /// Delete Phong
    ///
    /// - Parameter phong: phong to delete
    /// - Returns: true or false
    public func deletePhong(_ phong: Phong) -> Bool{
        let id: String = phong.thuePhong?.taiKhoanPhong?.id ?? ""
        if id != ""{
            _ = NguoiThueTroDB.delete(id: id)
        }
        return PhongDB.delete(phong: phong)
        // TODO: - Delete HoSoNhanKhau, HinhAnh, HoaDon
    }
    
    /// Generate unique MaPhong
    ///
    /// - Returns: String of MaPhong
    private func generateMaPhongTro()-> String{
        var ma = 0
        let ten: String = self.maNhaTro 
        let max: Int = self.phongTro.count 
        for i in 0...max{
            var exist = false
            for ins in self.phongTro{
                if ins.maPhong == "\(ten)_\(i)"{
                    exist = true
                }
            }
            if exist == false{
                ma = i
            }
            
        }
        return "\(ten)_\(ma)"
    }

}

