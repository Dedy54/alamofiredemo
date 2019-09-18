//
//  RegisterViewController.swift
//  Alamofire Demo
//
//  Created by Dedy Yuristiawan on 18/09/19.
//  Copyright © 2019 Parallax Spaces. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func actionButton(_ sender: Any) {
        print("actionButton click")
        if (emailTextField.text == nil || emailTextField.text == "" || passwordTextField.text == nil || passwordTextField.text == "" ){
            let alert = UIAlertController(title: "Hey", message: "Field mandatory", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) -> Void in
                
            }))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        let alert = UIAlertController(title: "Success", message: "Set isUserLogin True", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Back to Main", style: .cancel, handler: { (action) -> Void in
            PreferenceManager.instance.isUserLogin = true
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Register"
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
