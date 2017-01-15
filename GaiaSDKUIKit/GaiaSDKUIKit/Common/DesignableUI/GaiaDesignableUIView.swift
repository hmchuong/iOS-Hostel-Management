//
//  GaiaDesignableUIView.swift
//  Holler
//
//  Created by Phong Le on 8/12/15.
//  Copyright © 2015 Rainmaker-labs. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public class GaiaDesignableUIView: UIView{
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @IBInspectable public var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            setNeedsDisplay()
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
}
