//
//  GaiaTextFieldValidation.swift
//  GaiaSDKUIKit
//
//  Created by Huỳnh Minh Chương on 1/13/17.
//  Copyright © 2017 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation

// MARK: - Set up validation
extension GaiaUITextFieldValidation{
    /// Set up positon of validation components
    func setupValidation(){
        // Set up REGEX and error message
        validationComponent.regexRule = RegexRule(regex: regexPattern, message: msgRegex)
        
        if required{
            validationComponent.requiredRule = RequiredRule(message: msgRequired)
        }
        
        // Set up position for validation label
        validationComponent.changeTo(state: .errorRegex)
        validationComponent.validationLabel.text = String.REGEXRuleMessage
        
        // Set up font of label
        validationComponent.setupFontForMessage(fontName: (self.font?.fontName)!, size: fontSize)
        
        //Set up position of label
        if msgAlign == AlignmentString.top.rawValue{
            validationComponent.setupMessage(x: msgXpos, y: msgYpos)
        }else{
            validationComponent.setupMessage(x: msgXpos, y: frame.height-validationComponent.validationLabel.frame.height)
        }
        
        // Add to text field
        addSubview(validationComponent.validationLabel)
        
        // Set up position for button
        let height = (y_end - y_start) * clearBtnScale
        let rect = CGRect(x: frame.width - height + clearBtnXpos, y: frame.height/2 - height/2, width: height, height: height)
        if clearBtnBg != nil{
            validationComponent.setupButton(frame: rect, image: clearBtnBg!)
        }
        
        // Add to text field
        insertSubview(validationComponent.clearButton, at: subviews.count - 1)
        
        validationComponent.changeTo(state: .normal)
    }
    
    /// Remove validation components
    func removeValidation(){
        validationComponent.validationLabel.removeFromSuperview()
        validationComponent.clearButton.removeFromSuperview()
    }
}

/// Textfield addObserver
extension GaiaUITextFieldValidation{
    override public func willMove(toSuperview newSuperview: UIView!) {
        if newSuperview != nil {
            // Add end editing event
            NotificationCenter.default.addObserver(self, selector: #selector(GaiaUITextFieldValidation.textFieldDidEndEditing), name:NSNotification.Name.UITextFieldTextDidEndEditing, object: self)
            
            // Add begin editing event
            NotificationCenter.default.addObserver(self, selector: #selector(GaiaUITextFieldValidation.textFieldDidBeginEditing), name:NSNotification.Name.UITextFieldTextDidBeginEditing, object: self)
            
            // Add text changed event
            NotificationCenter.default.addObserver(self, selector: #selector(GaiaUITextFieldValidation.textFieldDidChange), name:NSNotification.Name.UITextFieldTextDidChange, object: self)
            
            // Add clear button touched event
            validationComponent.clearButton.addTarget(self, action:#selector(self.clearButtonTouch), for: .touchUpInside)
        } else {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    /// Processing when begin editing
    override func textFieldDidBeginEditing() {
        // Change state to normal
        validationComponent.changeTo(state: .normal)
        borderActiveColorUI = boActiveColor.colorWithHexString()
        super.textFieldDidBeginEditing()
    }
    
    /// Processsing when ending editing
    override func textFieldDidEndEditing() {
        if selfCheck{
            change(validation: validationComponent.validate(required: required, content: self.text ?? ""))
        }
        super.textFieldDidEndEditing()
    }
    
    /// Processing when text is changed
    func textFieldDidChange(){
        // Only check validation when regex is not empty and choosing "check while editing"
        if selfCheck && typingCheck {
            change(validation: validationComponent.validate(required: required, content: self.text ?? ""))
        }
    }
    
    /// Processing when button is touched
    func clearButtonTouch(){
        self.text = String.empty
        borderActiveColorUI = boActiveColor.colorWithHexString()
    }
    
}

// MARK: - Functions for user (change state of text field)
public extension GaiaUITextFieldValidation{
    
    /// Change validation state
    ///
    /// - Parameter state: validation state (**.normal, .accepted, .error**)
    public func change(validation state: ValidationState){
        validationComponent.changeTo(state: state)
        switch state {
        case .normal:
            // Set for active state
            if !isActive{
                borderColorUI = borderColor.colorWithHexString()
                setupBorder()
                setupCorner()
                setBackgroundTextField(borderWidth)
            }else{  // Set for inactive state
                borderActiveColorUI = boActiveColor.colorWithHexString()
                setActiveBorder()
                setActiveCorner()
                setBackgroundTextField(boActWidth)
            }
        case .errorRequired:
            fallthrough
        case .errorRegex:
            borderActiveColorUI = colorInvalid.colorWithHexString()
            setActiveBorder()
            setActiveCorner()
            setBackgroundTextField(boActWidth)
        case .accepted:
            borderActiveColorUI = colorValid.colorWithHexString()
            setActiveBorder()
            setActiveCorner()
            setBackgroundTextField(boActWidth)
        }
    }
    
    /// Get REGEX rule of text field
    ///
    /// - Returns: RegexRule
    public func getRegex()->RegexRule{
        return validationComponent.regexRule
    }
    
    /// Get Required rule of text field
    ///
    /// - Returns: RequiredRule
    public func getRequired()->RequiredRule{
        return validationComponent.requiredRule
    }
    
    /// Change to successful state
    public func toSuccess(){
        if validState{
            change(validation: .accepted)
        }else{
            change(validation: .normal)
        }
    }
    
    /// Change to failed state with custom message
    public func toFailed(msg: String){
        change(validation: .errorRequired)
        validationComponent.validationLabel.text = msg
        validationComponent.validationLabel.sizeToFit()
    }
}
