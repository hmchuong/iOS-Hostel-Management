//
//  ValidationComponent.swift
//  GaiaSDKUIKit
//
//  Created by Chuong Huynh on 12/1/16.
//  Copyright © 2016 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation

/// State of validation
///
/// - errorRegex: state when content is not matched regex
/// - errorRequired: state when content is empty and text field is required
/// - accepted: state when content is acceptable
/// - normal: state when nothing in textfield or unchecked
public enum ValidationState{
    case errorRegex, errorRequired, accepted, normal
}

/// Validation Component (includes label and button)
class ValidationComponent{
    
    //MARK: - Properties
    /// Use for both error and accepted message
    public var validationLabel = UILabel()
    
    public var acceptedState: Bool = true
    /// Accepted message
    public var acceptedMessage: String = String.empty
    
    /// UIButton for clear content in error state
    public var clearButton = UIButton()
    
    /// Color for message and border in error state
    public var errorColor: UIColor = UIColor.clear
    
    /// Color for message and border in accepted state
    public var acceptedColor: UIColor = UIColor.clear
    
    /// Rule for required content
    public var requiredRule = RequiredRule()
    
    /// Regular expression for checking content
    public var regexRule = RegexRule()
    
    /// Current state of validation
    public var currentState = ValidationState.normal
    
    //MARK: - Methods
    public func validate(required: Bool, content: String) -> ValidationState{
        // Check Required Validation
        if required && !requiredRule.validate(value: content){
            return ValidationState.errorRequired
        }
        
        // Check REGEX Validation
        if !content.isEmpty && regexRule.REGEX != String.empty && !regexRule.validate(value: content){
            return ValidationState.errorRegex
        }
        
        // Change to accepted state
        if acceptedState && !content.isEmpty{
            return ValidationState.accepted
        }else{
            return ValidationState.normal
        }
    }
    
    /// Change label, button to state
    ///
    /// - Parameter state: state to change
    public func changeTo(state: ValidationState){
        if currentState == state{
            return
        }
        currentState = state
        switch state {
        case .errorRegex:
            validationLabel.textColor = errorColor
            validationLabel.text = regexRule.errorMessage()
            validationLabel.isHidden = false
            clearButton.isHidden = false
        case .errorRequired:
            validationLabel.textColor = errorColor
            validationLabel.text = requiredRule.errorMessage()
            validationLabel.isHidden = false
            clearButton.isHidden = false
        case .accepted:
            validationLabel.textColor = acceptedColor
            validationLabel.text = acceptedMessage
            validationLabel.isHidden = false
            clearButton.isHidden = true
        case .normal:
            validationLabel.text = String.empty
            validationLabel.isHidden = true
            clearButton.isHidden = true
        }
        validationLabel.sizeToFit()
    }
    
    /// Set up font name and font size for message
    ///
    /// - Parameters:
    ///   - fontName: name of font
    ///   - size: size of font
    public func setupFontForMessage(fontName: String, size: CGFloat){
        validationLabel.font = UIFont(name: fontName, size: size)
        validationLabel.sizeToFit()
    }
    
    /// Set up position for validation label
    ///
    /// - Parameters:
    ///   - x: x position
    ///   - y: y position
    public func setupMessage(x: CGFloat, y: CGFloat){
        validationLabel.frame = CGRect(x: x, y: y, width: validationLabel.bounds.width, height: validationLabel.bounds.height)
    }
    
    /// Set up button position, width, height, image
    ///
    /// - Parameters:
    ///   - frame: frame of button
    ///   - image: image of button
    public func setupButton(frame: CGRect, image: UIImage){
        clearButton.frame = frame        
        clearButton.setImage(image, for: .normal)
    }
}
