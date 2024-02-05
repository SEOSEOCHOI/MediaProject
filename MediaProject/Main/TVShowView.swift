//
//  TVShowView.swift
//  MediaProject
//
//  Created by 최서경 on 2/2/24.
//

import UIKit
import SnapKit

// 뷰만!
class TVShowView: BaseView {
    let searchBar: UISearchBar = {
       let view = UISearchBar()
        view.placeholder = "TV, 배우, 작가, 감독을 검색해 보세요."
        return view
    }()
    
    let tvShowTableView: UITableView = {
        let view = UITableView()
        view.register(TVTableViewCell.self, forCellReuseIdentifier: TVTableViewCell.identifier)
        return view
    }()
    
    override func configureHierarchy() {  
        addSubview(tvShowTableView)
        addSubview(searchBar)
    }
    
    override func configureLayout() {
        
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        tvShowTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
