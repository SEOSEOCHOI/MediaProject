//
//  DatailTableViewCell.swift
//  MediaProject
//
//  Created by 최서경 on 1/31/24.
//

import UIKit

class DetailTableViewCell: BaseTableViewCell {
    let titleLable = BlackTextLabel()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }
    
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
            make.top.equalTo(titleLable.snp.bottom)
            make.horizontalEdges.bottom.equalTo(contentView)
        }
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 160)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
    override func configureView() {
        backgroundColor = .green
        collectionView.backgroundColor = .blue
        titleLable.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 스토리보드 xib => nib => nib 실행
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
