
//
//  GaiaDesignableUITextFieldPlaceholder.swift
//  GaiaSDKUIKit
//
//  Created by Chuong Huynh on 3/11/16.
//  Copyright © 2016 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import UIKit

/// Gaia customise UITextField with placeholder and icon
///
/// There are two states:
/// - **active**: in editing session or non-editing session and text field is non-empty
/// - **inactive**: non-editing session and text field is empty
@IBDesignable
public class GaiaUITextFieldPlaceholder: GaiaUITextFieldIcon {
    //MARK: - Properties
    
    //MARK: - - IBInspectable
    //MARK: -- Placeholder
    /// Hex color of placeholder for inactive state
    @IBInspectable public var inactiveColor: String = ColorString.clear.rawValue{
        didSet{
            updatePlaceholder()
        }
    }
    
    ///Hex color of placeholder in active state
    @IBInspectable public var activeColor: String = ColorString.clear.rawValue
    
    /// Is placeholder inside text field in active state
    /// - **true**: placeholder on the right of text field
    /// - **false**: placeholder outside text field
    @IBInspectable public var insideTextfield: Bool = false{
        didSet{
            if insideTextfield && showIcon && icon != nil{
                insideTextfield = false
            }
            updatePlaceholder()
        }
    }
    
    /// Is placeholder below text field in active state
    /// - **true**: placeholder below text field
    /// - **false**: placeholder upper text field
    @IBInspectable public var belowTextfield: Bool = false{
        didSet{
            updatePlaceholder()
        }
    }
    
    /// Placeholder position in inactive state
    ///
    /// Position can have negative value. The more postive value, placeholder moves more to the right
    @IBInspectable public var inactivePos: CGFloat = DefaultCGFloat.position{
        didSet{
            updatePlaceholder()
        }
    }
    
    /// Placeholder position in active position
    ///
    /// Position can have negative value. The more postive value, placeholder moves more to the right
    @IBInspectable public var activePos: CGFloat = DefaultCGFloat.position{
        didSet{
            updatePlaceholder()
        }
    }
    
    // MARK: -- Border
    /// Hex color of border in active state
    @IBInspectable public var boActiveColor: String = ColorString.clear.rawValue{
        didSet{
            borderActiveColorUI = boActiveColor.colorWithHexString()
            if isActive {
                setActiveBorder()
                setActiveCorner()
                setBackgroundTextField(boActWidth)
            }
        }
    }
    
    /// Width of border in active state
    @IBInspectable dynamic public var boActWidth: CGFloat = 0{
        didSet{
            if isActive {
                setActiveBorder()
                setActiveCorner()
                setBackgroundTextField(boActWidth)
            }
        }
    }
    
    //MARK: - - Override

    override public var showIcon: Bool{
        didSet{
            if showIcon && !insideTextfield && icon != nil{
                setUpIconSubView()
                self.addSubview(iconView)
                iconView.bringSubview(toFront: self)
            }else{
                iconView.removeFromSuperview()
            }
            updatePlaceholder()
        }
    }
    

    override public var iconAlignment: String{
        didSet{
            if icon != nil  && showIcon{
                setUpIconSubView()
            }
            updatePlaceholder()
        }
    }
    
    override public var leftPadding: CGFloat{
        didSet{
            if icon != nil && showIcon{
                setUpIconSubView()
            }
            updatePlaceholder()
        }
    }
    
    override public var rightPadding: CGFloat{
        didSet{
            if icon != nil && showIcon{
                setUpIconSubView()
            }
            updatePlaceholder()
        }
    }
    
    /// Redraw placeholder if placeholder string has changed
    override public var placeholder: String? {
        didSet {
            updatePlaceholder()
        }
    }
    
    /// Redraw placeholder if bounds have changed
    override public var bounds: CGRect {
        didSet {
            updatePlaceholder()
        }
    }
    
    /// Limit the font size of text field
    override public var font: UIFont?{
        didSet{
            if (font?.pointSize)! > (frame.height/4 - placeholderInsets.y) {
                font = UIFont(name: (font?.fontName)!, size: (oldValue?.pointSize)!)
            }
            placeholderLabel.font = font
            updatePlaceholder()
        }
    }


    //MARK: - - Others
    /// Placeholder label
    let placeholderLabel = UILabel()
    
    ///Store the state of text field
    var isActive = false
    
    var borderActiveColorUI = UIColor.clear
    
    // Extra variables for display beautiful textfield
    let placeholderInsets = CGPoint(x: 0, y: 0)
    let textFieldInsets = CGPoint(x: 0, y: 0)
    var activePlaceholderPoint: CGPoint = .zero
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        updateConstraints()
        
        //Init the y-axis value of text field: from height/4 to 3/4xheight
        y_start = frame.height/4
        y_end = 3*frame.height/4
        placeholderLabel.text = String.empty
    }
    

}

