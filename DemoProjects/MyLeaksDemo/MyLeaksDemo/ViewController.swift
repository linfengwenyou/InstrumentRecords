//
//  ViewController.swift
//  MyLeaksDemo
//
//  Created by rayor on 2022/1/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "show RedButton", style: .plain, target: self, action: #selector(handleShowRedController))
    }
    
    
    @objc func handleShowRedController() {
        navigationController?.pushViewController(RedViewController(), animated: true);
    }

}

class Service {
    weak var controller:UIViewController?
    
    deinit {
        print("Service 被销毁")
    }
}
#warning("lius 测试")
//MARK: 测试
//TODO: hello

class RedViewController: UIViewController {
    
    deinit {
        print("redViewController 销毁成功")
    }
    
    let service = Service.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        service.controller = self
    }
    
    
}
