//
//  GaiaTextFieldPlaceholderExtension.swift
//  GaiaSDKUIKit
//
//  Created by Huỳnh Minh Chương on 1/13/17.
//  Copyright © 2017 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation

// MARK: - TextFieldsEffects
extension GaiaUITextFieldPlaceholder{
    /// Add placeholder to text field
    ///
    /// - Parameter rect: CGRect for placeholder
    func drawViewsForRect(rect: CGRect) {
        let frame = CGRect(origin: .zero, size: CGSize(width: rect.size.width, height: rect.size.height))
        placeholderLabel.frame = frame.insetBy(dx: placeholderInsets.x, dy: placeholderInsets.y)
        placeholderLabel.font = self.font
        updatePlaceholder()
        addSubview(placeholderLabel)
    }
    
    
    /// Process when starting editing text
    func animateViewsForTextEntry() {
        
        // If text field is empty -> show animation of changing state
        if text!.isEmpty {
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .beginFromCurrentState, animations: ({
                self.placeholderLabel.frame.origin = CGPoint(x: 10, y: self.placeholderLabel.frame.origin.y)
                self.placeholderLabel.alpha = 0
            }), completion:nil)
        }
        layoutPlaceholderInTextRect()
        
        //Move placeholder to active position
        placeholderLabel.frame.origin = activePlaceholderPoint
        placeholderLabel.textColor = activeColor.colorWithHexString()
        
        UIView.animate(withDuration: 0.2, animations: {
            self.placeholderLabel.alpha = 1
        })
        
        //Setup border and background for active state
        setActiveBorder()
        setActiveCorner()
        isActive = true
        setBackgroundTextField(boActWidth)
    }
    
    /// Process when ending editing text
    func animateViewsForTextDisplay() {
        if text!.isEmpty {
            UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: UIViewAnimationOptions.beginFromCurrentState, animations: ({
                self.layoutPlaceholderInTextRect()
                self.placeholderLabel.alpha = 1
            }), completion: nil)
            
            //Set up border and background for inactive state
            setupBorder()
            setupCorner()
            isActive = false
            setBackgroundTextField(borderWidth)
        }
    }
    
    /// Set up placeholder label
    func updatePlaceholder() {
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = activeColor.colorWithHexString()
        placeholderLabel.sizeToFit()
        layoutPlaceholderInTextRect()
        
        //Move to active state when there is text in text field
        if isFirstResponder || !(text!.isEmpty) {
            animateViewsForTextEntry()
        }
    }
    
    /// Set up position in the whole text field rect
    func layoutPlaceholderInTextRect() {
        let textRect1 = self.bounds
        var originX = textRect1.origin.x
        
        // if icon is located in the left side, x-point must be larger
        if showIcon && iconAlignment == AlignmentString.left.rawValue {
            originX += iconView.frame.width
        }
        
        //Set up inactive position of placeholder
        placeholderLabel.textColor = inactiveColor.colorWithHexString()
        placeholderLabel.frame = CGRect(x: originX + inactivePos,
                                        y: frame.height/2 - placeholderLabel.bounds.height/2,
                                        width: placeholderLabel.bounds.width,
                                        height: placeholderLabel.bounds.height)
        
        //Calculate active placeholder point
        // Placeholder outside
        if !insideTextfield{
            if belowTextfield{ //Placeholder below text field
                activePlaceholderPoint = CGPoint(x: activePos, y: 3*frame.height/4 + placeholderInsets.y)
            }else{ //Placeholder upper text field
                activePlaceholderPoint = CGPoint(x: activePos, y: frame.height/4 - placeholderLabel.frame.size.height - placeholderInsets.y)
            }
        }else{ //Placeholder inside
            let attributes = [NSFontAttributeName: font!]
            let placeholderTextSize = placeholderLabel.text!.size(attributes: attributes)
            let placeholderTextWidth = placeholderTextSize.width
            activePlaceholderPoint = CGPoint(x: frame.width - borderWidth - placeholderTextWidth + activePos, y: placeholderLabel.frame.origin.y)
        }
        
    }
    
    // MARK: - Override methods
    ///Rect for display text in editing session
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return self.editingRect(forBounds: bounds)
    }
    
    ///Rect for display text in non-editing session
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        //Get font size and text rect
        if placeholderLabel.text == nil {
            placeholderLabel.text = String.empty
        }
        let attributes = [NSFontAttributeName: font!]
        let placeholderTextSize = placeholderLabel.text!.size(attributes: attributes)
        _ = CGRect(x: 0,
                   y: frame.height/2 - placeholderTextSize.height/2,
                   width: bounds.width,
                   height: placeholderTextSize.height)
        
        // Calculate the extra right padding for icon
        var extraRightPadding = CGFloat(0)
        if insideTextfield{
            extraRightPadding = placeholderTextSize.width
        }
        if showIcon {
            if iconAlignment == AlignmentString.right.rawValue{
                extraRightPadding = iconView.frame.width
            }
        }
        
        return UIEdgeInsetsInsetRect(super.editingRect(forBounds: bounds), UIEdgeInsets(top: 0,
                                                                                        left: leftPaddingT,
                                                                                        bottom: 0,
                                                                                        right: rightPaddingT + extraRightPadding))
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        drawViewsForRect(rect: rect)
    }
    
    override public func drawPlaceholder(in rect: CGRect) {
        // Don't draw any placeholders
    }
    
    /// Change state by text
    override public var text: String? {
        didSet {
            if let text = text, !text.isEmpty {
                animateViewsForTextEntry()
            } else {
                animateViewsForTextDisplay()
            }
        }
    }
}

