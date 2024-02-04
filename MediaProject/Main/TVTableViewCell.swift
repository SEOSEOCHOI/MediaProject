//
//  TVTableViewCell.swift
//  MediaProject
//
//  Created by 최서경 on 1/30/24.
//

import UIKit

class TVTableViewCell: BaseTableViewCell {
    let titleLable = BlackTextLabel()
    let tvCollectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())

    override func configureHierarchy() {
        contentView.addSubview(titleLable)
        contentView.addSubview(tvCollectionView)
    }
    
    override func configureConstraints() {
        titleLable.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(20)
        }
        tvCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(contentView)
        }
    }
    
    override func configureView() {
        contentView.backgroundColor = .white
    }
    
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 210)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        
        return layout
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
