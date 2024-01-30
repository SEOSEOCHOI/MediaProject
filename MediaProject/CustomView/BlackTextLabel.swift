//
//  BlackTextLabel.swift
//  MediaProject
//
//  Created by 최서경 on 1/30/24.
//

import UIKit
class BlackTextLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    func configureView() {
        self.font = .boldSystemFont(ofSize: 17)
        textAlignment = .left
        numberOfLines = 2
        backgroundColor = .clear
        textColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
