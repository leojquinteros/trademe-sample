//
//  ListingDetailController.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 5/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import UIKit

class ListingDetailController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var listing: UILabel!
    @IBOutlet weak var listingTtitle: UILabel!
    @IBOutlet weak var listingDescription: UILabel!
    @IBOutlet weak var listingPicture: CustomImageView!
    
    var presenter: ListingDetailPresenter?
    
    var listingDetail: DetailModel? {
        didSet {
            listingPicture.load(url: listingDetail?.pictureURL)
            listing.text = listingDetail?.id
            listingTtitle.text = listingDetail?.title
            listingDescription.text = listingDetail?.description
        }
    }
        
    convenience init(id: Int) {
        self.init()
        presenter = ListingDetailPresenter(with: self, listingID: id)
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        retrieveListingDetail()
    }
    
    fileprivate func setupView() {
        listingPicture.isUserInteractionEnabled = true
        listingPicture.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleImageZoomTap)))
    }
    @objc func handleImageZoomTap(tapGesture: UITapGestureRecognizer) {
        
    }
    
    fileprivate func retrieveListingDetail() {
        presenter?.getDetail()
    }
}

// MARK: - View Delegate

extension ListingDetailController: ListingDetailView {
    
    func showLoader() { }
    
    func hideLoader() { }
    
    func showErrorAlert(_ errorDescription: String?) {
        present(UIAlertController.error(withMessage: errorDescription), animated: true)
    }
    
    func setDetail(_ model: DetailModel?) {
        self.listingDetail = model
    }
    
}
