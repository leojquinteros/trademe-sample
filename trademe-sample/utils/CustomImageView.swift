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
        guard let url = url, let endpoint = URL(string: url) else { return }
        setupImage(url)
        DispatchQueue.global().async { [weak self] in
            guard let self = self,
                let data = try? Data(contentsOf: endpoint),
                let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                if url == self.imageURL {
                    self.image = image
                }
            }
        }
    }
    
    fileprivate func setupImage(_ url: String) {
        imageURL = url
        image = UIImage.Assets.Misc.placeholder
        clipsToBounds = true
    }
    
}
