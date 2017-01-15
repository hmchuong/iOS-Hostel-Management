//
//  CellRegistrationReusing+Extension.swift
//  common
//
//  Created by Phong Le on 13/5/16.
//  Copyright © 2016 Rainmaker-labs. All rights reserved.
//

import Foundation
import UIKit


public protocol ReusableView: class {
	static var defaultReuseIdentifier: String { get }
}

public extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
		return NSStringFromClass(self)
	}
}

public protocol NibLoadableView: class {
	static var nibName: String { get }
}

public extension NibLoadableView where Self: UIView {
	static var nibName: String {
		return NSStringFromClass(self).components(separatedBy: ".").last!
	}
}

//
//  CollectionViewCell
//
//

extension UICollectionViewCell: ReusableView {
}

public extension UICollectionView {
    
    public func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
		self.register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
	}

    public func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
		let bundle = Bundle(for: T.self)
		let nib = UINib(nibName: T.nibName, bundle: bundle)

		self.register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
	}

    public func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
		guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
			fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
		}

		return cell
	}
}

//
//  UITableViewCell
//
//
extension UITableViewCell: ReusableView {
}

/// Extend to easier allow for identifier to be set without much work
public extension UITableView {

	/// Register cell with automatically setting Identifier
    public func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
		self.register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
	}

	/// Get cell with the default reuse cell identifier
    public func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
		guard let cell = self.dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
			fatalError("Could not dequeue cell: \(T.self) with identifier: \(T.defaultReuseIdentifier)")
		}

		return cell
	}
}
