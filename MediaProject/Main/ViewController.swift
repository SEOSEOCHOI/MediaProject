//
//  ViewController.swift
//  MediaProject
//
//  Created by 최서경 on 1/30/24.
//

import UIKit
import SnapKit
import Kingfisher


// 📖 그런데 뷰를 따로 관리할 거면 현재 configureView, hierarchy 관련 메서드만 있으면... baseVC를 상속을 안 받아도 되는 건가???? ㅜ
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
        fetchTVShow()
        mainView.tvShowTableView.delegate = self
        mainView.tvShowTableView.dataSource = self
    }
}

extension ViewController {
    func fetchTVShow() {
        let group = DispatchGroup()
        
        group.enter()
        TMDBManager.shared.fetchTVShow(api: .trending) { tv in
            self.TVShowList[0] = tv
            group.leave()
        }
        
        group.enter()
        TMDBManager.shared.fetchTVShow(api: .popular, completionHandler: { tv in
            self.TVShowList[1] = tv
            group.leave()
        })
        
        group.enter()
        TMDBManager.shared.fetchTVShow(api: .toprated, completionHandler: { tv in
            self.TVShowList[2] = tv
            group.leave()
        })
        
        group.notify(queue: .main) {
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
        if let image = item.poster_path {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
            cell.postetImageView.kf.setImage(with:  url)
            cell.titleLabel.text = item.name
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        
        vc.findId = TVShowList[collectionView.tag].tvShow[indexPath.item].id
        present(vc, animated: true)
    }
}

