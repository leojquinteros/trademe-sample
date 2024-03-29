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
        self.image = nil
        guard let url = url, let urlObj = URL(string: url) else { return }
        self.imageURL = url
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: urlObj) else { return }
            guard let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                if url == self?.imageURL {
                    self?.image = image
                }
            }
        }
    }
    
}
