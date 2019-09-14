//
//  ViewController.swift
//  Alamofire Demo
//
//  Created by Dedy Yuristiawan on 15/09/19.
//  Copyright © 2019 Parallax Spaces. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import ProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var names: [Name] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Test Api"
        createRightButton()
        tableView.delegate = self
        tableView.dataSource = self
        loadContent()
    }
    
    @objc func addNewToDo() {
        let storyboard = UIStoryboard(name: "AddPost", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "AddPostViewController") as! AddPostViewController
        secondViewController.addPostViewControllerDelegate = self
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func createRightButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .done, target: self, action: #selector(addNewToDo))
    }
    
    func loadContent() {
        ProgressHUD.show()
        let URL = "https://5bloh8cd4j.execute-api.ap-southeast-1.amazonaws.com/dev/v1/inbistro/read"
        Alamofire.request(URL, method: .post) .responseJSON { response in
            ProgressHUD.dismiss()
            switch response.result {
            case .failure(let error) :
                print(error.localizedDescription)
                break
            case .success(let data):
                print("success")
                if let responseNames = Mapper<ResponseNames>().map(JSONObject: data){
                    if (responseNames.errorResponse?.code == 200){
                        self.names.removeAll()
                        self.names = responseNames.names
                    }
                }
                print("modelObject : \(self.names.count)")
                self.tableView.reloadData()

                break
            }
        }
        
//        ProgressHUD.show()
//        APIService.getNoteList(onSuccess: { (modelObjects) in
//            ProgressHUD.dismiss()
//            self.modelObjects.removeAll()
//            self.modelObjects = modelObjects
//            self.tableView.reloadData()
//        }) { (error) in
//            print(error?.message ?? "")
//        }
        
    }
    
}

extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "AddPost", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "AddPostViewController") as! AddPostViewController
        secondViewController.name = self.names[indexPath.row]
        secondViewController.isEdit = true
        secondViewController.addPostViewControllerDelegate = self
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.names.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.names[indexPath.row].name
        return cell
    }
    
}

extension ViewController: AddPostViewControllerDelegate {
    
    func reloadPlease(reloadPlease bool: Bool) {
        if bool {
            self.loadContent()
        }
    }
    
}
