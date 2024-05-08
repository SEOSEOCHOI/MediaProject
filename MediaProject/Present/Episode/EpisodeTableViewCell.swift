//
//  EpisodeTableViewCell.swift
//  MediaProject
//
//  Created by 최서경 on 2/5/24.
//

import UIKit

class EpisodeTableViewCell: BaseTableViewCell {
    let titleLabel = BlackTextLabel()
    let roundLabel = TitleTextLabel()
    let posterImageView = UIImageView()
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(roundLabel)
        contentView.addSubview(posterImageView)
    }
    
    override func configureConstraints() {


        
    }
    override func configureView() {
        backgroundColor = .red
        
    }
    


}
