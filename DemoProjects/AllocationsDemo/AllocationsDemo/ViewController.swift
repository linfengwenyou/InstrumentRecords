//
//  ViewController.swift
//  AllocationsDemo
//
//  Created by rayor on 2022/1/27.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        let controller = RayTestController()
        
        navigationController?.pushViewController(controller, animated: true)
    }

}
