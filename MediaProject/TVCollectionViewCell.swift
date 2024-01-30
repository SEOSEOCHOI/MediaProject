//
//  TVCollectionViewCell.swift
//  MediaProject
//
//  Created by 최서경 on 1/31/24.
//

import UIKit
import SnapKit

class TVCollectionViewCell: UICollectionViewCell {
    let postetImageView = PosterImageView(frame: .zero)
    let titleLabel = TitleTextLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureLayout() {
        postetImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(postetImageView.snp.width).multipliedBy(1.3)
            make.top.equalTo(contentView)
        }
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView)
            make.top.equalTo(postetImageView.snp.bottom).offset(5)
            make.bottom.equalTo(contentView.snp.bottom)
       }
    }
    
    func configureHierarchy() {
        contentView.addSubview(postetImageView)
        contentView.addSubview(titleLabel)
    }
    
    func configureView() {
        postetImageView.image = UIImage(systemName: "network.slash")
        contentView.backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
