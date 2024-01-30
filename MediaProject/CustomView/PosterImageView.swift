//
//  PosterImageView.swift
//  MediaProject
//
//  Created by 최서경 on 1/31/24.
//

import UIKit
class PosterImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        contentMode = .scaleAspectFill
        layer.cornerRadius = 12
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
