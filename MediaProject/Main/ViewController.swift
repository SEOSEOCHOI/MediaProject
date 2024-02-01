//
//  ViewController.swift
//  MediaProject
//
//  Created by 최서경 on 1/30/24.
//

import UIKit
import SnapKit
import Kingfisher

class ViewController: BaseViewController {
    lazy var tvShowTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(TVTableViewCell.self, forCellReuseIdentifier: TVTableViewCell.identifier)
        return view
    }()

    var popularList: [Popular] = []
    var topRatedList: [TopRated] = []
    var trendingList: [Trending] = []
    
    var titleList: [String] = ["Trending", "Popular", "TopRated"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
fetchTVShow()
        configureView()
    }

    override func configureHierarchy() {
        view.addSubview(tvShowTableView)
    }
    
    override func configureLayout() {
        tvShowTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        
    }
}

extension ViewController {
    func fetchTVShow() {
        let group = DispatchGroup()
        
        group.enter()
        TMDBManager.shared.fetchPopularTV { tv in
            self.popularList = tv
            group.leave()
        }
        
        group.enter()
        TMDBManager.shared.fetchTopRatedTV { tv in
            self.topRatedList = tv
            group.leave()
        }
        
        group.enter()
        TMDBManager.shared.fetchTrendingTV { tv in
            self.trendingList = tv
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.tvShowTableView.reloadData()
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

// TODO: Tag 관련 코드 수정
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return trendingList.count
        case 1:
            return popularList.count
        case 2:
            return topRatedList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as! TVCollectionViewCell
        
        switch collectionView.tag {
        case 0:
            let item = trendingList[indexPath.item]
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(item.poster_path)")
            cell.postetImageView.kf.setImage(with:  url)
            cell.titleLabel.text = item.name
        case 1:
            let item = popularList[indexPath.item]
            if let image = item.poster_path {
                let url = URL(string: "https://image.tmdb.org/t/p/w500\(image)")
                cell.postetImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "person"))
                cell.titleLabel.text = item.name
            }
        case 2:
            let item = topRatedList[indexPath.item]
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(item.poster_path)")
            cell.postetImageView.kf.setImage(with: url)
            cell.titleLabel.text = item.name
        default: break
        }
        return cell
    }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let vc = DetailViewController()
    
            switch collectionView.tag {
            case 0:
                vc.findId = trendingList[indexPath.item].id
            case 1:
                vc.findId = popularList[indexPath.item].id
            case 2:
                vc.findId = topRatedList[indexPath.item].id
            default: break
            }
            present(vc, animated: true)
        }
}

