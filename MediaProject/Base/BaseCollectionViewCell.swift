//
//  BaseCollectionViewCell.swift
//  MediaProject
//
//  Created by 최서경 on 2/14/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureLayout() {
    }
    
    func configureHierarchy() {

    }
    
    func configureView() {

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
