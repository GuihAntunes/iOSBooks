//
//  BookDetailViewModelTests.swift
//  iOSBooksTests
//
//  Created by Guilherme Antunes on 26/08/19.
//  Copyright © 2019 Guilherme Antunes. All rights reserved.
//

import Quick
import Nimble
@testable import iOSBooks

class BookDetailViewModelTests: QuickSpec {
    
    class MockedCoordinator: AppCoordinatorProtocol {
        var presentNextStepCalled = false
        var presentPreviousStepCalled = false
        
        func presentNextStep() {
            presentNextStepCalled = true
        }
        
        func presentPreviousStep() {
            presentPreviousStepCalled = true
        }
        
        
    }
    
    class MockedService: CoreDataClientProtocol {
        var saveBookCalled = false
        var fetchAllSavedBooksCalled = false
        var deleteBookCalled = false
        
        func saveBook(_ item: Item?, withThumbnail thumbnail: UIImage?) {
            saveBookCalled = true
        }
        
        func fetchAllSavedBooks() -> (books: [Item], images: [UIImage]) {
            fetchAllSavedBooksCalled = true
            return ([],[])
        }
        
        func deleteBook(_ book: Item?) {
            deleteBookCalled = true
        }
        
        
    }
    
    private func createFilledMockedItem() -> Item {
        let mockedItem = Item()
        let mockedBook = Book()
        let mockedSalesInfo = SalesInfo()
        let mockedImageLinks = ImageLinks()
        mockedBook.title = "Book title"
        mockedBook.description = "Book description"
        mockedBook.authors = ["Book author"]
        mockedImageLinks.thumbnail = "http://www.google.com/bookthumbnail"
        mockedBook.imageLinks = mockedImageLinks
        mockedSalesInfo.buyLink = "http://www.google.com"
        mockedItem.salesInfo = mockedSalesInfo
        mockedItem.book = mockedBook
        return mockedItem
    }

    override func spec() {
        
        var subject: BookDetailViewModel!
        let mockedCoordinator = MockedCoordinator()
        var mockedService = MockedService()
        
        beforeEach {
            subject = BookDetailViewModel()
            subject.coordinator = mockedCoordinator
            subject.selectedBook = nil
            mockedService = MockedService()
            subject.service = mockedService
        }
        
        it("should test successfully item retriving") {
            subject.selectedBook = self.createFilledMockedItem()
            expect(subject.getBookAuthors()).to(equal("Autor: Book author"))
            expect(subject.getBookTitle()).to(equal("Título: Book title"))
            expect(subject.getBookBuyLink()).to(equal("http://www.google.com"))
            expect(subject.getScreenTitle()).to(equal("Book title"))
            expect(subject.getBookBuyLinkURL()).to(equal(URL(string: "http://www.google.com")!))
            expect(subject.getBookImageLink()).to(equal(URL(string: "http://www.google.com/bookthumbnail")!))
            expect(subject.getBookDescription()).to(equal("Book description"))
        }
        
        it("should test a nil item") {
            expect(subject.getBookAuthors()).to(equal("Autores não disponíveis"))
            expect(subject.getBookTitle()).to(equal("Título indisponível"))
            expect(subject.getBookBuyLink()).to(equal("Link de compra não disponível"))
            expect(subject.getScreenTitle()).to(beNil())
            expect(subject.getBookBuyLinkURL()).to(beNil())
            expect(subject.getBookImageLink()).to(beNil())
            expect(subject.getBookDescription()).to(equal("Sem descrição disponível"))
        }
        
        it("should test back button function call") {
            subject.presentPreviousStep()
            expect(mockedCoordinator.presentPreviousStepCalled).to(beTrue())
            expect(mockedCoordinator.presentNextStepCalled).to(beFalse())
        }
        
        it("should test book saving") {
            subject.savedBook = false
            subject.saveBookIfNeeded()
            expect(subject.savedBook).to(beTrue())
            expect(mockedService.saveBookCalled).to(beTrue())
            expect(mockedService.deleteBookCalled).to(beFalse())
        }
        
        it("should test book deletion") {
            subject.savedBook = true
            subject.saveBookIfNeeded()
            expect(subject.savedBook).to(beFalse())
            expect(mockedService.saveBookCalled).to(beFalse())
            expect(mockedService.deleteBookCalled).to(beTrue())
        }
        
    }

}
