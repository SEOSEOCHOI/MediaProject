//
//  FindViewController.swift
//  MediaProject
//
//  Created by 최서경 on 2/4/24.
//

import UIKit

class FindViewController: BaseViewController {
    let mainView = FindView()
    override func loadView() {
        self.view = mainView
    }
    
    var findTitle: String = ""

    var searchList: [Search] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        print(findTitle, "viewdidload, FindView")
        navigationItem.title = findTitle
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        fetchData()
    }
    
    func fetchData() {
        
        Task {
            let result = try await TMDBSessionManager.shared.fetchTMDBAsyncAwait(type: SearchModel.self, api: .search(query: findTitle))
            searchList = result.results
            mainView.tableView.reloadData()
            
        }
    }
}

extension FindViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FindTableViewCell.identifier, for: indexPath) as! FindTableViewCell
        
        cell.posterImageView.backgroundColor = .magenta
        let row = searchList[indexPath.row]
        let baseURL = "https://image.tmdb.org/t/p/original/"
        if let imageURL = row.poster_path {
            let url = URL(string: baseURL + imageURL)
            cell.posterImageView.kf.setImage(with: url)
        }

        cell.titleLabel.text = row.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        let item = searchList[indexPath.row]
        
        vc.findId = item.id
        vc.navgationTitle = item.name
        transition(style: .push, viewController: vc)
    }
    
    
}
