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
        label.numberOfLines = 2
        label.font = Font(.installed(.HelveticaNeue), size: .standard(.h3)).instance
        return label
    }()
    
    var picture: CustomImageView = {
        let image = CustomImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    var region: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Font(.installed(.HelveticaNeueLight), size: .standard(.h4)).instance
        label.textColor = .gray
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    lazy var basePrice: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Font(.installed(.HelveticaNeueBold), size: .standard(.h3)).instance
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    lazy var buyNowPrice: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Font(.installed(.HelveticaNeueBold), size: .standard(.h3)).instance
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    lazy var reserveText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = Font(.installed(.HelveticaNeueLight), size: .standard(.h5)).instance
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    lazy var buyNowText: UILabel = {
        let label = UILabel()
        label.font = Font(.installed(.HelveticaNeueLight), size: .standard(.h5)).instance
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var priceView = UIStackView()
    var buyNowView = UIStackView()
    
    var item: ItemViewModel? {
        didSet {
            picture.load(url: item?.pictureURL)
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
        
        priceView.addArrangedSubview(basePrice)
        priceView.addArrangedSubview(reserveText)
        priceView.axis = .vertical
        priceView.distribution = .equalSpacing
        priceView.alignment = .leading
        
        buyNowView.addArrangedSubview(buyNowPrice)
        buyNowView.addArrangedSubview(buyNowText)
        buyNowView.axis = .vertical
        buyNowView.distribution = .equalSpacing
        buyNowView.alignment = .trailing
        
        contentView.backgroundColor = UIColor.Custom.Background.tint
        contentView.addSubviews(region, title, picture, priceView, buyNowView)
        
        setupContraints()
    }
    
    private func setupContraints() {
        
        picture.anchorSize(size: CGSize(width: 150, height: 150))
        
        picture.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 0))
        
        region.anchor(top: contentView.topAnchor, leading: picture.trailingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 5))
        
        title.anchor(top: region.bottomAnchor, leading: picture.trailingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 5))

        priceView.anchor(top: nil, leading: picture.trailingAnchor, bottom: contentView.bottomAnchor, trailing: buyNowView.leadingAnchor, padding: UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 0))

        buyNowView.anchor(top: nil, leading: priceView.trailingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 10))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
