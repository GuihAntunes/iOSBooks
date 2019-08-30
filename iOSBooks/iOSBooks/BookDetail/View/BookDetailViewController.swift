//
//  BookDetailViewController.swift
//  iOSBooks
//
//  Created by Guilherme Antunes Ferreira on 30/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var bookImageView: UIImageView?
    @IBOutlet weak var bookTitleLabel: UILabel?
    @IBOutlet weak var bookAuthorsLabel: UILabel?
    @IBOutlet weak var buyLinkLabel: UILabel?
    @IBOutlet weak var descriptionTextView: UITextView?
    @IBOutlet weak var favoriteButton: UIButton?
    
    // MARK: - Properties
    var viewModel: BookDetailViewModelProtocol?
    
    // MARK: - View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        setupNavigation()
        configureTap()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        descriptionTextView?.scrollRangeToVisible(NSRange(location:0, length:0))
    }

    @objc func dismissScreen() {
        viewModel?.presentPreviousStep()
    }
    
    // MARK: - Actions
    @IBAction func saveBook(_ sender: UIButton) {
        viewModel?.saveBookIfNeeded()
        toggleFavoriteButton(sender)
    }
    
}
