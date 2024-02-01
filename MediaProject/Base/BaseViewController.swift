//
//  BaseViewController.swift
//  MediaProject
//
//  Created by 최서경 on 1/31/24.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureHierarchy()
        configureLayout()
    }
    func configureHierarchy() {
        print("Base", #function)
        
    }
    
    func configureLayout() {
        print("Base", #function)
        
    }
    
    func configureView() {
        print("Base", #function)
        
    }
}
