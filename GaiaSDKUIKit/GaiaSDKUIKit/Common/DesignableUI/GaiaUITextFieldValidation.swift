//
//  GaiaUITextFieldValidation.swift
//  GaiaSDKUIKit
//
//  Created by Chuong Huynh on 12/1/16.
//  Copyright © 2016 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation

/// GaiaUITextFieldValidation is an extension of GaiaUITextFieldPlaceholder.
///
/// Validation function is added to validate content in textfield by regular expression.
/// It also provides method **changeState(for: ValidationState)** to change state of textfield
@IBDesignable
public class GaiaUITextFieldValidation: GaiaUITextFieldPlaceholder{
    //MARK: - Properties
    // - Check validation
    /// Turn on/off checking validation
    ///
    /// * true: turn on
    /// * false: turn off
    @IBInspectable public var validation: Bool = false{
        didSet{
            setNeedsDisplay()
        }
    }
    
    /// Check in View Controllers or check when ending editing
    ///
    /// * **true**: check when ending editing
    /// * **false**: check in view controllers
    @IBInspectable public var selfCheck: Bool = true
    
    /// Choose checking while editing or checking when ending editing.
    /// Only affected when **Self Check** = **true**
    /// * **true**: checking while editing
    /// * **false**: checking when ending editing
    @IBInspectable public var typingCheck: Bool = false
    
    /// Message alignment:
    ///
    /// * **top**: on the top of text field
    /// * **bottom**: on the bottom of text field
    @IBInspectable public var msgAlign: String = AlignmentString.bottom.rawValue{
        didSet{
            setNeedsDisplay()
        }
    }
    
    /// Position of message in horizontal dimension.
    /// It can receive negative value.
    /// The more postive value it receives, the more the message moves to the right
    @IBInspectable public var msgXpos: CGFloat = 0.0{
        didSet{
            setNeedsDisplay()
        }
    }
    
    /// Position of message in vertical dimension.
    /// It can receive negative value.
    /// The more positive value it receives, the more the message moves to the bottom
    @IBInspectable public var msgYpos: CGFloat = 0.0{
        didSet{
            setNeedsDisplay()
        }
    }
    
    /// Font size of the message
    @IBInspectable public var fontSize: CGFloat = DefaultCGFloat.fontSize{
        didSet{
            setNeedsDisplay()
        }
    }
    
    /// Turn on or off valid state
    @IBInspectable public var validState: Bool = true{
        didSet{
            validationComponent.acceptedState = validState
        }
    }
    
    /// Message showed when content is valid
    @IBInspectable public var msgValid: String = String.empty{
        didSet{
            validationComponent.acceptedMessage = msgValid
            setNeedsDisplay()
        }
    }
    
    /// Hex-color of border and message in valid state
    @IBInspectable public var colorValid: String = ColorString.clear.rawValue{
        didSet{
            validationComponent.acceptedColor = colorValid.colorWithHexString()
        }
    }
    
    /// Hex-color of border and message in invalid state
    @IBInspectable public var colorInvalid: String = ColorString.clear.rawValue{
        didSet{
            validationComponent.errorColor = colorInvalid.colorWithHexString()
        }
    }
    
    /// Confirm this text field with another text field, only affected when **selfCheck** = false.
    /// - **true**: don't check any rule under
    @IBInspectable public var confirmField: Bool = false
    
    /// The tag of text field to confirm
    @IBInspectable public var textFieldTag: Int = 0
    
    /// Message is shown when content is not matched
    @IBInspectable public var msgConfirm: String = String.confirmationRuleMessage
    
    /// Check the content must not empty
    @IBInspectable public var required: Bool = false {
        didSet{
            setNeedsDisplay()
        }
    }
    
    /// Message showed when content is empty
    @IBInspectable public var msgRequired: String = String.requiredRuleMessage{
        didSet{
            setNeedsDisplay()
        }
    }
    
    /// Regular expression string to check content
    @IBInspectable public var regexPattern: String = String.empty{
        didSet{
            setNeedsDisplay()
        }
    }
    
    /// Message showed when content is invalid REGEX
    @IBInspectable public var msgRegex: String = String.REGEXRuleMessage{
        didSet{
            setNeedsDisplay()
        }
    }
    
    /// Image for clear button
    @IBInspectable public var clearBtnBg: UIImage? = nil{
        didSet{
            setNeedsDisplay()
        }
    }
    
    /// Scale of the button in height.
    /// The value is in range [0..1]
    @IBInspectable public var clearBtnScale: CGFloat = DefaultCGFloat.scale{
        didSet{
            if clearBtnScale > 1{
                clearBtnScale = 1
            }
            setNeedsDisplay()
        }
    }
    
    /// Position of button in horizontal dimension
    /// It can receive negative value
    /// The more positive value it receives, the more the button moves to the right
    @IBInspectable public var clearBtnXpos: CGFloat = 0.0{
        didSet{
            setNeedsDisplay()
        }
    }

    /// Validation component
    var validationComponent = ValidationComponent()
    
    /// To check valid content in view controller
    public var isValidContent = true
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if validation == true{
            setupValidation()
        }else{
            removeValidation()
        }
    }

}


