//
//  CustomImageView.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 5/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    
    var imageURL: String?
    
    func load(url: String?) {
        image = nil
        guard let url, let urlObject = URL(string: url) else {
            return
        }
        imageURL = url
        DispatchQueue.global().async { [weak self] in
            guard 
                let data = try? Data(contentsOf: urlObject),
                let image = UIImage(data: data)
            else {
                return
            }
            DispatchQueue.main.async {
                if url == self?.imageURL {
                    self?.image = image
                }
            }
        }
    }
    
}
