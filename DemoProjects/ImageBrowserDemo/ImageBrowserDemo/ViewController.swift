//
//  ViewController.swift
//  ImageBrowserDemo
//
//  Created by rayor on 2022/1/26.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: 展示代理信息
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datasource.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.mainView.dequeueReusableCell(withReuseIdentifier:"RImageCell", for: indexPath) as! RImageCell
        cell.urlString = self.datasource[indexPath.row] as? String
        cell.backgroundColor = UIColor.randomColor
        return cell
    }

    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let indexes = self.mainView.indexPathsForVisibleItems
//        for indexPath in indexes {
//            let cell = self.mainView.cellForItem(at: indexPath) as! RImageCell
//            let urlString = self.datasource[indexPath.row] as? String
//            cell.urlString = urlString
//        }
//    }
    

    @IBOutlet weak var mainView: UICollectionView!
    
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    var datasource:NSArray {
        get {
            guard let path = Bundle.main.url(forResource: "ImageUrls", withExtension: "plist") else {return []}
            
            guard let data = try? PropertyListSerialization.propertyList(from: Data.init(contentsOf: path), options: [], format: nil) else {
                return []
            }
            
            return data as! NSArray
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createSubView()
    }
    
    func createSubView() {
        self.mainView.delegate = self
        self.mainView.dataSource = self
        
        let width = (UIScreen.main.bounds.size.width - 41 - 2*10) / 3
        self.layout.itemSize = CGSize.init(width: width, height: 180)
        self.layout.invalidateLayout()
        
    }

}



class RImageCell : UICollectionViewCell {
    
    @IBOutlet weak var imagePicView: UIImageView!
    
    private var _urlString : String?
    var urlString: String? {
        set {
            _urlString = newValue
            print("日志信息:%s",newValue)
            self.updateImage()
        }
        get {
            return _urlString
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createSubView()
    }
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.createSubView()
    }
    
    
    func createSubView() {
        print("显示日志信息");
    }
    

    func updateImage() {
        // 需要搞一个队列，当停止时开始加载数据
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let imageUrl = self.urlString else {
                return
            }
            
            guard let data = try? Data.init(contentsOf: URL.init(string: imageUrl)!) else {
                return
            }
            let image = UIImage.init(data: data)
            
            DispatchQueue.main.async {
                self.imagePicView.image = image
            }
        }
        
    }
    
    // TODO: 需要构建一个对象，将数据进行封存，每次加载时先判断是否已经存在，存在则不用重复下载，降低内存损耗
    
    /*
     1. 构建一个线程管理器，防止同一个地址请求多次
     2. 获取到数据后需要将信息进行缓存，优先读取缓存
     3. 限定最大并发线程数量，当数量超出时，清理未完成线程
     4. 线程执行结束后，及时收回处理
     */
    
    
}



extension UIColor {
    class var randomColor: UIColor {
        get {
            let red = CGFloat(arc4random() % 255) / 255.0
            let green = CGFloat(arc4random() % 255) / 255.0
            let blue = CGFloat(arc4random() % 255) / 255.0
            
            return UIColor.init(red: red, green: green, blue: blue, alpha: 1)
        }
    }
}
