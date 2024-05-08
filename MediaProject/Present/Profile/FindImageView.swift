//
//  FindImageView.swift
//  MediaProject
//
//  Created by 최서경 on 2/14/24.
//

import UIKit

class FindImageView: BaseView {
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        view.register(FindImageCollectionViewCell.self, forCellWithReuseIdentifier: FindImageCollectionViewCell.identifier)
        return view
    }()
    
    
    override func configureHierarchy() {
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    override func configureView() {
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        
        return layout
    }
}
