//
//  BooksCell.swift
//  iOSBooks
//
//  Created by Guilherme Antunes Ferreira on 30/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//

import Kingfisher
import UIKit

class BooksCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var bookImageView: UIImageView?
    
    // MARK: - Properties
    var selectedBook: Book?
    
    func setup(withBook book: Book?, andImage image: UIImage? = nil) {
        selectedBook = book
        if let image = image {
            bookImageView?.image = image
        } else {
            if let book = book, let bookURLString = book.imageLinks?.smallThumbnail, let url = URL(string: bookURLString) {
                bookImageView?.kf.setImage(with: url)
            }
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bookImageView?.image = nil
        bookImageView?.kf.cancelDownloadTask()
    }
    
    deinit {
        bookImageView?.image = nil
        bookImageView?.kf.cancelDownloadTask()
    }
    
}
