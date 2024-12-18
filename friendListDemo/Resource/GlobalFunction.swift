//
//  GlobalFunction.swift
//  friendListDemo
//
//  Created by Techify on 17/12/24.
//

import Foundation
import CryptoKit
import UIKit


class GlobalFunction {
    
    static let shared = GlobalFunction()
    
    private let key: SymmetricKey
    
    init() {
        // getting secrete key from Scheme Argument to procte it
        let secretKey = ProcessInfo.processInfo.environment["secretKey"] ?? ""
        let keyData = Data(secretKey.utf8)
        self.key = SymmetricKey(data: keyData.sha256())
    }

    
    func saveUserDetails(userModel: UserModel){
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(userModel)
            UserDefaults.standard.set(data, forKey: "userModel")
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
    
    func removeUserModel() {
        UserDefaults.standard.removeObject(forKey: "userModel")
    }
    
    func encrypt(plainText: String) -> String? {
        guard let data = plainText.data(using: .utf8) else { return nil }
        do {
            let sealedBox = try AES.GCM.seal(data, using: key)
            return sealedBox.combined?.base64EncodedString()
        } catch {
            print("Encryption failed: \(error)")
            return nil
        }
    }
    
    func decrypt(encryptedText: String) -> String? {
        guard let data = Data(base64Encoded: encryptedText) else { return nil }
        do {
            let sealedBox = try AES.GCM.SealedBox(combined: data)
            let decryptedData = try AES.GCM.open(sealedBox, using: key)
            return String(data: decryptedData, encoding: .utf8)
        } catch {
            print("Decryption failed: \(error)")
            return nil
        }
    }
    
    // direct toast message function to show response messages !!!
    func showToast(message: String, duration: Double = 2.0) {
        guard let window = UIApplication.shared.windows.first else { return }
        
        // Create a toast view
        let toastView = UIView(frame: CGRect())
        toastView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastView.layer.cornerRadius = 10
        toastView.clipsToBounds = true
        
        // Create a label for the message
        let messageLabel = UILabel(frame: CGRect())
        messageLabel.textColor = .white
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        
        // Calculate sizes
        let padding: CGFloat = 16
        let maxWidth = window.frame.width * 0.8
        let textSize = messageLabel.sizeThatFits(CGSize(width: maxWidth - padding * 2, height: CGFloat.greatestFiniteMagnitude))
        let toastWidth = textSize.width + padding * 2
        let toastHeight = textSize.height + padding * 2
        
        // Set frames
        messageLabel.frame = CGRect(x: padding, y: padding, width: textSize.width, height: textSize.height)
        toastView.frame = CGRect(x: (window.frame.width - toastWidth) / 2, y: window.frame.height - toastHeight - 100, width: toastWidth, height: toastHeight)
        
        // Add label to toast view
        toastView.addSubview(messageLabel)
        
        // Add toast view to window
        window.addSubview(toastView)
        
        // Animate the toast
        toastView.alpha = 0.0
        UIView.animate(withDuration: 0.5, animations: {
            toastView.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: duration, options: [], animations: {
                toastView.alpha = 0.0
            }) { _ in
                toastView.removeFromSuperview()
            }
        }
    }
}


extension UIViewController {
    
    func showAlert(message: String) {
        
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
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

extension Data {
    /// SHA-256 hash for symmetric key derivation
    func sha256() -> Data {
        let hash = SHA256.hash(data: self)
        return Data(hash)
    }
}
