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
        let group = DispatchGroup()
        
        group.enter()
         TMDBManager.shared.fetchDetails(api: .detail(id: findId), completionHandler: { detail in
         self.detailData.append(detail)
         group.leave()
         })
         
         group.enter()
         TMDBManager.shared.fetchRecommand(api: .recommand(id: findId), completionHandler: { detail in
         self.recommeandList = detail
         group.leave()
         })
         
         group.enter()
         TMDBManager.shared.fetchCredit(api: .credit(id: findId), completionHandler: { detail in
         self.castList = detail.cast
         self.crewList = detail.crew
         
         group.leave()
         })

        group.notify(queue: .main) {
            self.configureView()
            self.mainView.detailTableView.reloadData()
            self.collectionView.reloadData()
        }
    }
}
