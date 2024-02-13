//
//  WhiteTextLabel.swift
//  MediaProject
//
//  Created by 최서경 on 2/13/24.
//

import UIKit

class WhiteTextLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    func configureView() {
        self.font = .boldSystemFont(ofSize: 17)
        textAlignment = .left
        numberOfLines = 2
        backgroundColor = .clear
        textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

