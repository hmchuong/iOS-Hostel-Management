//
//  Validator.swift
//  GaiaSDKUIKit
//
//  Created by Chuong Huynh on 12/5/16.
//  Copyright © 2016 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation
import UIKit

/// Delegate of validator
@objc public protocol ValidationDelegate{
    func validationSuccessful()
    func validationFailed(errors: [UITextField:ValidationError])
}

/// This class is used in view controller to validate multiple textfields.
/// It provides 2 delegate methods:
/// - **validationSuccessful**: when all textfields are valid
/// - **validationFailed**: when there is one invalid textfield
///
/// It also provides **validate(delegate:ValidationDelegate)** to init the delegate
public class Validator{
    // MARK: - Properties
    public var errors = [GaiaUITextFieldValidation:ValidationError]()         // Errors of textfields
    public var validations = [GaiaUITextFieldValidation:ValidationRule]()     // Rules of textfields
    public var textFields = [GaiaUITextFieldValidation]()
    
    
    // MARK: - Public methods
    /// Default constructor
    public init(){}
    
    /// Register list of text fields to view controller
    ///
    /// - Parameter textFields: list of text fields
    public func register(textFields: [GaiaUITextFieldValidation]){
        self.textFields = textFields
    }
    
    /// Unregister text field from validations
    ///
    /// - Parameter textField: text field to unregister
    public func unregister(textField: GaiaUITextFieldValidation){
        validations.removeValue(forKey: textField)
        errors.removeValue(forKey: textField)
    }
}

// MARK: - For validate all text fields
public extension Validator{
    // MARK: - Private methods
    /// Validate all UITextFields
    private func validateAllFields(){
        addRules()
        
        errors = [:]
        
        // Validate each text field, if it has any error, put it to errors dictionary
        for (textField, rule) in validations {
            if let error = rule.validateField(){
                errors[textField] = error
            }
        }
        
        // Change state for each text field
        for textField in textFields{
            if let error = errors[textField]{
                textField.toFailed(msg: error.errorMessage)
                textField.isValidContent = false
            }else{
                textField.toSuccess()
                textField.isValidContent = true
            }
        }

    }
    
    /// Find text field with particular tag
    ///
    /// - Parameter tag: tag of text field
    /// - Returns: nil if not found, text field with tag if otherwise
    private func findTextField(with tag: Int) -> UITextField?{
        for textField in textFields{
            if textField.tag == tag{
                return textField
            }
        }
        return nil
    }
    
    /// Add rules from text field
    ///
    /// - Parameter controller: controller contains textfields
    private func addRules(){
        for textfield in textFields {
            // Array of rules
            var rules = [Rule]()
            
            // If not choose Self Check -> confirmation rule will not applied
            if !textfield.selfCheck {
                if textfield.confirmField{
                    rules.append(ConfirmationRule(confirmTextField: findTextField(with: textfield.textFieldTag),
                                                  message: textfield.msgConfirm))
                }
            }
            // Apply required rule
            if textfield.required{
                rules.append(textfield.getRequired())
            }
            
            // Apply REGEX rule
            if !textfield.regexPattern.isEmpty{
                rules.append(textfield.getRegex())
            }
            
            validations[textfield] = ValidationRule(textField: textfield, rules: rules)
        }
    }
    
    /// Register all text fields to validate
    ///
    /// - Parameter controller: controller contains text fields
    private func addAllTextFields(from controller: UIViewController){
        for view in controller.view.subviews{
            if let textField = view as? GaiaUITextFieldValidation{
                self.textFields.append(textField)
            }
        }
    }

    /// Validate all textfields
    ///
    /// - Parameters:
    ///   - controller: Controller contains text fields
    ///   - delegate: Delegate protocol class
    public func validate(controller: UIViewController?, delegate: ValidationDelegate){
        if controller != nil {
            addAllTextFields(from: controller!)
        }
        self.validateAllFields()
        
        // Successful
        if errors.isEmpty{
            delegate.validationSuccessful()
        } else { // Failed
            delegate.validationFailed(errors: errors)
        }
    }
    
    /// Validate all text fields and callback to closure with Bool value
    ///
    /// - Parameters:
    ///   - controller: Controller contains text fields
    ///   - callback: function to callback
    public func validate(controller: UIViewController?, callback:(_ valid: Bool)->Void) {
        if controller != nil {
            addAllTextFields(from: controller!)
        }
        self.validateAllFields()
        callback(errors.isEmpty)
    }
    
    /// Validate all text fields and return result
    ///
    /// - Parameter controller: controller contains textfields
    /// - Returns: **true** is successful, **false** if failed
    public func validate(controller: UIViewController?) -> Bool{
        if controller != nil {
            addAllTextFields(from: controller!)
        }
        self.validateAllFields()
        return errors.isEmpty
    }
    
}

// MARK: - For validate custom text fields
public extension Validator{
    /// Validate custom text fields with delegate
    ///
    /// - Parameters:
    ///   - textFields: text fields to validate
    ///   - delegate: ValidationDelegate receives results
    public func validate(textFields:[GaiaUITextFieldValidation], delegate: ValidationDelegate){
        self.textFields = textFields
        self.validate(controller: nil, delegate: delegate)
    }
    
    /// Validate custom text fields with callback
    ///
    /// - Parameters:
    ///   - textFields: text fields to validate
    ///   - callback: closure receives result
    public func validate(textFields:[GaiaUITextFieldValidation], callback:(_ valid: Bool)->Void){
        self.textFields = textFields
        self.validate(controller: nil, callback: callback)
    }
    
    /// Validate custom text fields
    ///
    /// - Parameter textFields: text fields to validate
    /// - Returns: **true** if all text fields are valid, otherwise return false
    public func validate(textFields:[GaiaUITextFieldValidation])-> Bool{
        self.textFields = textFields
        return self.validate(controller: nil)
    }
}
