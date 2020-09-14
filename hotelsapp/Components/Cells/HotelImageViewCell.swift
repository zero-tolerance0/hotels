//
//  HotelImageViewCell.swift
//  hotelsapp
//
//  Created by zerohero on 6/24/20.
//  Copyright © 2020 indev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class HotelImageViewCell: BaseTableViewCell, FillableProtocol {
    
    var bag = DisposeBag()
    
    typealias DataType = ViewModel
    struct ViewModel{
        let imageUrl: String
    }
    
    // MARK: - IBOutlets 🔌
    @IBOutlet private weak var hotelImageView: CachedImageView!
    
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
        hotelImageView.loadImage(urlString: data.imageUrl) {
            let width = self.hotelImageView.frame.width * 6
            let height = self.hotelImageView.frame.height * 6
            self.hotelImageView.image = self.hotelImageView.image?.imageByCropToRect(rect: CGRect(x: 1, y: 1, width: width - 1, height: height - 1), scale: false)
        }
    }
}

// MARK: -
private extension HotelImageViewCell {
    func setup() {
        
    }
}
