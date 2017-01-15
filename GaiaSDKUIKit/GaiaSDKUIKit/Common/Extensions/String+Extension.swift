//
//  SwiftyString.swift
//  Holler
//
//  Created by Phong Le on 10/12/15.
//  Copyright © 2015 Rainmaker-labs. All rights reserved.
//

import Foundation
import UIKit
// MARK: - variable
public extension String {
	var wordList: [String] {
        return components(separatedBy: .punctuationCharacters)
            .joined(separator: "")
            .components(separatedBy: " ")
            .filter{!$0.isEmpty}
	}
    
	var floatValue: Float {
		return (self as NSString).floatValue
	}

	var lastPathComponent: String {

		get {
			return (self as NSString).lastPathComponent
		}
	}
	var pathExtension: String {

		get {

			return (self as NSString).pathExtension
		}
	}
	var stringByDeletingLastPathComponent: String {

		get {

			return (self as NSString).deletingLastPathComponent
		}
	}
	var stringByDeletingPathExtension: String {

		get {

			return (self as NSString).deletingPathExtension
		}
	}
	var pathComponents: [String] {

		get {

			return (self as NSString).pathComponents
		}
	}

	var isBlank: Bool {
		get {
			let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
			return trimmed.isEmpty
		}
	}
    
    // MARK: - Default Strings
    static let empty = ""
    // - - For rules
    static let confirmationRuleMessage = "This field does not match"
    static let requiredRuleMessage = "This field is required"
    static let REGEXRuleMessage = "Invalid Regular Expression"
    static let maxLengthRuleMessage = "Must be at most %ld characters long"
    static let minLengthRuleMessage = "Must be at least %ld characters long"
}

// MARK: - Methods
public extension String {

    //Hex string to UIColor
	public func colorWithHexString() -> UIColor {
        if (self == "clear"){
            return UIColor.clear
        }
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )

	}

	public func isEmail() -> Bool {
		let regex = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$",
			options: [.caseInsensitive])

		return regex.firstMatch(in: self, options: [],
			range: NSMakeRange(0, utf16.count)) != nil
	}

	public func isValidEmail() -> Bool {
		// println("validate calendar: \(testStr)")
		let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"

		let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
		return emailTest.evaluate(with: self)
	}

	public func isPhoneNumber() -> Bool {
		let regex = try! NSRegularExpression(pattern: "^[0-9]{5,15}",
			options: [.caseInsensitive])

		return regex.firstMatch(in: self, options: [],
			range: NSMakeRange(0, utf16.count)) != nil
	}

	public func isCountry() -> Bool {
		let regex = try! NSRegularExpression(pattern: "^[0-9]{1,5}",
			options: [.caseInsensitive])

		return regex.firstMatch(in: self, options: [],
			range: NSMakeRange(0, utf16.count)) != nil
	}

	public func stringByAppendingPathComponent(_ path: String) -> String {

		let nsSt = self as NSString

		return nsSt.appendingPathComponent(path)
	}

	public func stringByAppendingPathExtension(_ ext: String) -> String? {

		let nsSt = self as NSString

		return nsSt.appendingPathExtension(ext)
	}

	/*
	 let word = "Apple"
	 let searchCharacter: Character = "p"
	 let index = word.lowercaseString.characters.indexOf(searchCharacter)
	 print("Index: \(index)")
	 */
	public func indexOfCharacter(_ char: Character) -> Int? {
		if let idx = self.characters.index(of: char) {
			return self.characters.distance(from: self.startIndex, to: idx)
		}
		return nil
	}
}

public extension String {

    public static func className(aClass: AnyClass) -> String {
        
        //Swift 3.0
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
        
        ////Swift 2.3, it predicated on swift 3.0
        //return NSStringFromClass(aClass).componentsSeparatedByString(".").last!
    }
}
