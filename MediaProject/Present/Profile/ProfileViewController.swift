//
//  ProfileViewController.swift
//  MediaProject
//
//  Created by 최서경 on 2/12/24.
//

import UIKit

class ProfileViewController: UIViewController {
    let mainView = ProfileView()
    
    override func loadView() {
        print(#function)
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        navigationItem.title = "프로필 설정"
        
        configureTapGestureRecognizer()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        mainView.configureRadius()
    }

    
    func configureTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestuerAction(_:)))
        
        for label in mainView.labelSettingList {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestuerAction(_:)))
            label.addGestureRecognizer(tapGestureRecognizer)
            label.isUserInteractionEnabled = true
        }
        
        mainView.profileImageView.addGestureRecognizer(tapGestureRecognizer)
        mainView.profileImageView.isUserInteractionEnabled = true
    }
    
    @objc func tapGestuerAction(_ sender: UITapGestureRecognizer) {
        print(type(of: sender))
        var titleText = ""
        
        if let labelText = sender.view as? UILabel {
            let vc = ProfileSettingViewController()
            
            if let text = labelText.text {
                titleText = text
            }
            
            vc.titleSpace = { value in
                labelText.text = value
            }
            
            vc.titleText = titleText
            
            transition(style: .push, viewController: vc)
        }
        
        if let profileImageView = sender.view as? UIImageView {
            let vc = FindImageViewController()
            
            titleText = "프로필 이미지 선택"
            
            vc.imageLinkSpace = { value in
                profileImageView.kf.setImage(with: URL(string: value))
            }
            
            vc.titleText = titleText
            
            transition(style: .push, viewController: vc)
        }
        
    }
}
