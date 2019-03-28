//
//  UITableViewController+Empty.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 3/11/18.
//  Copyright © 2018 Leonel Quinteros. All rights reserved.
//

import UIKit

extension UITableViewController {
    
    func showEmptyTableMessage(_ message: String) {
        if tableView.backgroundView == nil {
            let rect = CGRect(origin: CGPoint(x: 0, y :0), size: CGSize(width: view.frame.width, height: view.frame.height))
            let messageLabel = UILabel(frame: rect)
            messageLabel.text = message
            messageLabel.textColor = UIColor.Custom.Foreground.tint
            messageLabel.backgroundColor = UIColor.Custom.Background.tint
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.sizeToFit()
            tableView.backgroundView = messageLabel
            tableView.separatorStyle = .none
        }
    }
    
    func hideEmptyTableMessage() {
        tableView.separatorStyle = .singleLine
        tableView.backgroundView = nil
    }
    
}
