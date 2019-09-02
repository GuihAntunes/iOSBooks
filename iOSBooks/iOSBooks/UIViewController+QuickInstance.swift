//
//  UIViewController+QuickInstance.swift
//  iOSBooks
//
//  Created by Guilherme Antunes Ferreira on 30/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//
import UIKit

extension UIViewController {
    
    static func instantiate<T: UIViewController>() -> T {
        guard let controller = UIStoryboard(name: T.storyboardIdentifier.replacingOccurrences(of: "Controller", with: "").replacingOccurrences(of: "View", with: ""), bundle: T.bundle).instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("failed to create storyboard")}
        return controller
    }
    
    static func instantiateFromXIB<T: UIViewController>() -> T {
        return T(nibName: T.xibIdentifier.replacingOccurrences(of: "Controller", with: "").replacingOccurrences(of: "View", with: ""), bundle: .main)
    }
    
    static var bundle: Bundle {
        return Bundle(for: self)
    }
}

extension UIViewController {
    
    func setBackButton(_ backFunction: Selector) {
        navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(image: UIImage(named: "back_arrow"), style: .plain, target: self, action: backFunction)
        newBackButton.title = "Voltar"
        navigationItem.leftBarButtonItem = newBackButton
    }
    
}

extension UIViewController {
    
    func alert(title: String = "", message: String, completion: (() -> Void)? = nil, okActionHandler: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: okActionHandler)
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion: completion)
    }
    
}
