//
//  ItemService.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 5/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import Foundation

class ItemService {
    
    func retrieve(_ categoryID: String, callback: (([ItemViewModel]) -> Void)?, onError: ((String) -> Void)?) {
        
        API.shared.items(categoryID, callback: { (response) in
            let items = ItemViewModel.initialize(with: response)
            callback?(items)
        }) { (message) in
            onError?(message)
        }
    }
    
}