// MARK: - UITextField Observing
extension GaiaUITextFieldPlaceholder{
    
    override public func willMove(toSuperview newSuperview: UIView!) {
        if newSuperview != nil {
            NotificationCenter.default.addObserver(self, selector: #selector(GaiaUITextFieldPlaceholder.textFieldDidEndEditing), name:NSNotification.Name.UITextFieldTextDidEndEditing, object: self)
            
            NotificationCenter.default.addObserver(self, selector: #selector(GaiaUITextFieldPlaceholder.textFieldDidBeginEditing), name:NSNotification.Name.UITextFieldTextDidBeginEditing, object: self)
        } else {
            NotificationCenter.default.removeObserver(self)
        }
    }
    
    
    ///The textfield has started an editing session.
    func textFieldDidBeginEditing() {
        animateViewsForTextEntry()
    }
    
    
    ///The textfield has ended an editing session.
    func textFieldDidEndEditing() {
        animateViewsForTextDisplay()
    }
    
    // MARK: - Interface Builder
    
    override public func prepareForInterfaceBuilder() {
        drawViewsForRect(rect: frame)
    }
    
}

// MARK: - Set active corner
extension GaiaUITextFieldPlaceholder{
    /// Change corner to active state
    ///
    /// - Parameters:
    ///   - type: corner type you want to change
    ///   - center: center point of the corner
    func changeToActive(type: Corner.type, center: CGPoint){
        drawingLayer.corner.get(type).makeCorner(center: center,
                                                 startAngle: type.startAngle,
                                                 radius: cornerRadius,
                                                 color: borderActiveColorUI,
                                                 lineWidth: boActWidth)
    }
    
    /// Set up active state for 4 corners
    func setActiveCorner(){
        //For top left corner
        if topleftCorner{
            changeToActive(type: Corner.type.topLeft,
                           center: CGPoint(x:cornerRadius + boActWidth/2,
                                           y:cornerRadius + boActWidth/2 + frame.height/4))
        }
        
        //For top right corner
        if toprightCrn{
            changeToActive(type: Corner.type.topRight,
                           center: CGPoint(x:frame.width - cornerRadius - boActWidth/2,
                                           y:cornerRadius + boActWidth/2 + frame.height/4))
        }
        
        //For bottom left corner
        if bottomleftCrn{
            changeToActive(type: Corner.type.bottomLeft,
                           center: CGPoint(x:cornerRadius + boActWidth/2,
                                           y: 3*frame.height/4 - cornerRadius - boActWidth/2))
        }
        
        //For bottom right corner
        if btmrightCrn{
            changeToActive(type: Corner.type.bottomRight,
                           center: CGPoint(x:frame.width - cornerRadius - boActWidth/2,
                                           y:3*frame.height/4 - cornerRadius - boActWidth/2))
        }
    }
}

//MARK: - Set active borders
extension GaiaUITextFieldPlaceholder{
    
    /// Change appearance of 4 borders to active state
    func setActiveBorder(){
        
        //Change top border
        if topBorder {
            add(border: .top, width: boActWidth)
        } else {
            drawingLayer.border.top.removeFromSuperlayer()
        }
        
        //Change bottom border
        if bottomBorder {
            add(border: .bottom, width: boActWidth)
        } else {
            drawingLayer.border.bottom.removeFromSuperlayer()
        }
        
        //Change left border
        if leftBorder {
            add(border: .left, width: boActWidth)
        } else {
            drawingLayer.border.left.removeFromSuperlayer()
        }
        
        //Change right border
        if rightBorder {
            add(border: .right, width: boActWidth)
        } else {
            drawingLayer.border.right.removeFromSuperlayer()
        }
        
        //Change color of border for active state
        drawingLayer.border.change(color: borderActiveColorUI.cgColor)
    }
}
