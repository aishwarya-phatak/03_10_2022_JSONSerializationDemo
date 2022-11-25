//
//  ViewController.swift
//  03_10_2022_JSONSerializationDemo
//
//  Created by Vishal Jagtap on 17/11/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableViewToDisplayPosts: UITableView!
    var posts = [Post]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDataAndDelegate()
        registerNib()
        fetchingDataFromAPI()
    }
    
    func initDataAndDelegate(){
        tableViewToDisplayPosts.dataSource = self
        tableViewToDisplayPosts.delegate = self
    }
    
    func registerNib(){
        let uiNib = UINib(nibName: "PostTableViewCell", bundle: nil)
        self.tableViewToDisplayPosts.register(uiNib, forCellReuseIdentifier: "PostTableViewCell")
    }
    
    func fetchingDataFromAPI(){
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        let url = URL(string: urlString)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        var session = URLSession(configuration: .default)
        
        var dataTask = session.dataTask(with: request) { data, response, error in
            print("Data\(data)")
            print("Response\(response)")
            
            var getJSONObject = try! JSONSerialization.jsonObject(with: data!) as! [[String:Any]]
            
           /* guard let data = data else {
                print("Data Not Found")
                print("Error\(error)")
                return
            }
        */
            for dictionary in getJSONObject{
                let eachDictionary = dictionary as [String:Any]
                let pId = eachDictionary["id"] as! Int
                let pTitle = eachDictionary["title"] as! String
                let pBody = eachDictionary["body"] as! String
                
                var newPost = Post(id: pId, title: pTitle, body: pBody)
                self.posts.append(newPost)
            }
        
            DispatchQueue.main.async {
                self.tableViewToDisplayPosts.reloadData()
            }
        }
        dataTask.resume()
    }
}

extension ViewController : UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var postTableViewCell = self.tableViewToDisplayPosts.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        
        postTableViewCell.postIdLabel.text = String(posts[indexPath.row].id)
        postTableViewCell.postTitleLabel.text = posts[indexPath.row].title
        postTableViewCell.postBodyLabel.text = posts[indexPath.row].body
            return postTableViewCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableViewToDisplayPosts.beginUpdates()
            posts.remove(at: indexPath.row)
            tableViewToDisplayPosts.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            print(posts.count)
            tableViewToDisplayPosts.endUpdates()
        }
    }
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
