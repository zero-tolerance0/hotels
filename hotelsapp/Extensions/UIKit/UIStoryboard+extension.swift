//
//  UIStoryboard+extension.swift
//  hotelsapp
//
//  Created by zerohero on 6/24/20.
//  Copyright © 2020 indev. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static func get<T>(_ type: T.Type) -> T {
        let id = String(describing: type)
        let storyboard = UIStoryboard(name: id, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? T {
            return viewController
        } else {
            return storyboard.instantiateViewController(withIdentifier: id) as! T
        }
    }
}
