//
//  SeasonDetailView.swift
//  MediaProject
//
//  Created by 최서경 on 2/6/24.
//

import UIKit

class SeasonDetailView: BaseView {
    lazy var detailTableView: UITableView = {
        let view = UITableView()
        view.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
        return view
    }()

    let detailView = UIView()
    let tvShowNameLabel = TitleTextLabel()
    let tvShowOriginalNamelabel = SubTitleLabel()
    let explainLabel = ExplainLabel()
    let backdropView = BackdropView()
    let posterImageView = PosterImageView(frame: .zero)
    
    override func configureHierarchy() {
        addSubview(detailView)
        detailView.addSubview(backdropView)
        detailView.addSubview(posterImageView)
        detailView.addSubview(tvShowNameLabel)
        detailView.addSubview(tvShowOriginalNamelabel)
        detailView.addSubview(explainLabel)
        addSubview(detailTableView)
    }
    override func configureLayout() {
        detailView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(detailView.snp.width).dividedBy(2)
        }
        detailTableView.snp.makeConstraints { make in
            make.top.equalTo(detailView.snp.bottom)
            make.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        backdropView.snp.makeConstraints { make in
            make.edges.equalTo(detailView.safeAreaLayoutGuide)
        }
        posterImageView.snp.makeConstraints { make in
            make.leading.verticalEdges.equalTo(detailView).inset(20)
            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.8)
        }
        tvShowNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(10)
            make.trailing.equalTo(detailView).inset(10)
            make.top.equalTo(posterImageView)
            make.height.equalTo(30)
        }
        tvShowOriginalNamelabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(10)
            make.trailing.equalTo(detailView).inset(10)
            make.top.equalTo(tvShowNameLabel.snp.bottom).offset(5)
            make.height.equalTo(20)
        }
        explainLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(10)
            make.trailing.equalTo(detailView).inset(10)
            make.top.equalTo(tvShowOriginalNamelabel.snp.bottom).offset(5)
            make.bottom.equalTo(posterImageView.snp.bottom)

        }
    }
}
