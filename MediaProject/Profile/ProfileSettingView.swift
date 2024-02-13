//
//  ProfileSettingView.swift
//  MediaProject
//
//  Created by 최서경 on 2/13/24.
//

import UIKit
import TextFieldEffects

class ProfileSettingView: BaseView {
    let titleTextField = HoshiTextField()
    
    override func configureHierarchy() {
        addSubview(titleTextField)
    }
    
    override func configureLayout() {
        titleTextField.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(safeAreaLayoutGuide).inset(10)
            make.height.equalTo(30)
        }
    }
    
    override func configureView() {
        titleTextField.placeholderColor = .lightGray
        titleTextField.placeholderFontScale = 1
        titleTextField.clearButtonMode = .whileEditing
    }
}

