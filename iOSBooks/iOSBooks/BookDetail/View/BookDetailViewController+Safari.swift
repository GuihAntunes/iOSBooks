//
//  BookDetailViewController+Safari.swift
//  iOSBooks
//
//  Created by Guilherme Antunes Ferreira on 30/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//

import UIKit

extension BookDetailViewController {
    @objc func openBuyLink() {
        guard let buyLink = viewModel?.getBookBuyLinkURL() else { return }
        UIApplication.shared.open(buyLink, options: [:], completionHandler: nil)
    }
}
