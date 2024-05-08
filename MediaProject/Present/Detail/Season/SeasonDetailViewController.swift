//
//  SeasonDetailViewController.swift
//  MediaProject
//
//  Created by 최서경 on 2/6/24.
//

import UIKit

class SeasonDetailViewController: BaseViewController {
    let mainView = SeasonDetailView()
    override func loadView() {
        self.view = mainView
    }
    
    var findId = 0
    var navigationTitle = ""
    
    var detailData: [DetailsModel] = []
    var recommeandList: [Recommand] = []
    var castList: [Credit] = []
    var crewList: [Credit] = []
    
    var titleList: [String] = ["Season", "Cast", "Crew", "Recommand"]
    
    let baseURL = "https://image.tmdb.org/t/p/original/"
    
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: TVTableViewCell.configureCollectionViewLayout())
        view.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: DetailCollectionViewCell.identifier)
        return view
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        //navigationItem.title = navgationTitle
        //mainView.detailTableView.dataSource = self
        //mainView.detailTableView.delegate = self
    }
    
    override func configureView() {
        if !detailData.isEmpty {
            let data = detailData[0]
            
            let posterURL = URL(string: baseURL + (data.poster_path ?? ""))
            let backdropURL = URL(string: baseURL + data.backdrop_path)
            
            mainView.backdropView.backdropImageView.kf.setImage(with: backdropURL, placeholder: UIImage(systemName: "Star"))
            mainView.posterImageView.kf.setImage(with: posterURL, placeholder: UIImage(systemName: "Star"))
            mainView.tvShowNameLabel.text = data.name
            mainView.tvShowOriginalNamelabel.text = data.original_name
            mainView.explainLabel.text = data.overview
        }
    }
    func fetchData() {
        Task {
            let detailResult = try await TMDBSessionManager.shared.fetchTMDBAsyncAwait(type: DetailsModel.self, api: .detail(id: findId))

            detailData.append(detailResult)

            configureView()

        }
        Task {
            let recommandResult = try await TMDBSessionManager.shared.fetchTMDBAsyncAwait(type: RecommandModel.self, api: .recommand(id: findId))
            
            recommeandList = recommandResult.results

            mainView.detailTableView.reloadData()
            collectionView.reloadData()
        }
        Task {
            let creditResult = try await TMDBSessionManager.shared.fetchTMDBAsyncAwait(type: CreditModel.self, api: .credit(id: findId))
            
            castList = creditResult.cast
            crewList = creditResult.crew
            mainView.detailTableView.reloadData()
            collectionView.reloadData()
        }
    }
}
