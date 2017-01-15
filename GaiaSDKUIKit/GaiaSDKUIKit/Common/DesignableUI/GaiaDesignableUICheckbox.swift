//
//  GaiaDesignableUICheckbox.swift
//  Holler
//
//  Created by Phong Le on 8/12/15.
//  Copyright © 2015 Rainmaker-labs. All rights reserved.
//

import UIKit

enum UICheckboxStyle {
    case openCircle, grayedOut
}

@IBDesignable public class GaiaDesignableUICheckbox: UIControl {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    @IBInspectable public var checked: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable public var checkmarkSize: CGFloat = 5.0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable public var checkmarkColor: UIColor = UIColor.white {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var filled: Bool = true {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable public var checkedFillColor: UIColor = UIColor(red: 0.078, green: 0.435, blue: 0.875, alpha: 1.0) {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable public var uncheckedFillColor: UIColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.3) {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor.white {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 1.0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    // custom enums, unfortunately, cannot be IBInspectable
    var style: UICheckboxStyle {
        return self.filled ? .grayedOut : .openCircle
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.isTouchInside) {
            self.checked = !self.checked
        }
        
        super.touchesEnded(touches, with: event)
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        var context = UIGraphicsGetCurrentContext()
        if context == nil {
            UIGraphicsBeginImageContext(CGSize(width: self.frame.width, height: self.frame.height))
            context = UIGraphicsGetCurrentContext()
        }
        let fillColor = currentFillColor()
        let shadowColor = UIColor.black
        
        let shadowOffset = CGSize(width: 0.1, height: -0.1)
        let shadowBlurRadius: CGFloat = 2.5
        
        let frame = self.bounds
        
        let group = CGRect(x: frame.minX + 3, y: frame.minY + 3, width: frame.width - 6, height: frame.height - 6)
        
        let ovalX = group.minX + floor(group.width * 0.00000 + 0.5)
        let ovalY = group.minY + floor(group.height * 0.00000 + 0.5)
        let ovalW = floor(group.width * 1.00000 + 0.5) - floor(group.width * 0.00000 + 0.5)
        let ovalH = floor(group.height * 1.00000 + 0.5) - floor(group.height * 0.00000 + 0.5)
        
        let ovalRect = CGRect(x: ovalX, y: ovalY, width: ovalW, height: ovalH)
        
        let ovalPath = UIBezierPath(ovalIn: ovalRect)
        context!.saveGState()
        context!.setShadow(offset: shadowOffset, blur: shadowBlurRadius, color: shadowColor.cgColor)
        fillColor.setFill()
        ovalPath.fill()
        context!.restoreGState()
        
        self.borderColor.setStroke()
        ovalPath.lineWidth = self.borderWidth
        ovalPath.stroke()
        
        if self.checked || self.filled {
            let bezierPath = UIBezierPath()
            
            let startX = group.minX + 0.27083 * group.width
            let startY = group.minY + 0.54167 * group.height
            let startPoint = CGPoint(x: startX,y:  startY)
            
            let midX = group.minX + 0.41667 * group.width
            let midY = group.minY + 0.68750 * group.height
            let midPoint = CGPoint(x: midX, y: midY)
            
            let endX = group.minX + 0.75000 * group.width
            let endY = group.minY + 0.35417 * group.height
            let endPoint = CGPoint(x: endX,y: endY)
            
            bezierPath.move(to: startPoint)
            bezierPath.addLine(to: midPoint)
            bezierPath.addLine(to: endPoint)
            bezierPath.lineCapStyle = CGLineCap.round
            
            self.checkmarkColor.setStroke()
            bezierPath.lineWidth = self.checkmarkSize;
            bezierPath.stroke()
        }
    }
    
    private func currentFillColor() -> UIColor {
        if self.checked {
            return self.checkedFillColor
        } else if self.filled {
            return self.uncheckedFillColor
        } else {
            return UIColor.clear
        }
    }
    
    private var _backgroundColor: UIColor = UIColor.clear {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    override public var backgroundColor: UIColor? {
        set(newColor) {
            super.backgroundColor = UIColor.clear
            if let backColor = newColor {
                self._backgroundColor = backColor
            } else {
                self._backgroundColor = UIColor.clear
            }
        }
        get {
            return self._backgroundColor
        }
    }
}
