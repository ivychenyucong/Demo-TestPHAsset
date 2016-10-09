//
//  ViewController.swift
//  TestPHPhotoKit
//
//  Created by ivy on 16/10/8.
//  Copyright © 2016年 ivy. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    //所有的照片
    var allPhotos: PHFetchResult<PHAsset>!
    //系统相簿
    var smartAlbums: PHFetchResult<PHAssetCollection>!
    //用户创建的相簿
    var userCollections: PHFetchResult<PHCollection>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formAssetImage()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /// 从asset里面拿出图片
    func formAssetImage(){
        let manager = PHImageManager.default()
        
        //
        formPHAsset()
        
        //拿出一张照片来瞅瞅
        let options = PHImageRequestOptions()

        manager.requestImage(for: allPhotos.object(at: 0), targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: options) { (image, hashable ) in
            
            //别多此一举加,要报错的,这是异步运行的,回调会回到主线程
            //DispatchQueue.main.sync {
                 self.imageView.image = image
            //}
           
        }
    }
    
    
    /// 从相册中拿全部照片,全部系统相簿,全部用户相簿
    func formPHAsset(){
        let fetchOptions = PHFetchOptions()
        // fetchOptions.predicate = NSPredicate(format:"NAME=ivy", argumentArray:nil)
        
        //fetchOptions.sortDescriptors = [NSSortDescriptor(key:"creationDate", ascending: true)]
        
        allPhotos =  (PHAsset.fetchAssets( with: fetchOptions))
        print("共有\(allPhotos.count)张照片")
        
        smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
        userCollections = PHCollectionList.fetchTopLevelUserCollections(with: nil)

    }

}

