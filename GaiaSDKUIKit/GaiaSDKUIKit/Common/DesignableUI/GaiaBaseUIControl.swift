//
//  GaiaDesignableUIView.swift
//  Holler
//
//  Created by Phong Le on 8/12/15.
//  Copyright © 2015 Rainmaker-labs. All rights reserved.
//

import Foundation
import UIKit

/// Protocol for all GaiaUIControls
public protocol GaiaBaseUIControl{
    
    //MARK: - Properties
    /// Color of border
    var borderColor: String { get set }
    /// Width of border
    var borderWidth: CGFloat { get set }
    /// Radius of corner
    var cornerRadius: CGFloat { get set }
    /// Hex-color of background
    var bgColor: String { get set }
}
