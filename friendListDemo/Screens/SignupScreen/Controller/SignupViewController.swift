//
//  ViewController.swift
//  friendListDemo
//
//  Created by Techify on 17/12/24.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var txtPasswordField: UITextField!
    @IBOutlet weak var txtEmailField: UITextField!
    @IBOutlet weak var txtLastNameField: UITextField!
    @IBOutlet weak var txtFirstNameField: UITextField!
    @IBOutlet weak var containerView: UIView!
    
    let singupRepo = SignupRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.containerView.applyCornerRadius(to: [.topLeft , .topRight ], with: 24)
        }
    }

    @IBAction func loginBtnAction(_ sender: UIButton) {
        self.moveToLoginScreen()
    }
    
    @IBAction func signUpBtnAction(_ sender: UIButton) {
        
        if validateFields() {
            let userModel = UserModel(
                firstName: txtFirstNameField.text ?? "",
                LastName: txtLastNameField.text ?? "",
                email: txtEmailField.text ?? "",
                password: txtPasswordField.text ?? ""
            )
            self.singupRepo.addUser(user: userModel) { isSuccess,message in
                if isSuccess {
                    self.moveToLoginScreen()
                    GlobalFunction.shared.showToast(message: message)
                }else{
                    self.showAlert(message: message)
                }
            }
        }
        
    }
    
    func moveToLoginScreen() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
 
    
    func validateFields() -> Bool {
            
        if let firstName = self.txtFirstNameField.text, firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showAlert(message: "Please enter your first name.")
            return false
        }
        
        if let lastName = self.txtLastNameField.text, lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showAlert(message: "Please enter your last name.")
            return false
        }
        
        if let email = self.txtEmailField.text, email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showAlert(message: "Please enter your email.")
            return false
        }
        
        if let password = self.txtPasswordField.text, password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            showAlert(message: "Please enter your password.")
            return false
        }
        
        return true
    }
}

