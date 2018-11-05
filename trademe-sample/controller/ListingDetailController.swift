//
//  ListingDetailController.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 5/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import UIKit

class ListingDetailController: UIViewController {
    
    var listingID: Int?
    
    @IBOutlet weak var listing: UILabel!
    @IBOutlet weak var listingTtitle: UILabel!
    @IBOutlet weak var listingDescription: UILabel!
    @IBOutlet weak var listingPicture: UIImageView!
    
    var listingDetail: DetailViewModel? {
        didSet {
            listing.text = listingDetail?.id
            listingTtitle.text = listingDetail?.title
            listingDescription.text = listingDetail?.description
            listingPicture.image = listingDetail?.listingPicture
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveListingDetail()
    }
    
    fileprivate func retrieveListingDetail() {
        guard let listingID = listingID else { return }
        DetailService().retrieve(listingID, callback: { [weak self] (detail) in
            DispatchQueue.main.async(execute: {
                self?.listingDetail = detail
            })
        }, onError: { [weak self]  (message) in
            DispatchQueue.main.async(execute: {
                self?.present(UIAlertController.error(withMessage: message), animated: true, completion: nil)
            })
        })
        
    }

}
