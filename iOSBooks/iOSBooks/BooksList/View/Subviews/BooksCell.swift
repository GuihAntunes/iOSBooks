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
    @IBOutlet weak var bookImageView: UIImageView?
    
    func setup(withBook book: Book?) {
        if let book = book, let bookURLString = book.imageLinks?.thumbnail, let url = URL(string: bookURLString) {
            bookImageView?.kf.setImage(with: url)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bookImageView?.kf.cancelDownloadTask()
    }
    
    deinit {
        bookImageView?.kf.cancelDownloadTask()
    }
    
}
