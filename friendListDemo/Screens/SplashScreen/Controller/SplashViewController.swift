//
//  SplashViewController.swift
//  friendListDemo
//
//  Created by Techify on 18/12/24.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            self.navigationValidation()
        }
    }
    
    // check for already login user
    func navigationValidation() {
        
        if GlobalFunction.shared.fetchUserModel() != nil {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else {
                return
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController else {
                return
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }


}
