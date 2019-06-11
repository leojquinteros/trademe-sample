//
//  ItemCell.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 11/05/19.
//  Copyright © 2019 Leonel Quinteros. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {

    let title: UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        return label
    }()
    
    var picture: CustomImageView = {
        let image = CustomImageView()
        image.backgroundColor = .red
        return image
    }()
    var region: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        return label
    }()
    var basePrice: UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        return label
    }()
    var buyNowPrice: UILabel = {
        let label = UILabel()
        label.backgroundColor = .gray
        return label
    }()
    var reserveText: UILabel = {
        let label = UILabel()
        label.backgroundColor = .orange
        return label
    }()
    var buyNowText: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        return label
    }()
    
    var item: ItemViewModel? {
        didSet {
            //picture.load(url: item?.pictureURL)
            title.text = item?.title
            region.text = item?.region
            basePrice.text = item?.startPriceText
            reserveText.text = item?.reserveStateText
            buyNowPrice.text = item?.buyNowPriceText
            buyNowText.text = item?.buyNowText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupViews() {
        
        contentView.backgroundColor = .blue
        
        contentView.addSubviews(title, picture)
    //, region, basePrice, buyNowPrice, reserveText, buyNowText)
        
        picture.anchorSize(size: CGSize(width: 150, height: 150))
        
        picture.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0))

        title.anchor(top: contentView.topAnchor, leading: picture.trailingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
        title.heightAnchor.constraint(equalToConstant: 25)
        
        
//        addConstraints(format: "V:|[v0(100)]|", views: picture)
//        addConstraints(format: "H:|[v0(100)]|", views: picture)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
