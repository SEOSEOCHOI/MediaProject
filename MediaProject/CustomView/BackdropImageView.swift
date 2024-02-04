//
//  DetailView.swift
//  MediaProject
//
//  Created by 최서경 on 1/31/24.
//

import UIKit
import SnapKit

class BackdropView: UIView {
    let backdropImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
         let blurEffectView = UIVisualEffectView(effect: blurEffect)
         return blurEffectView
     }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(backdropImageView)
        self.addSubview(blurEffectView)
        
        
        backdropImageView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        blurEffectView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
