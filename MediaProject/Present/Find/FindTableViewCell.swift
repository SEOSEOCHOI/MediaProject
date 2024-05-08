//
//  FindTableViewCell.swift
//  MediaProject
//
//  Created by 최서경 on 2/4/24.
//

import UIKit

class FindTableViewCell: BaseTableViewCell {
    let titleLabel = BlackTextLabel()
    let posterImageView = PosterImageView(frame: .zero)
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(posterImageView)
    }
    
    override func configureConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalTo(contentView).inset(20)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.2)
            make.height.equalTo(posterImageView.snp.width).multipliedBy(1.3)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.top)
            make.leading.equalTo(posterImageView.snp.trailing).offset(8)
            make.trailing.equalTo(contentView).inset(8)
            make.height.equalTo(25)
        }
    }
    
    override func configureView() {

    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
