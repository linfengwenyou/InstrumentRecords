//
//  RayTestController.swift
//  AllocationsDemo
//
//  Created by rayor on 2022/1/27.
//

import Foundation
import UIKit

class RayTestController: UIViewController {
    var imgView = LeakImageView.init(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        imgView.contentMode = .scaleAspectFit
        
        self.view.addSubview(self.imgView)
        
        self.imgView.delegate = self
        
        guard let path = Bundle.main.path(forResource: "3", ofType: "jpeg") else {
            return
        }
        
        self.imgView.image = UIImage.init(contentsOfFile: path)
        // MARK: 不要使用 UIImage(named: <#T##String#>) 会使用缓存，效果不明显
        
    }
    
    
    deinit {
        print("RayTestController 被销毁")
    }
}

class LeakImageView : UIImageView {
    var delegate:UIViewController?
    
    deinit {
        print("LeakImageView 被销毁")
    }
}
