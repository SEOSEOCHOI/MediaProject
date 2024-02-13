//
//  ProfileView.swift
//  MediaProject
//
//  Created by 최서경 on 2/12/24.
//

import UIKit
import SnapKit

enum Profile: String, CaseIterable {
    case name = "이름"
    case userNmae = "사용자 이름"
    case introduction = "소개"
}

class ProfileView: BaseView {
    let profileImageView = UIImageView()
    let labelStackView = UIStackView()
    let labelSettingStackView = UIStackView()
    
    let nameLabel = WhiteTextLabel()
    let userNameLabel = WhiteTextLabel()
    let introductionLabel = WhiteTextLabel()
    
    let nameSettingLabel = ExplainLabel()
    let userNameSettingLabel = ExplainLabel()
    let introductionSettingLabel = ExplainLabel()
    
    let profileOptions = Profile.allCases
    
    lazy var labelList: [UILabel] = [nameLabel, userNameLabel, introductionLabel]
    lazy var labelSettingList: [UILabel] = [nameSettingLabel, userNameSettingLabel, introductionSettingLabel]
    
    var labelTag = 0
    var labelSettingTag = 0
    
    override func configureHierarchy() {
        addSubview(profileImageView)
        addSubview(labelStackView)
        addSubview(labelSettingStackView)
        
        for label in labelList {
            labelStackView.addSubview(label)
        }
        
        for label in labelSettingList {
            labelSettingStackView.addSubview(label)
        }
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(20)
            make.centerX.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.3)
            make.height.equalTo(profileImageView.snp.width)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.bottom.leading.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.width.equalTo(safeAreaLayoutGuide).multipliedBy(0.35)
        }
        
        labelSettingStackView.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(safeAreaLayoutGuide)
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.leading.equalTo(labelStackView.snp.trailing)
        }
        
        configureLabel()
        configureTextField()
        
        for item in 0...labelSettingTag - 1 {
            labelSettingList[item].snp.makeConstraints { make in
                if item == 0 {
                    make.top.equalTo(labelSettingStackView.snp.top)
                } else {
                    make.top.equalTo(labelSettingList[item - 1].snp.bottom)
                }
                make.height.equalTo(25)
                make.horizontalEdges.equalTo(labelSettingStackView)
            }
        }
        
        for item in 0...labelTag - 1 {
            labelList[item].snp.makeConstraints { make in
                if item == 0 {
                    make.top.equalTo(labelStackView.snp.top)
                } else {
                    make.top.equalTo(labelList[item - 1].snp.bottom)
                }
                make.height.equalTo(25)
                make.horizontalEdges.equalTo(labelStackView)
            }
        }
    }
    override func configureView() {
        
        configureRadius()
        profileImageView.backgroundColor = .lightGray
        profileImageView.contentMode = .scaleAspectFill
        
        labelSettingStackView.axis = .vertical
        labelSettingStackView.distribution = .equalSpacing
        labelSettingStackView.spacing = 0
        
        labelStackView.axis = .vertical
        labelStackView.distribution = .fillEqually
        labelStackView.spacing = 0
        
        for item in 0...labelTag - 1 {
            labelList[item].text = profileOptions[item].rawValue
        }
        
        for item in 0...labelSettingTag - 1 {
            labelSettingList[item].text = profileOptions[item].rawValue
        }
    }
    
    func configureLabel() {
        labelTag = 0
        for list in labelList {
            list.tag = labelTag
            labelTag = labelTag + 1
        }
    }
    
    func configureTextField() {
        labelSettingTag = 0
        for list in labelSettingList {
            list.tag = labelSettingTag
            labelSettingTag = labelSettingTag + 1
        }
    }
    
    func configureRadius() {
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
            self.profileImageView.clipsToBounds = true
        }
    }
}
