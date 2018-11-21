//
//  ListingDetailController.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 5/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import UIKit
import ABLoaderView

class ListingDetailController: UIViewController {
    
    var listingID: Int?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var listing: UILabel!
    @IBOutlet weak var listingTtitle: UILabel!
    @IBOutlet weak var listingDescription: UILabel!
    @IBOutlet weak var listingPicture: CustomImageView!
    
    var listingDetail: DetailViewModel? {
        didSet {
            listingPicture.load(url: listingDetail?.pictureURL)
            listing.text = listingDetail?.id
            listingTtitle.text = listingDetail?.title
            listingDescription.text = listingDetail?.description
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveListingDetail()
    }
    
    fileprivate func retrieveListingDetail() {
        guard let listingID = listingID else { return }
        ABLoader().startSmartShining(containerView)
        DetailService().retrieve(listingID) { [weak self] (result) in
            switch result {
            case .success(let detail):
                self?.listingDetail = detail
                break
            case .failure(let error):
                self?.present(UIAlertController.error(withMessage: error), animated: true, completion: nil)
                break
            }
            if let containerView = self?.containerView {
                ABLoader().stopSmartShining(containerView)
            }
        }
    }
}
