//
//  SecondViewController.swift
//  03_10_2022_JSONSerializationDemo
//
//  Created by Vishal Jagtap on 21/11/22.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var tableViewToDisplayPosts: UITableView!
    var posts : [Post] = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJSONData {
            self.tableViewToDisplayPosts.reloadData()
        }
    }
    
    func downloadJSONData(completed : @escaping() -> ()){
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        guard let url = URL(string: urlString) else {
            print("Url not created")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if(error == nil){
                do{
                    var jsonDecoder = JSONDecoder()
                    self.posts = try! jsonDecoder.decode([Post].self, from: data!)
                }catch{
                    print("Error")
                }
                
                DispatchQueue.main.async {
                    completed()
                }
            }
        }.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
