//
//  ViewController.swift
//  MyHood
//
//  Created by Mehmet Eroğlu on 12.04.2017.
//  Copyright © 2017 Mehmet Eroğlu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var mainTableView: MainTableView!
    
   // var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.viewController = self
        DataService.instance.loadPosts()
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.onPostsLoaded(notif:)), name: Notification.Name("postsLoaded"), object: nil)
    }

    func onPostsLoaded(notif: AnyObject){
        mainTableView.tableView.reloadData()
    }
}

