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
    
    var presenter: ListingDetailPresenter?
    
    var listingID: Int?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var listing: UILabel!
    @IBOutlet weak var listingTtitle: UILabel!
    @IBOutlet weak var listingDescription: UILabel!
    @IBOutlet weak var listingPicture: CustomImageView!
    
    var listingDetail: DetailModel? {
        didSet {
            listingPicture.load(url: listingDetail?.pictureURL)
            listing.text = listingDetail?.id
            listingTtitle.text = listingDetail?.title
            listingDescription.text = listingDetail?.description
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ListingDetailPresenter(with: self)
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
        guard let listingID = listingID else { return }
        presenter?.getDetail(withListingID: listingID)
    }
}

extension ListingDetailController: ListingDetailView {
    
    func showLoader() {
        ABLoader().startShining(containerView)
    }
    
    func hideLoader() {
        ABLoader().stopShining(containerView)
    }
    
    func showErrorAlert(_ errorDescription: String?) {
        present(UIAlertController.error(withMessage: errorDescription), animated: true)
    }
    
    func setDetail(_ model: DetailModel?) {
        self.listingDetail = model
    }
    
    
}
