//
//  HomeViewController.swift
//  friendListDemo
//
//  Created by Techify on 17/12/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeTabBar: UITabBar!
    @IBOutlet weak var logoutBtn: UIButton!
    @IBOutlet weak var lbeHeader: UILabel!
    @IBOutlet weak var listTable: UITableView!
    
    let homeRepo = HomeRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.homeTabBar.selectedItem = self.homeTabBar.items?.first ?? UITabBarItem()
        
        self.listTable.register(UINib(nibName: "FriendTemplateViewCell", bundle: nil), forCellReuseIdentifier: "FriendTemplateViewCell")
        
        self.homeRepo.fetchRandomUserList {
            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                self.listTable.reloadData()
            }) 
        }
        self.homeRepo.fetchUserFriendList()
    }
    
    @IBAction func logoutBtnAction(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}


// List Table related :

extension HomeViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeRepo.randomeUserResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.listTable.dequeueReusableCell(withIdentifier: "FriendTemplateViewCell", for: indexPath) as! FriendTemplateViewCell
        
        if !self.homeRepo.isLoading {
            let info = self.homeRepo.randomeUserResult[indexPath.row]
            cell.lbeFriendName.text = "\(info.name.title ?? "") \(info.name.first ?? "") \(info.name.last ?? "")"
            cell.lbeFriendEmail.text = info.email ?? ""
            
            cell.addFavCompletion = {
                self.homeRepo.addToFavoriteList(friend: info)
            }
        }
        return cell
    }
    
}

// normal Tabbar manager :

extension HomeViewController : UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item.tag)
    }
}
