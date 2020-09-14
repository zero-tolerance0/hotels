//
//  HotelCell.swift
//  hotelsapp
//
//  Created by zerohero on 6/24/20.
//  Copyright © 2020 indev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class HotelCell: BaseTableViewCell, FillableProtocol {
    
    var bag = DisposeBag()
    
    typealias DataType = ViewModel
    struct ViewModel{
        let name: String
        let address: String
        let starsCount: Double
        let distanceAway: Double
    }
    
    // MARK: - Visible Propeerties 👓
    var isNotificationSelected: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    // MARK: - IBOutlets 🔌
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var starsLabel: UILabel!
    @IBOutlet private weak var distanceLabel: UILabel!
    
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
        titleLabel.text = data.name
        addressLabel.text = data.address
        starsLabel.text = String(data.starsCount) + "/5.0"
        distanceLabel.text = String(data.distanceAway) + " m away"
    }
}

// MARK: -
private extension HotelCell {
    func setup() {
        
    }
}
