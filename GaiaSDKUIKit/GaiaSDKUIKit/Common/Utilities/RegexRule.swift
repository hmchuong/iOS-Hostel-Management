//
//  RegexRule.swift
//  GaiaSDKUIKit
//
//  Created by Chuong Huynh on 12/5/16.
//  Copyright © 2016 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation

/// Rule to check the content matched the REGEX
public class RegexRule: Rule{
    // MARK: - Properties
    /// REGEX to check
    public var REGEX: String
    
    /// Message is shown when error
    private var message: String
    
    // MARK: - Methods
    public init(){
        self.REGEX = String.empty
        self.message = String.empty
    }
    
    /// Constructor
    ///
    /// - Parameters:
    ///   - regex: Regex string
    ///   - message: message text
    public init(regex: String, message: String = String.REGEXRuleMessage){
        self.REGEX = regex
        self.message = message
    }
    
    /// Validate the value is matched the REGEX
    ///
    /// - Parameter value: string to check
    /// - Returns: **true** if string is matched, otherwise return **false**
    public func validate(value: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: value)
    }
    
    /// Get the error message of the rule
    ///
    /// - Returns: error message
    public func errorMessage() -> String {
        return message
    }
}
