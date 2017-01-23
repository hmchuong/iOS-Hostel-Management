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

public class ChuNha{
    // MARK: - Properties
    private var tenDangNhap: String?
    private var matKhau: String?
    private var email: String?
    public var hoTen: String?
    public var soDienThoai: String?
    public var nhaTro: [NhaTro]?
    
    static var instance: ChuNha? = nil
    
    
    // MARK: - Methods
    public init(tendangnhap: String?, matkhau: String?, hoten: String?, sodienthoai: String?, email: String?){
        self.tenDangNhap = tendangnhap
        self.matKhau = matkhau
        self.hoTen = hoten
        self.soDienThoai = sodienthoai
        self.email = email
        self.nhaTro = []
    }
    
    public init(){
        self.tenDangNhap = ""
        self.matKhau = ""
        self.email = ""
        self.hoTen = ""
        self.soDienThoai = ""
        self.nhaTro = []
    }
    
    // Get information methods
    public func getTendangnhap()-> String?{
        return self.tenDangNhap
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
        
        let (chunha, message) = ChuNhaDB.login(tendangnhap: tendangnhap, matkhau: matkhau)
        if chunha != nil{
            ChuNha.instance = chunha
            return (true, message)
        }else{
            return (false, message)
        }
    }
    
    /// Sign up this account to database
    ///
    /// - Returns: (True, message) if successful or (False, Message) if unsuccessful
    public func signUp() -> (Bool, String){
        if tenDangNhap == nil || matKhau == nil{
            return (false, unsuccessfulSignUp)
        }
        return ChuNhaDB.signUp(tendangnhap: self.tenDangNhap!, matkhau: self.matKhau!, hoten: self.hoTen!, email: self.email!, sodienthoai: self.soDienThoai!)
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
        if old != self.matKhau{
            return (false, "Mật khẩu không khớp")
        }
        self.matKhau = new
        _ = update()
        return (true, "Đổi mật khẩu thành công")
    }
    
    /// Update hoten and sodienthoai to database
    public func update() -> Bool{
        return ChuNhaDB.update(tendangnhap: self.tenDangNhap!, hoten: self.hoTen!, sodienthoai: self.soDienThoai!, matkhau: self.matKhau!)
    }
    
    public func getNhaTro(){
        self.nhaTro = NhaTroDB.getNhaTroOf(tenDangNhap!)
    }
        
    /// Add new NhaTro to database
    ///
    /// - Parameter nhatro: new NhaTro
    /// - Returns: true or false
    public func addNhaTro(_ nhatro: NhaTro)->(Bool, String){
        for ins in ChuNha.getInstance().nhaTro!{
            if ins.ten == nhatro.ten{
                return (false, existedHostel)
            }
        }
        nhatro.maNhaTro = generateMaNhaTro()
        if NhaTroDB.add(nhatro: nhatro, of: self.tenDangNhap!){
            self.nhaTro?.append(nhatro)
            return (true,"")
        }else{
            return (false, errorDB)
        }
        
    }
    
    /// Delete NhaTro element
    ///
    /// - Parameter nhatro: NhaTro to delete
    /// - Returns: true or false
    public func deleteNhaTro(_ nhatro: NhaTro)->Bool{
        for ins in nhatro.phongTro{
            _ = nhatro.deletePhong(ins)
        }
        return NhaTroDB.delete(nhatro: nhatro)
        
    }
    
    /// Update NhaTRo
    ///
    /// - Parameters:
    ///   - old: old value
    ///   - new: new value
    /// - Returns: true or false
    public func updateNhaTro(old: NhaTro, new: NhaTro)-> Bool{
        return NhaTroDB.update(old: old, new: new)
    }
    
    /// Generate unique MaNhaTro
    ///
    /// - Returns: String of MaNhaTro
    private func generateMaNhaTro()-> String{
        var ma = 0
        let ten: String = self.tenDangNhap ?? ""
        let max: Int = self.nhaTro?.count ?? 0
        for i in 0...max{
            var exist = false
            for ins in (self.nhaTro)!{
                if ins.maNhaTro == "\(ten)_\(i)"{
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
