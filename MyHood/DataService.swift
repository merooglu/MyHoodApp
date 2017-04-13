//
//  DataService.swift
//  MyHood
//
//  Created by Mehmet Eroğlu on 12.04.2017.
//  Copyright © 2017 Mehmet Eroğlu. All rights reserved.
//

import Foundation
import UIKit

class DataService {
    static let instance = DataService()
    
    let KEY_POSTS = "posts"
    private var _loadedPosts = [Post]()
    
    var loadedPosts : [Post] {
        return _loadedPosts
    }
    
    func savePosts(){
        let postsData = NSKeyedArchiver.archivedData(withRootObject: _loadedPosts)
        UserDefaults.standard.set(postsData, forKey: KEY_POSTS)
        UserDefaults.standard.synchronize()
    }
    
    func loadPosts() {
        if let postsData = UserDefaults.standard.object(forKey: KEY_POSTS) as? Data {
            if let postsArray = NSKeyedUnarchiver.unarchiveObject(with: postsData) as? [Post] {
                _loadedPosts = postsArray
            }
        }
        
        NotificationCenter.default.post(NSNotification(name: NSNotification.Name(rawValue: "postsLoaded"), object: nil) as Notification )
    }
    
    func saveImageAndCreatePath(image: UIImage) -> String{
        let imgData = UIImagePNGRepresentation(image)
        let imgPath = "image\(NSDate.timeIntervalSinceReferenceDate).png"
        let fullPath = documentPathForFileName(name: imgPath)
        try? imgData?.write(to: URL(fileURLWithPath: fullPath), options: [.atomic])
        return imgPath
    }
    
    func imageForPath(path : String) -> UIImage? {
        let fullPath = documentPathForFileName(name: path)
        let image = UIImage(named: fullPath)
        return image
    }
    
    func addPost(post: Post){
        _loadedPosts.append(post)
        savePosts()
        loadPosts()
    }
    
    func documentPathForFileName(name: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let fullPath = paths[0] as NSString
        return fullPath.appendingPathComponent(name)
    
    }
    
}
