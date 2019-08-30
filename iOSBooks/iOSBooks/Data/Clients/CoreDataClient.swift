//
//  CoreDataClient.swift
//  iOSBooks
//
//  Created by Guilherme Antunes Ferreira on 30/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//

import CoreData
import Foundation
import UIKit

class CoreDataClient {
    func saveBook(_ item: Item?) {
        guard let item = item, let context = context, let entity = NSEntityDescription.entity(forEntityName: "CoreDataBook", in: context) else { return }
        let coreDataBook = NSManagedObject(entity: entity, insertInto: context)
        coreDataBook.setValue(item.book?.title, forKey: "title")
        coreDataBook.setValue(item.id, forKey: "id")
        coreDataBook.setValue(item.book?.description, forKey: "bookDescription")
        coreDataBook.setValue(item.salesInfo?.buyLink, forKey: "buyLink")
        coreDataBook.setValue(true, forKey: "isFavorite")
        coreDataBook.setValue(item.book?.authors?.first, forKey: "author")
        
        do {
            try context.save()
        } catch {
            print("error on saving")
        }
    }
    
    func fetchAllSavedBooks() -> [Item] {
        var books: [Item] = []
        guard let context = context else { return [] }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataBook")
        do {
            guard let result = try context.fetch(fetchRequest) as? [NSManagedObject] else { return [] }
            for data in result {
                let item = Item()
                item.book = Book()
                item.book?.imageLinks = ImageLinks()
                item.salesInfo = SalesInfo()
                item.book?.authors = []
                item.book?.authors?.append(data.value(forKey: "author") as? String ?? "")
                item.id = data.value(forKey: "id") as? String
                item.book?.description = data.value(forKey: "bookDescription") as? String
                item.salesInfo?.buyLink = data.value(forKey: "buyLink") as? String
                item.book?.title = data.value(forKey: "title") as? String
                books.append(item)
            }
            return books
        } catch {
            print("Failed to load data from CoreData")
            return []
        }
    }
    
    func deleteBook(_ book: Item?) {
        guard let book = book, let context = context else { return }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataBook")
        fetchRequest.predicate = NSPredicate(format: "id = %@", book.id ?? "")
        guard let bookToDelete = try? context.fetch(fetchRequest).first as? NSManagedObject else { return }
        context.delete(bookToDelete)
        do {
            try context.save()
            
        } catch {
            print("Failed to fetch book from CoreData and delete")
        }
    }
    
    private var context: NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate.persistentContainer.viewContext
    }
}
