//
//  FontBlaster.swift
//  FontBlaster
//
//  Created by Arthur Sabintsev on 5/5/15.
//  Copyright (c) 2015 Arthur Ariel Sabintsev. All rights reserved.
//

import Foundation
import CoreGraphics
import CoreText

// MARK: Enumerations
/**
    Limits the type of fonts that can be loaded into an application

    There are two options:
    - TrueTypeFont
    - OpenTypeFont
*/
private enum SupportedFontExtensions: String {
    case TrueTypeFont = ".ttf"
    case OpenTypeFont = ".otf"
}

// MARK: FontBlaster Class
/**
    The FontBlaster Class.

    Only one class method can be accessed
        - blast(_:)
    Only one class variable can be accessed and modified
        - debugEnabled
*/
open class FontBlaster {
    // Typealiases to better handle of the different aspects of loading a font
    fileprivate typealias FontPath = String
    fileprivate typealias FontName = String
    fileprivate typealias FontExtension = String
    fileprivate typealias Font = (FontPath, FontName, FontExtension)
    
    /** 
        Used to toggle debug println() statements
    */
    open static var debugEnabled = false
    
    /**
        Load all fonts found in a specific bundle. If no value is entered, it defaults to NSBundle.mainBundle().
    */
    open static func blast(_ bundle: Bundle = Bundle.main) {
        let path = bundle.bundlePath
        loadFontsForBundleWithPath(path)
        loadFontsFromBundlesFoundInBundle(path)
    }
}

// MARK: Helpers (Font Loading)
private extension FontBlaster {
    /**
        Loads all fonts found in a bundle.
    
        - parameter path: The absolute path to the bundle.
    */
    class func loadFontsForBundleWithPath(_ path: String) {
        do {
            let contents = try FileManager.default.contentsOfDirectory(atPath: path)
            let fonts = fontsFromPath(path: path, contents: contents as [NSString])
            if !fonts.isEmpty {
                for font in fonts {
                    loadFont(font)
                }
            } else {
                printStatus("No fonts were found in the bundle path: \(path).")
            }
        } catch let error as NSError {
            printStatus("There was an error loading fonts from the bundle. \nPath: \(path).\nError: \(error)")
        }
    }
    
    /**
        Loads all fonts found in a bundle that is loaded within another bundle.
        
        - parameter path: The absolute path to the bundle.
    */
    static func loadFontsFromBundlesFoundInBundle(_ path: String) {
        do {
            let contents = try FileManager.default.contentsOfDirectory(atPath: path)
            for item in contents {
                if let url = URL(string: path) {
                    if item.contains(".bundle") {
                        let urlPath = url.appendingPathComponent(item)
                        loadFontsForBundleWithPath(urlPath.absoluteString)
                    }
                }
            }
        } catch let error as NSError {
            printStatus("There was an error accessing bundle with path. \nPath: \(path).\nError: \(error)")
        }
    }
    
    /**
        Loads a specific font.
    
        - parameter font: The font to load.
    */
    static func loadFont(_ font: Font) {
        let fontPath: FontPath = font.0
        let fontName: FontPath = font.1
        let fontExtension: FontPath = font.2

        guard let fontFileURL = Bundle(path: fontPath)?.url(forResource: fontName, withExtension: fontExtension) else {
            printStatus("Could not unwrap the file URL for the resource with name: \(fontName) and extension \(fontExtension)")
            return
        }
        
        var fontError: Unmanaged<CFError>?
        if CTFontManagerRegisterFontsForURL(fontFileURL as CFURL, CTFontManagerScope.process, &fontError) {
            printStatus("Successfully loaded font: '\(fontName)'.")
        } else {
            guard let fontError = fontError?.takeRetainedValue() else {
                printStatus("Failed to load font '\(fontName)'.")
                return
            }
            let errorDescription = CFErrorCopyDescription(fontError)
            printStatus("Failed to load font '\(fontName)': \(errorDescription)")
        }
    }
}

// MARK: Helpers (Miscellaneous)
private extension FontBlaster {
    /**
        Parses a font into its name and extension components.
        
        - parameter path: The absolute path to the font file.
        - parameter contents: The contents of an NSBundle as an array of String objects.
        - returns: A tuple with the font's name and extension.
    */
    static func fontsFromPath(path: String, contents: [NSString]) -> [Font] {
        var fonts = [Font]()
        for fontName in contents {
            var parsedFont: (FontName, FontExtension)?

            if fontName.contains(SupportedFontExtensions.TrueTypeFont.rawValue) || fontName.contains(SupportedFontExtensions.OpenTypeFont.rawValue) {
                parsedFont = fontFromName(fontName as String)
            }

            if let parsedFont = parsedFont {
                let font: Font = (path, parsedFont.0, parsedFont.1)
                fonts.append(font)
            }
        }
        
        return fonts
    }
    
    /**
        Parses a font into its name and extension components.
    
        - parameter The: name of the font.
        - returns: A tuple with the font's name and extension.
    */
    static func fontFromName(_ name: String) -> (FontName, FontExtension) {
        let components = name.characters.split{$0 == "."}.map { String($0) }
        return (components[0], components[1])
    }
    
    /**
        Prints debug messages to the console if debugEnabled is set to true.
    
        - parameter The: status to print to the console.
    */
    static func printStatus(_ status: String) {
        if debugEnabled == true {
            print("[FontBlaster]: \(status)")
        }
    }
}
