//
//  GlobalFunction.swift
//  friendListDemo
//
//  Created by Techify on 17/12/24.
//

import Foundation
import UIKit


class GlobalFunction {
    
    static let shared = GlobalFunction()
    
    func saveUserDetails(userModel: UserModel){
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(userModel)
            UserDefaults.standard.set(data, forKey: "userModel")
            print("UserModel saved successfully.")
        } catch {
            print("Failed to encode UserModel: \(error)")
        }
    }
    
    func fetchUserModel() -> UserModel? {
        if let data = UserDefaults.standard.data(forKey: "userModel") {
            let decoder = JSONDecoder()
            do {
                let userModel = try decoder.decode(UserModel.self, from: data)
                return userModel
            } catch {
                print("Failed to decode UserModel: \(error)")
                return nil
            }
        }
        return nil
    }
    
}


extension UIViewController {
    
    func showAlert(message: String) {
        
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        // Present the alert
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension UIView {
    
    
    func applyCornerRadius(to corners: UIRectCorner, with radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        self.layer.mask = shape
    }
}
