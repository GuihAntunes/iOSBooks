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
    lazy var imageCache = ImageCache(name: selectedBook?.title ?? "")
    
    func setup(withBook book: Book?) {
        selectedBook = book
        if let image = imageCache.retrieveImageInMemoryCache(forKey: selectedBook?.subtitle ?? "") {
            bookImageView?.image = image
        } else {
            if let book = book, let bookURLString = book.imageLinks?.smallThumbnail, let url = URL(string: bookURLString) {
                bookImageView?.kf.setImage(with: url, options: [.cacheOriginalImage], completionHandler: { (result) in
                    switch result {
                    case .success(let result):
                        self.imageCache.store(result.image, forKey: self.selectedBook?.subtitle ?? "")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                })
                
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
