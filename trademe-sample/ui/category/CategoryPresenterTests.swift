//
//  CategoryPresenterTests.swift
//  trademe-sampleTests
//
//  Created by Leonel Quinteros on 23/03/20.
//  Copyright © 2020 Leonel Quinteros. All rights reserved.
//

import XCTest
@testable import trademe_sample

class CategoryPresenterTests: XCTestCase {

    var presenter: CategoryPresenter!
    var mockView: CategoryViewMock!
    var provider: CategoryProvider!
    
    override func setUp() {
        super.setUp()
        mockView = CategoryViewMock()
        provider = CategoryProvider(client: TMClientMock())
        presenter = CategoryPresenter(with: mockView, provider: provider)
    }
    
    override func tearDown() {
        super.tearDown()
    }
}

class TMClientMock: TMClient {
    
}


class CategoryViewMock: CategoryView {
    
    func showLoader() {
        
    }
    
    func hideLoader() {
        
    }
    
    func showErrorAlert(_ errorDescription: String?) {
        
    }
    
    func setCategories(_ model: [CategoryModel]?) {
        
    }
    
}
