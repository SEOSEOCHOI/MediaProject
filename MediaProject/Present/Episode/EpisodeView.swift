//
//  EpisodeView.swift
//  MediaProject
//
//  Created by 최서경 on 2/5/24.
//

import UIKit
import SnapKit

class EpisodeView: BaseView {
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(EpisodeTableViewCell.self, forCellReuseIdentifier: EpisodeTableViewCell.identifier)
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

}
