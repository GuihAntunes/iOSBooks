//
//  BookDetailViewController+View.swift
//  iOSBooks
//
//  Created by Guilherme Antunes Ferreira on 30/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//

import Kingfisher
import UIKit

protocol BookDetailViewControllerPresentable: class {
    
}

extension BookDetailViewController: BookDetailViewControllerPresentable {
    
    func configureTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(openBuyLink))
        buyLinkLabel?.addGestureRecognizer(tap)
    }
    
    func setupView() {
        if let button = favoriteButton {
            toggleFavoriteButton(button)
        }
        title = viewModel?.getScreenTitle()
        bookImageView?.kf.setImage(with: viewModel?.getBookImageLink(), options: [.cacheOriginalImage])
        bookTitleLabel?.text = viewModel?.getBookTitle()
        bookAuthorsLabel?.text = viewModel?.getBookAuthors()
        buyLinkLabel?.text = viewModel?.getBookBuyLink()
        descriptionTextView?.text = viewModel?.getBookDescription()
    }
    
    func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = false
        setBackButton(#selector(dismissScreen))
    }
    
    func toggleFavoriteButton(_ button: UIButton) {
        button.layer.cornerRadius = 10
        guard let viewModel = viewModel else { return }
        if viewModel.savedBook {
            button.backgroundColor = .yellow
            return
        }
        button.backgroundColor = .white
    }
    
}
