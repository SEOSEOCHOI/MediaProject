//
//  DetailCollectionViewCell.swift
//  MediaProject
//
//  Created by 최서경 on 2/1/24.
//

import UIKit
import SnapKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    let imageView = PosterImageView(frame: .zero)
    let titleLabel = TitleTextLabel()
    
    // 1. 코드
    // 초기값 세팅, 재정의
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(20)
        }
    }
    
    func configureHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    
    func configureView() {
        imageView.image = UIImage(systemName: "person")
        titleLabel.text = "test"
    }
    // 2.  스토리보드 XIB
    // 프로토콜의 필수 메서드
    // fatalError 실행될 일이 없기 때문에 딱히 수정할 필요도 X
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
