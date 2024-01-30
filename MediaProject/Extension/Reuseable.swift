//
//  Reuseable.swift
//  MediaProject
//
//  Created by 최서경 on 1/30/24.
//

import UIKit

extension UIView: ReuseableProtocol {
    static var identifier: String {
        return description()
    }
}

extension UIViewController: ReuseableProtocol {
    static var identifier: String {
        return description()
    }
}
