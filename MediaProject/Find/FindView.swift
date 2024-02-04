//
//  FindView.swift
//  MediaProject
//
//  Created by 최서경 on 2/4/24.
//

import UIKit
import SnapKit

class FindView: BaseView {
    let tableView: UITableView = {
        let view = UITableView()
        view.register(FindTableViewCell.self, forCellReuseIdentifier: FindTableViewCell.identifier)
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    override func configureView() {
    }
}
