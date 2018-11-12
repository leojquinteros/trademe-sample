//
//  trademe_sampleTests.swift
//  trademe-sampleTests
//
//  Created by Leonel Quinteros on 2/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import XCTest
@testable import trademe_sample

class trademe_sampleTests: XCTestCase {

    func testItemViewModel() {
        
        let itemModel = Item(id: 1, title: "Product", region: "Auckland", startPrice: 17.0, buyNowPrice: 12.0, hasBuyNow: true, reserveState: 0, pictureURL: nil)
        
        let itemViewModel = ItemViewModel(with: itemModel)
        
        XCTAssertEqual(itemViewModel.reserveStateText, "No reserve")
        XCTAssertEqual(itemViewModel.buyNowPriceText, "$12.0")
        XCTAssertEqual(itemViewModel.startPriceText, "$17.0")
        XCTAssertNotEqual(itemViewModel.id, nil)

    }

}
