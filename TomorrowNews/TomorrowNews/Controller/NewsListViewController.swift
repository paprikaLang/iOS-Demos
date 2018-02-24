//
//  NewsListViewController.swift
//  TomorrowNews
//
//  Created by paprika on 2017/8/22.
//  Copyright © 2017年 paprika. All rights reserved.
//

import UIKit

class NewsListViewController: UITableViewController {

    var parentNav:UINavigationController!
    var id : Int = 0
    var newlist = [Post]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadData()
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name(rawValue: UpdateListNotification), object: nil)
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
    }
    @objc fileprivate func loadData(){
        
        OperationQueue.main.addOperation {
            Post.request(id: self.id) { (posts) in
                
                guard let posts = posts else{
                    return
                }
                self.newlist = posts
                self.tableView.reloadData()
            }
        }
    }
   
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return newlist.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListId", for: indexPath) as! NewsCell
        
        cell.titleLabel.text = newlist[indexPath.row].title
        cell.comment.text = "评论数:" + newlist[indexPath.row].comment_count.description
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let post = newlist[tableView.indexPathForSelectedRow!.row]
        
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "NewsDetail") as! DetailViewController
        
        detailVC.post = post
        
        parentNav.pushViewController(detailVC, animated: true)
        
    }
}












