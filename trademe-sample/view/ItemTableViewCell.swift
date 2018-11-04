//
//  ItemTableViewCell.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 2/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var basePrice: UILabel!
    @IBOutlet weak var buyNowPrice: UILabel!
    @IBOutlet weak var reserveText: UILabel!
    @IBOutlet weak var buyNowText: UILabel!
    
    var item: ItemViewModel? {
        didSet {
            title.text = item?.title
            region.text = item?.region
            picture.image = item?.picture
            basePrice.text = item?.startPriceText
            reserveText.text = item?.reserveStateText
            buyNowPrice.text = item?.buyNowPriceText
            buyNowText.text = item?.buyNowText
        }
    }
        
}
