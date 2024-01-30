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
    let tvShowTableView = UITableView()
    var popularList: [Popular] = []
    var topRatedList: [TopRated] = []
    var trendingList: [Trending] = []


    var imageList: [PosterModel] = [
        PosterModel(posters: []),
        PosterModel(posters: []),
        PosterModel(posters: [])]
    
    var titleList: [String] = ["Trending", "Popular", "TopRated"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
        configureHierarchy()
        configureLayout()
        configureView()
        
        TMDBManager.shared.fetchPopularTV { tv in
            self.popularList = tv
            
            self.tvShowTableView.reloadData()
            TMDBManager.shared.fetchTVImages(id: tv.randomElement()?.id ?? 0) { poster in
                self.imageList[0] = poster
                self.tvShowTableView.reloadData()
            }
        }
        TMDBManager.shared.fetchTopRatedTV { tv in
            self.topRatedList = tv

            self.tvShowTableView.reloadData()
            TMDBManager.shared.fetchTVImages(id: tv.randomElement()?.id ?? 1) { poster in
                self.imageList[1] = poster
                self.tvShowTableView.reloadData()
            }
        }
        TMDBManager.shared.fetchTrendingTV { tv in
            self.trendingList = tv

            self.tvShowTableView.reloadData()
            TMDBManager.shared.fetchTVImages(id: tv.randomElement()?.id ?? 2) { poster in
                self.imageList[2] = poster
                self.tvShowTableView.reloadData()
            }
        }
    }
}

extension ViewController {
    func configureHierarchy() {
        view.addSubview(tvShowTableView)
    }
    
    func configureLayout() {
        tvShowTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        tvShowTableView.delegate = self
        tvShowTableView.dataSource = self
        tvShowTableView.register(TVTableViewCell.self, forCellReuseIdentifier: "TVTableViewCell")
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVTableViewCell", for: indexPath) as! TVTableViewCell
        cell.tvCollectionView.delegate = self
        cell.tvCollectionView.dataSource = self

        cell.tvCollectionView.register(TVCollectionViewCell.self, forCellWithReuseIdentifier: "TVCollectionViewCell")

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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVCollectionViewCell", for: indexPath) as! TVCollectionViewCell
        
        switch collectionView.tag {
        case 0:
            let item = trendingList[indexPath.item]
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(item.poster_path)")
            cell.postetImageView.kf.setImage(with: url)
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
}
