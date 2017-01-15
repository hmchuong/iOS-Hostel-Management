//
//  GaiaUIButton_Extention.swift
//  GaiaSDKUIKit
//
//  Created by Phong Le on 28/12/16.
//  Copyright © 2016 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation
//MARK: - Methods
extension GaiaUIButton{
    
    
    /// Setup background for state
    func setBackground(){
        backgroundImage.frame = self.bounds
        //Remove current background
        backgroundImage.removeFromSuperview()
        if state == .normal{
            //If choosing gradient background
            if startColor != nil && endColor != nil && gradientBg{
                backgroundColor = UIColor.clear
                backgroundImage.image = getGradientBackground(from: (startColor?.colorWithHexString())!, to: endColor!.colorWithHexString())
                self.insertSubview(backgroundImage, at: 0)
            } else{ //Setup normal background color
                backgroundColor = bgColor.colorWithHexString()
            }
        } else {    //Setup highlighted background color
            backgroundColor = bgHighColor.colorWithHexString()
        }
    }
    
    /// Setup border for state
    func setBorder(){
        if borderWidth > 0 {
            //Set normal border
            if state == .normal && layer.borderColor != borderColor.colorWithHexString().cgColor{
                layer.borderColor = borderColor.colorWithHexString().cgColor
            } else if state == .highlighted && !boHighColor.isEmpty{ // Set highlighted border
                layer.borderColor = boHighColor.colorWithHexString().cgColor
            }
            
        }
    }
    
    
    /// Get UIImage with gradient background
    ///
    /// - Parameters:
    ///   - corlor1: The first color of gradient
    ///   - color2: The second color of gradient
    /// - Returns: UIImage with gradient
    func getGradientBackground(from corlor1:UIColor, to color2: UIColor) -> UIImage{
        var image = UIImage()
        weak var weakSelf = self
        UIGraphicsBeginImageContextWithOptions((weakSelf?.frame.size)!, false, 0)
        let context = UIGraphicsGetCurrentContext()
        let colorspace = CGColorSpaceCreateDeviceRGB()
        
        //Overlay a colored rectangle
        context?.setBlendMode(CGBlendMode.multiply)
        let topGradientColorComponents = corlor1.cgColor.components
        let bottomGradientColorComponents = color2.cgColor.components
        let colors: [CGFloat] = [topGradientColorComponents![0], topGradientColorComponents![1], topGradientColorComponents![2], topGradientColorComponents![3], bottomGradientColorComponents![0], bottomGradientColorComponents![1], bottomGradientColorComponents![2], bottomGradientColorComponents![3]]
        
        let gradient = CGGradient(colorSpace: colorspace, colorComponents: UnsafePointer(colors), locations: nil, count: sizeof(colors) / (sizeof(colors[0]) * 4))
        
        if self.isHorizontal == true{
            context?.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: 0), end: CGPoint(x: (weakSelf?.frame.width)!,y: 0), options: CGGradientDrawingOptions(rawValue: UInt32(0)))
        }else{
            context?.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: 0), end: CGPoint(x:0 ,y: (weakSelf?.frame.height)!), options: CGGradientDrawingOptions(rawValue: UInt32(0)))
        }
        
        image = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        return image
    }
    
}
