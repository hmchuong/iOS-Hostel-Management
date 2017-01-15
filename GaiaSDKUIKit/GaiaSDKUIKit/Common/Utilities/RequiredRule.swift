//
//  RequiredRule.swift
//  GaiaSDKUIKit
//
//  Created by Chuong Huynh on 12/5/16.
//  Copyright © 2016 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation

/// Rule to ensure the text field is not empty
public class RequiredRule: Rule{
    
    // MARK: - Properties
    /// Message to show when rule is broken
    private var message: String
    
    // MARK: - Methods
    /// Constructor
    ///
    /// - Parameter message: error message of the rule
    public init(message: String = String.requiredRuleMessage){
        self.message = message
    }
    
    /// Validate the value is not empty
    ///
    /// - Parameter value: string to check
    /// - Returns: **true** if string is not empty, otherwise return **false**
    public func validate(value: String) -> Bool {
        return !value.isEmpty
    }
    
    /// Get the error message of the rule
    ///
    /// - Returns: error message
    public func errorMessage() -> String {
        return message
    }
    
    
}
