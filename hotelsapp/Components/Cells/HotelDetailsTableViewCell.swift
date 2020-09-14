//
//  HotelDetailsTableViewCell.swift
//  hotelsapp
//
//  Created by zerohero on 6/24/20.
//  Copyright © 2020 indev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class HotelDetailsTableViewCell: BaseTableViewCell, FillableProtocol {
    
    var bag = DisposeBag()
    
    typealias DataType = ViewModel
    struct ViewModel{
        let title: String
        let details: String
    }
    
    // MARK: - IBOutlets 🔌
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var detailsLabel: UILabel!
    
    // MARK: - LifeCycle 🌏
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        bag = DisposeBag()
    }
    
    //
    func fill(_ data: DataType) {
        titleLabel.text = data.title
        detailsLabel.text = data.details
    }
}

// MARK: -
private extension HotelDetailsTableViewCell {
    func setup() {
        
    }
}

