//
//  BaseTableViewCell.swift
//  MediaProject
//
//  Created by 최서경 on 1/31/24.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        configureHierarchy()
        configureConstraints()
        configureView()
    }
    
    func configureHierarchy() {
    }
    
    func configureConstraints() {
    }
    
    func configureView() {
    }
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
