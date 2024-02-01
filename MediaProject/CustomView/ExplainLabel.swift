//
//  ExplainLabel.swift
//  MediaProject
//
//  Created by 최서경 on 2/1/24.
//

import UIKit

class ExplainLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    func configureView() {
        self.font = .systemFont(ofSize: 11)
        textAlignment = .left
        numberOfLines = 0
        backgroundColor = .clear
        textColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
