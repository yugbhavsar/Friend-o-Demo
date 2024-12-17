//
//  LoginViewController.swift
//  friendListDemo
//
//  Created by Techify on 17/12/24.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtPasswordField: UITextField!
    @IBOutlet weak var txtEmailField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    let loginRepo = LoginRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.containerView.applyCornerRadius(to: [.topLeft , .topRight ], with: 24)
    }
    
    @IBAction func signupBtnAction(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginBtnAction(_ sender: Any) {
        
        if validateFields() {
            var userModel = UserModel(
                firstName: "",
                LastName: "",
                email: txtEmailField.text ?? "",
                password: txtPasswordField.text ?? ""
            )
            self.loginRepo.loginUser(userModel: userModel) { isSuccess, message in
                if isSuccess{
                    
                    guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else {
                        return
                    }
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    self.showAlert(message: message)
                }
            }
        }
        
    }
    
    func validateFields() -> Bool {
        
        if let email = self.txtEmailField.text, email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showAlert(message: "Please enter your email.")
            return false
        }
        
        if let password = self.txtPasswordField.text, password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showAlert(message: "Please enter your password.")
            return false
        }
        
        return true // All fields are valid
    }
    
}
