//
//  FindImageViewController.swift
//  MediaProject
//
//  Created by 최서경 on 2/14/24.
//

import UIKit

class FindImageViewController: UIViewController {
    let mainView = FindImageView()
    
    var titleText: String = ""
    var imageList: [ImageItem] = []
    var urlString: String = ""
    
    var imageLinkSpace: ((String) -> Void)?
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleText
        
        fetchData()
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        // TODO: pagenation
        
        let rightButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(rightButtonTapped))
        navigationItem.rightBarButtonItem = rightButton

    }
    
    
    @objc func rightButtonTapped() {
        print(#function)
        imageLinkSpace?(urlString)
        navigationController?.popViewController(animated: true)
    }
    
    func fetchData() {
        let group = DispatchGroup()
        
        group.enter()
        NaverImageAPIManager.shared.callRequest(api: .image(query: "사과")) { value in
            self.imageList = value.imageModel
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.mainView.collectionView.reloadData()
        }

    }
}

extension FindImageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FindImageCollectionViewCell.identifier, for: indexPath) as! FindImageCollectionViewCell
        
        let item = imageList[indexPath.item]
        let url = URL(string: item.link)
        
            cell.profileImageView.kf.setImage(with: url)
        cell.backgroundColor = .brown

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        urlString = imageList[indexPath.item].link
    }

}
