//
//  DatailViewControlle.swift
//  MediaProject
//
//  Created by 최서경 on 1/31/24.
//

import UIKit
import SnapKit
import Kingfisher

class DetailViewController: BaseViewController {
    lazy var detailTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
        return view
    }()

    let detailView = UIView()
    let tvShowNameLabel = TitleTextLabel()
    let tvShowOriginalNamelabel = SubTitleLabel()
    let explainLabel = ExplainLabel()
    let backdropView = BackdropView()
    let posterImageView = PosterImageView(frame: .zero)
    
    lazy var findId: Int = 0
    var detailData: [DetailsModel] = []
    var recommeandList: [Recommand] = []
    var creditList: [CreditModel] = []
    
    let baseURL = "https://image.tmdb.org/t/p/original/"

    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        let group = DispatchGroup()
        
        group.enter()
        TMDBManager.shared.fetchDetails(id: findId) { result in
            self.detailData.append(result)
            group.leave()
        }
        
        group.enter()
        TMDBManager.shared.fetchRecommand(id: findId) { reuslt in
            self.recommeandList = reuslt
            group.leave()
        }
        
        group.enter()
        TMDBManager.shared.fetchCredit(id: findId) { result in
            if let list = result {
                self.creditList.append(list)
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.detailData = self.detailData
            
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureView()
    }
    override func configureHierarchy() {
        view.addSubview(detailView)
        detailView.addSubview(backdropView)
        detailView.addSubview(posterImageView)
        detailView.addSubview(tvShowNameLabel)
        detailView.addSubview(tvShowOriginalNamelabel)
        detailView.addSubview(explainLabel)
        view.addSubview(detailTableView)
    }
    override func configureLayout() {
        detailView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(detailView.snp.width).dividedBy(2)
        }
        detailTableView.snp.makeConstraints { make in
            make.top.equalTo(detailView.snp.bottom)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
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
    override func configureView() {
        print(#function)
        let data = detailData[0]

        let posterURL = URL(string: baseURL + (data.poster_path ?? ""))
        let backdropURL = URL(string: baseURL + data.backdrop_path)

        backdropView.backdropImageView.kf.setImage(with: posterURL, placeholder: UIImage(systemName: "Star"))
        posterImageView.kf.setImage(with: backdropURL, placeholder: UIImage(systemName: "Star"))
        tvShowNameLabel.text = data.name
        tvShowOriginalNamelabel.text = data.original_name
        explainLabel.text = data.overview
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier) as! DetailTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
