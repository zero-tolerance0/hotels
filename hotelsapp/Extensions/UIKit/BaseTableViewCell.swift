//
//  BaseTableViewCell.swift
//  hotelsapp
//
//  Created by zerohero on 6/24/20.
//  Copyright © 2020 indev. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    class var identifier: String {
        return String(describing: self)
    }

    // MARK: - LifeCycle 🌏
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
