//
//  ShopeeTests.swift
//  ShopeeTests
//
//  Created by Berksu Kısmet on 25.10.2022.
//

import XCTest
@testable import Shopee

final class ShopeeTests: XCTestCase {
    
    let vm = BasketScreenViewModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testTotalBasketPrice() {
        let mockProduct1 = Product(id: 1, title:  nil, price: 11.9, description: nil, category: nil, image: nil, rating: nil)
        let mockProduct2 = Product(id: 2, title:  nil, price: 4.0, description: nil, category: nil, image: nil, rating: nil)
        let mockProduct3 = Product(id: 3, title:  nil, price: 7.0, description: nil, category: nil, image: nil, rating: nil)

        let products: [CartProduct] = [CartProduct(product: mockProduct1 , count: 1),
                                       CartProduct(product: mockProduct2 , count: 2),
                                       CartProduct(product: mockProduct3 , count: 1)]
        
        let expectedTotalPrice = 26.9
        
        let calculatedTotal = try? vm.calculateTotalPrice(productsThatInCart: products)
        XCTAssert(calculatedTotal == expectedTotalPrice)
        
    }
    
    func testInvalidTotalBasketPrice() {
        let mockProduct1 = Product(id: 1, title:  nil, price: 11.9, description: nil, category: nil, image: nil, rating: nil)
        let mockProduct2 = Product(id: 2, title:  nil, price: 4.0, description: nil, category: nil, image: nil, rating: nil)

        let products: [CartProduct] = [CartProduct(product: mockProduct1 , count: 1),
                                       CartProduct(product: mockProduct2 , count: 2)]
        
        let expectedTotalPrice = 26.9
        
        let calculatedTotal = try? vm.calculateTotalPrice(productsThatInCart: products)
        XCTAssert(calculatedTotal != expectedTotalPrice)
        
    }

    func testValidBasketPrice() {
        let mockProduct1 = Product(id: 1, title:  nil, price: 11.9, description: nil, category: nil, image: nil, rating: nil)
        let mockProduct2 = Product(id: 2, title:  nil, price: 4.0, description: nil, category: nil, image: nil, rating: nil)
        let mockProduct3 = Product(id: 3, title:  nil, price: nil, description: nil, category: nil, image: nil, rating: nil)

        let products: [CartProduct] = [CartProduct(product: mockProduct1 , count: 1),
                                       CartProduct(product: mockProduct2 , count: 2),
                                       CartProduct(product: mockProduct3 , count: 1)]
        
        
        XCTAssertThrowsError(try vm.calculateTotalPrice(productsThatInCart: products)) { error in
            XCTAssertEqual(error as? ShopeeError, .unknown)
        }
        
    }
    
    func testInvalidBasketPrice() {
        let mockProduct1 = Product(id: 1, title:  nil, price: 11.9, description: nil, category: nil, image: nil, rating: nil)
        let mockProduct2 = Product(id: 2, title:  nil, price: 4.0, description: nil, category: nil, image: nil, rating: nil)

        let products: [CartProduct] = [CartProduct(product: mockProduct1 , count: 1),
                                       CartProduct(product: mockProduct2 , count: 2)]
        
        XCTAssertNoThrow(try vm.calculateTotalPrice(productsThatInCart: products))
        
    }
    
}
