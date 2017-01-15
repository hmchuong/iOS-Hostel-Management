//
//  GaiaDesignableUnderlineCell.swift
//  Holler
//
//  Created by Phong Le on 10/12/15.
//  Copyright © 2015 Rainmaker-labs. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class GaiaDesignableUnderlineCell: UIView, UITextFieldDelegate {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        textField = UITextField()
        textField.delegate = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    
    @IBInspectable var label: String = "Default"
    @IBInspectable var labelSize: CGFloat = 10
    @IBInspectable var insetX: CGFloat = 0
    @IBInspectable var insetY: CGFloat = 0
    @IBInspectable var x: CGFloat = 0
    @IBInspectable var y: CGFloat = 0
    
    
//    @IBInspectable var textColor: UIColor? {
//        didSet {
//            if let hasColor = self.textField {
//                hasColor.textColor = textColor
//                self.setNeedsLayout()
//            }
//            
//            
//        }
//    }
    @IBInspectable var placeholder: String = "Default"
    @IBInspectable var fontSize: CGFloat = 20
    @IBInspectable var lineWidth: CGFloat = 1
    @IBInspectable var lineColor: UIColor = UIColor.black
    
    var myLabel: UILabel!
    var textField: UITextField!
    var underline: CAShapeLayer!
}

// MARK: - Lifecycle
extension GaiaDesignableUnderlineCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        //createSubviews()
    }
    
    func createSubviews() {
        
//        // Initialize label
        myLabel = UILabel()
        myLabel.font = UIFont.systemFont(ofSize: labelSize)
        myLabel.text = label
        myLabel.numberOfLines = 0
        myLabel.sizeToFit()
        myLabel.backgroundColor = UIColor.clear
        
        myLabel.frame = CGRect(x: x, y: y, width: bounds.width, height: frame.size.height/2)
        addSubview(myLabel)
//        // Initialize text field
        textField.textColor = UIColor.gray
        textField.borderStyle = UITextBorderStyle.none
        textField.placeholder = placeholder
        textField.backgroundColor = UIColor.clear
        textField.font = UIFont.systemFont(ofSize: fontSize)
        textField.sizeToFit()
        textField.frame = CGRect(x: x, y: myLabel.frame.origin.y + myLabel.frame.size.height, width: bounds.width, height: frame.size.height - myLabel.frame.size.height)
        addSubview(textField)

        
        // Initialize underline
        if underline != nil {
            underline.removeFromSuperlayer()
        }

        underline = CAShapeLayer()
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: frame.size.height - (lineWidth/2)))
        bezierPath.addLine(to: CGPoint(x: bounds.width, y: frame.size.height - (lineWidth/2)))
        underline.path = bezierPath.cgPath
        underline.strokeColor = lineColor.cgColor
        underline.lineWidth = lineWidth
        layer.addSublayer(underline)
        

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createSubviews()
       
    }
    
    override func prepareForInterfaceBuilder() {
    }
}

// MARK: - Methods
extension GaiaDesignableUnderlineCell {
    fileprivate func setupView(){
        
        
        
        self.setNeedsDisplay()
        
    }
}

// MARK: - Delegate Methods
extension GaiaDesignableUnderlineCell {
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.placeholder = nil
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if (textField.text != nil) {
            textField.placeholder = placeholder
        }
    }
    
}

// MARK: - Actions
extension GaiaDesignableUnderlineCell {
    
}
