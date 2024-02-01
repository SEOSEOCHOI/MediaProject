//
//  SubTitleLabel.swift
//  MediaProject
//
//  Created by 최서경 on 2/1/24.
//

import UIKit

class SubTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    func configureView() {
        self.font = .boldSystemFont(ofSize: 12)
        textAlignment = .left
        numberOfLines = 0
        backgroundColor = .clear
        textColor = .darkGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
