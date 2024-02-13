//
//  ProfileSettingViewController.swift
//  MediaProject
//
//  Created by 최서경 on 2/13/24.
//

import UIKit

class ProfileSettingViewController: UIViewController {
    let mainView = ProfileSettingView()
    
    var titleText: String = ""
    var titleSpace: ((String) -> Void)?
    
    override func loadView() {
        // 이렇게 전달해도 되는 건지 . . .? load된 뷰에서 모든 뷰에 관련된 데이터를 관리하는데...
        mainView.titleTextField.placeholder = titleText
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = titleText
        let rightButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(rightButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func rightButtonTapped() {
        print(#function)
        titleSpace?(mainView.titleTextField.text!)
        navigationController?.popViewController(animated: true)
    }
}
