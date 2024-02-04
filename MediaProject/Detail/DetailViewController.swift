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
    let mainView = DetailVeiw()
    override func loadView() {
        self.view = mainView
    }
    
    var findId: Int = 0
    var navgationTitle = ""
    
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
        navigationItem.title = navgationTitle
        mainView.detailTableView.dataSource = self
        mainView.detailTableView.delegate = self
        
    }
    // 📖: 내일 가서 적절한 방법(시점)인지 물어보기 -> 맞음!
    // 네트워크 통신을 받고 난 뒤 / 받기 전 뷰로 구분지어 보기 📍
    // 📖: 통신을 통해 데이터를 얻어서 view를 구성하면... view 파일로 뺄 수 없는지 생각해 보기 -> 됨! 생각해 보기 📍
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

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier) as! DetailTableViewCell
        
        cell.titleLable.text = titleList[indexPath.row]
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: DetailCollectionViewCell.identifier)
        
        cell.collectionView.tag = indexPath.row
        cell.collectionView.reloadData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
}
// TODO: tag 사용하지 않고 관리
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            if !detailData.isEmpty {
                let data = detailData[0]
                let item = data.seasons
                if item.count != 0 {
                    return detailData[section].seasons.count
                }
            }
            return 0
        case 1: return castList.count
        case 2: return crewList.count
        case 3: return recommeandList.count
        default: break
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.identifier, for: indexPath) as! DetailCollectionViewCell
        
        switch collectionView.tag {
        case 0:
            let data = detailData[0]
            let item = data.seasons[indexPath.item]
            if let imagePath = item?.poster_path {
                let url = URL(string: baseURL + imagePath)
                cell.imageView.kf.setImage(with: url)
            }
            cell.titleLabel.text = item?.name
            
        case 1:
            let item = castList[indexPath.item]
            if let imagePath = item.profile_path {
                let url = URL(string: baseURL + imagePath)
                cell.imageView.kf.setImage(with: url)
            }
            cell.titleLabel.text = item.original_name
        case 2:
            let item = crewList[indexPath.item]
            if let imagePath = item.profile_path {
                let url = URL(string: baseURL + imagePath)
                cell.imageView.kf.setImage(with: url)
            }
            cell.titleLabel.text = item.original_name
        case 3:
            let item = recommeandList[indexPath.item]
            if let imagePath = item.poster_path {
                let url = URL(string: baseURL + imagePath)
                cell.imageView.kf.setImage(with: url)
            }
            cell.titleLabel.text = item.original_name
        default: break
        }
        return cell
    }
}
