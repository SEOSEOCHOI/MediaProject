//
//  ViewController.swift
//  MediaProject
//
//  Created by 최서경 on 1/30/24.
//

import UIKit
import SnapKit
import Kingfisher

class ViewController: UIViewController {

    var TVShowList: [TVShowModel] = [
        TVShowModel(tvShow: []),
        TVShowModel(tvShow: []),
        TVShowModel(tvShow: [])]
    
    var titleList: [String] = ["Trending", "Popular", "TopRated"]
    
    let mainView = TVShowView()
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
        fetchTVShow()
        mainView.tvShowTableView.delegate = self
        mainView.tvShowTableView.dataSource = self
        mainView.searchBar.delegate = self 
        
        navigationItem.title = "추천 작품"
    }
}

extension ViewController {
    func fetchTVShow() {
        let group = DispatchGroup()

        Task {
            let result = try await TMDBSessionManager.shared.fetchTMDBAsyncAwait(type: TVShowModel.self, api: .trending)
            self.TVShowList[0] = result
            self.mainView.tvShowTableView.reloadData()
        }
        
        Task {
            let result = try await TMDBSessionManager.shared.fetchTMDBAsyncAwait(type: TVShowModel.self, api: .popular)
            self.TVShowList[1] = result
            self.mainView.tvShowTableView.reloadData()
        }
        
        Task {
            let result = try await TMDBSessionManager.shared.fetchTMDBAsyncAwait(type: TVShowModel.self, api: .toprated)
            self.TVShowList[2] = result
            self.mainView.tvShowTableView.reloadData()
        }

    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    // TODO: Tag 관련 코드 수정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TVTableViewCell.identifier, for: indexPath) as! TVTableViewCell
        cell.tvCollectionView.delegate = self
        cell.tvCollectionView.dataSource = self
        cell.tvCollectionView.register(TVCollectionViewCell.self, forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
        
        cell.tvCollectionView.tag = indexPath.row
        cell.tvCollectionView.reloadData()
        
        cell.titleLable.text = titleList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return TVShowList[collectionView.tag].tvShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as! TVCollectionViewCell
        
        let item = TVShowList[collectionView.tag].tvShow[indexPath.item]
        print(item)
        if let image = item.poster_path {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
            cell.postetImageView.kf.setImage(with:  url)
            cell.titleLabel.text = item.name
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        let item = TVShowList[collectionView.tag].tvShow[indexPath.item]
        
        vc.findId = item.id
        vc.navgationTitle = item.name
        transition(style: .push, viewController: vc)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let vc = FindViewController()
        if let findTitle = searchBar.text {
            vc.findTitle = findTitle
            print(findTitle)
        }
        transition(style: .push, viewController: vc)
    }
}

