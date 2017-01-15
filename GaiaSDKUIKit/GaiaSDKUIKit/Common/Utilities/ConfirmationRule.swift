//
//  ConfirmationRule.swift
//  GaiaSDKUIKit
//
//  Created by Chuong Huynh on 12/5/16.
//  Copyright © 2016 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation
import UIKit

public class ConfirmationRule: Rule {
    
    // MARK: - Properties
    /// The UITextField you want to compare with
    private let confirmTextField: UITextField?
    
    /// Message to show when rule is broken
    private var message: String
    
    // MARK: - Methods
    /// Constructor
    ///
    /// - Parameters:
    ///   - confirmTextField: UITextField to compare with
    ///   - message: text is shown when rule is broken
    public init(confirmTextField: UITextField?, message: String = String.confirmationRuleMessage){
        self.confirmTextField = confirmTextField
        self.message = message
    }
    
    /// Validate the value is match the content in the text field
    ///
    /// - Parameter value: string to compare with the content in the text field
    /// - Returns: **true** if string is matched the content in the text field, otherwise return **false**
    public func validate(value: String) -> Bool {
        if let val = confirmTextField?.text {
            return val == value
        }
        return false
    }
    
    /// Get the error message of the rule
    ///
    /// - Returns: error message
    public func errorMessage() -> String {
        return message
    }
}
