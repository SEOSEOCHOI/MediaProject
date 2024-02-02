//
//  TVShowView.swift
//  MediaProject
//
//  Created by 최서경 on 2/2/24.
//

import UIKit

// 뷰만!
class TVShowView: BaseView {
    
    let tvShowTableView: UITableView = {
        let view = UITableView()
        view.register(TVTableViewCell.self, forCellReuseIdentifier: TVTableViewCell.identifier)
        return view
    }()
    
    override func configureHierarchy() {       addSubview(tvShowTableView)
    }
    
    override func configureLayout() {
        tvShowTableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
