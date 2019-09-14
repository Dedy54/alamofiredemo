//
//  AddPostViewController.swift
//  Example Test
//
//  Created by Dedy Yuristiawan on 13/09/19.
//  Copyright © 2019 Parallax Spaces. All rights reserved.
//

import UIKit
import ProgressHUD
import Alamofire
import ObjectMapper

protocol AddPostViewControllerDelegate {
    func reloadPlease(reloadPlease bool: Bool)
}

class AddPostViewController: UIViewController {

    var isEdit = false
    var name : Name?
    var addPostViewControllerDelegate: AddPostViewControllerDelegate?
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var secondButton: UIButton!{
        didSet{
            self.secondButton.isHidden = true
        }
    }
    
    @IBAction func secondActionButton(_ sender: Any) {
        self.deleteContent(id: self.name?.id ?? 0)
    }
    
    @IBAction func actionButton(_ sender: Any) {
        print("actionButton click")
        if isEdit {
            self.updateContent(id: self.name?.id ?? 0)
        } else {
            self.addContent()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create Todo"
        
        if (isEdit == true){
            self.title = "Edit Todo"
            self.button.setTitle("Update", for: .normal)
            self.secondButton.isHidden = false
        }
        
        self.bindView()
    }
    
    func bindView() {
        self.titleTextField.text = self.name?.name
    }
    
    func addContent() {
        if (titleTextField.text == nil || titleTextField.text == "" ){
            let alert = UIAlertController(title: "Hey", message: "Name mandatory", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) -> Void in
                
            }))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        ProgressHUD.show()
        let parameters : [String : Any] = [
            "name": titleTextField.text ?? ""
        ]
        
        let URL = "https://5bloh8cd4j.execute-api.ap-southeast-1.amazonaws.com/dev/v1/inbistro/create"
        Alamofire.request(URL, method: .post, parameters: parameters) .responseJSON { response in
            ProgressHUD.dismiss()
            switch response.result {
            case .failure(let error) :
                print(error.localizedDescription)
                break
            case .success(let data):
                print("success \(data)")
                if let responseNames = Mapper<ResponseName>().map(JSONObject: data){
                    if (responseNames.errorResponse?.code == 200){
                        let alert = UIAlertController(title: "Add Content", message: "Success", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Back to Main", style: .cancel, handler: { (action) -> Void in
                            self.addPostViewControllerDelegate?.reloadPlease(reloadPlease: true)
                            self.navigationController?.popViewController(animated: true)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        let alert = UIAlertController(title: "Add Content", message: "Failed", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) -> Void in
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                break
            }
        }
    }
    
    func updateContent(id: Int) {
        if (titleTextField.text == nil || titleTextField.text == "" ){
            return
        }
        
        ProgressHUD.show()
        let parameters : [String : Any] = [
            "name": titleTextField.text ?? "",
            "id": id
        ]
        
        let URL = "https://5bloh8cd4j.execute-api.ap-southeast-1.amazonaws.com/dev/v1/inbistro/update"
        Alamofire.request(URL, method: .post, parameters: parameters) .responseJSON { response in
            ProgressHUD.dismiss()
            switch response.result {
            case .failure(let error) :
                print(error.localizedDescription)
                break
            case .success(let data):
                print("success \(data)")
                if let responseNames = Mapper<ResponseName>().map(JSONObject: data){
                    if (responseNames.errorResponse?.code == 200){
                        let alert = UIAlertController(title: "Update Content", message: "Success", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Back to Main", style: .cancel, handler: { (action) -> Void in
                            self.addPostViewControllerDelegate?.reloadPlease(reloadPlease: true)
                            self.navigationController?.popViewController(animated: true)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        let alert = UIAlertController(title: "Update Content", message: "Failed", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) -> Void in
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                break
            }
        }
    }
    
    func deleteContent(id: Int) {
        ProgressHUD.show()
        let parameters : [String : Any] = [
            "id": id
        ]
        
        let URL = "https://5bloh8cd4j.execute-api.ap-southeast-1.amazonaws.com/dev/v1/inbistro/delete"
        Alamofire.request(URL, method: .post, parameters: parameters) .responseJSON { response in
            ProgressHUD.dismiss()
            switch response.result {
            case .failure(let error) :
                print(error.localizedDescription)
                break
            case .success(let data):
                print("success \(data)")
                if let responseNames = Mapper<ResponseName>().map(JSONObject: data){
                    if (responseNames.errorResponse?.code == 200){
                        let alert = UIAlertController(title: "Delete Content", message: "Success", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Back to Main", style: .cancel, handler: { (action) -> Void in
                            self.addPostViewControllerDelegate?.reloadPlease(reloadPlease: true)
                            self.navigationController?.popViewController(animated: true)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        let alert = UIAlertController(title: "Delete Content", message: "Failed", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) -> Void in
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                break
            }
        }
        
    }
    
}
