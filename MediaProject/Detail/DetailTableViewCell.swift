//
//  DatailTableViewCell.swift
//  MediaProject
//
//  Created by 최서경 on 1/31/24.
//

import UIKit

class DetailTableViewCell: BaseTableViewCell {
    let titleLable = BlackTextLabel()
    let posterImageView = UIImageView()
    let creditImageView = UIImageView()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    override func configureHierarchy() {
        contentView.addSubview(titleLable)
        contentView.addSubview(collectionView)
    }
    
    override func configureConstraints() {
        titleLable.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(20)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(200)
        }
        
    }
    override func configureView() {
        backgroundColor = .green
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 200)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        
        return layout
    }
}
