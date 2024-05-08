//
//  FindImageCollectionViewCell.swift
//  MediaProject
//
//  Created by 최서경 on 2/14/24.
//

import UIKit
import SnapKit

class FindImageCollectionViewCell: BaseCollectionViewCell {
    let profileImageView = PosterImageView(frame: .zero)
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(profileImageView.snp.width)
            make.top.equalTo(contentView)
        }
    }
    
    override func configureHierarchy() {
        contentView.addSubview(profileImageView)
    }
    
    override func configureView() {
        profileImageView.image = UIImage(systemName: "network.slash")
        contentView.backgroundColor = .clear
    }
}
