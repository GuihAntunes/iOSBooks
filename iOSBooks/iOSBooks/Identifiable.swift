//
//  Identifiable.swift
//  iOSBooks
//
//  Created by Guilherme Antunes Ferreira on 30/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//

import UIKit

protocol Identifiable: class {}

extension Identifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    static var xibIdentifier: String {
        return String(describing: self)
    }
}

extension Identifiable where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension Identifiable where Self: UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension Identifiable where Self: UITableViewHeaderFooterView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}


extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            // TODO: set crashlytics to warn here
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return headerFooterView
    }
}

extension UICollectionViewCell: Identifiable {}
extension UITableViewCell: Identifiable {}
extension UIViewController: Identifiable {}
extension UITableViewHeaderFooterView: Identifiable {}

