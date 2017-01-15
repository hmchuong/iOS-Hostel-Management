//
//  SwiftyHTMLProcessing.swift
//  GaiaSDKUIKit
//
//  Created by Chuong Huynh on 12/15/16.
//  Copyright © 2016 Subscribe © 2016 Rainmaker Labs. All rights reserved. All rights reserved.
//

import Foundation


/// Extract url from HTML source
///
/// - Parameter html: HTML source
/// - Returns: List of urls
func extractUrl(from html: String) -> [String:String]{
    let regex = "(?i)<a([^>]+)>(.+?)</a>"
    do {
        // Find urls with tag
        let regex = try NSRegularExpression(pattern: regex)
        let nsString = html as NSString
        let results = regex.matches(in: html, range: NSRange(location: 0, length: nsString.length))
        var stringRes = results.map { nsString.substring(with: $0.range)}
        var resultMap: [String : String]
        resultMap = [:]
        // Remove tags
        for i in 0..<stringRes.count{
            var key = ""
            var value = ""
            var swit = 0
            let str = stringRes[i]
            for j in 0..<stringRes[i].characters.count{
                switch swit {
                case 0:
                    if str[str.index(str.startIndex, offsetBy: j)] == "\"" {
                        swit = 1
                    }
                case 1:
                    if str[str.index(str.startIndex, offsetBy: j)] == "\"" {
                        swit = 2
                    } else{
                        value.append(str[str.index(str.startIndex, offsetBy: j)])
                    }
                case 2:
                    if str[str.index(str.startIndex, offsetBy: j)] == ">" {
                        swit = 3
                    }
                case 3:
                    if str[str.index(str.startIndex, offsetBy: j)] == "<" {
                        swit = 4
                        break
                    } else{
                        key.append(str[str.index(str.startIndex, offsetBy: j)])
                    }
                default:
                    break
                }
            }
            resultMap[key] = value
        }
        return resultMap
    } catch let error {
        print("invalid regex: \(error.localizedDescription)")
        return [:]
    }
}
