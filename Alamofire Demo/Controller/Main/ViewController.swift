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
        createLeftButton()
        tableView.delegate = self
        tableView.dataSource = self
        loadContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (PreferenceManager.instance.isUserLogin ?? false){
            let alert = UIAlertController(title: "Hey", message: "User registered", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) -> Void in
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func addNewToDo() {
        let storyboard = UIStoryboard(name: "AddPost", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "AddPostViewController") as! AddPostViewController
        secondViewController.addPostViewControllerDelegate = self
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    @objc func addRegister() {
        let storyboard = UIStoryboard(name: "Register", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func createRightButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .done, target: self, action: #selector(addNewToDo))
    }
    
    func createLeftButton() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(addRegister))
    }
    
    func loadContent() {
        ProgressHUD.show()
        APIService.getNames(onSuccess: { (modelObjects) in
            ProgressHUD.dismiss()
            self.names.removeAll()
            self.names = modelObjects
            self.tableView.reloadData()
        }) { (error) in
            print(error?.message ?? "")
        }
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
