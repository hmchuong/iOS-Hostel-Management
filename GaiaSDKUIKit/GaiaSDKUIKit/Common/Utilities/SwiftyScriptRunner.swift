//
//  SwiftyScriptRunner.swift
//  Holler
//
//  Created by Phong Le on 24/3/16.
//  Copyright © 2016 Rainmaker-labs. All rights reserved.
//
/***
 Example with Alamofire.
 var runner = SwiftScriptRunner()
 runner.lock() // Lock

 Alamofire.request(.GET, "http://httpbin.org/get", parameters: ["foo": "bar"])
 .responseJSON { response in
 print(response.result)   // Result of response serialization
 runner.unlock() // Unlock
 }

 runner.wait() // Wait

 */
import Foundation

/// Helper for running Swift scripts with async callbacks
open class SwiftScriptRunner {
	/// A poor man's mutex
	fileprivate var count = 0
	/// Current run loop
	fileprivate let runLoop = RunLoop.current

	/// Initializer
	public init() { }

	/// Lock the script
	open func lock() {
		count += 1
	}

	/// Unlock the script
	open func unlock() {
		count -= 1
	}

	/// Wait for all locks to unlock
	open func wait() {
		while count > 0 &&
		runLoop.run(mode: RunLoopMode.defaultRunLoopMode, before: Date(timeIntervalSinceNow: 0.1)) {
			// Run, run, run
		}
	}
}
