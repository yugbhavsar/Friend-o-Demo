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
        self.homeRepo.delegate = self
        self.listTable.register(UINib(nibName: "FriendTemplateViewCell", bundle: nil), forCellReuseIdentifier: "FriendTemplateViewCell")
        
        self.homeRepo.fetchRandomUserList {
            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                self.listTable.reloadData()
            }) 
        }
        self.homeRepo.fetchUserFriendList()
    }
    
    @IBAction func logoutBtnAction(_ sender: Any) {
        GlobalFunction.shared.removeUserModel()
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}


// List Table related :

extension HomeViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeRepo.selectedTab == 0 ? self.homeRepo.randomeUserResult.count:self.homeRepo.favoirteUserResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.listTable.dequeueReusableCell(withIdentifier: "FriendTemplateViewCell", for: indexPath) as! FriendTemplateViewCell
        
        if !self.homeRepo.isLoading {
            let info = self.homeRepo.selectedTab == 0 ? self.homeRepo.randomeUserResult[indexPath.row]:self.homeRepo.favoirteUserResult[indexPath.row]
            cell.lbeFriendName.text = "\(info.name.title ?? "") \(info.name.first ?? "") \(info.name.last ?? "")"
            cell.lbeFriendEmail.text = info.email ?? ""
            
            let favUserIds = self.homeRepo.favoirteUserResult.map({ $0.id.value ?? "" })
            cell.addToFavBtn.isSelected = favUserIds.contains(info.id.value ?? "")
            
            cell.addFavCompletion = {
                if favUserIds.contains(info.id.value ?? ""){
                    let index = favUserIds.firstIndex(where: { $0 == info.id.value ?? ""}) ?? 0
                    self.homeRepo.removeFromFavoriteList(favoriteUser: self.homeRepo.userFavEntityList[index])
                }else{
                    self.homeRepo.addToFavoriteList(friend: info)
                }
            }
        }
        return cell
    }
    
}

extension HomeViewController : FetchFavoriteDelegate {
    
    func didFetchUserFavList() {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute: {
            self.listTable.reloadData()
        })
    }
}

// normal Tabbar manager :

extension HomeViewController : UITabBarDelegate {
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        self.homeRepo.selectedTab = item.tag
        DispatchQueue.main.async {
            self.lbeHeader.text = self.homeRepo.selectedTab == 0 ? "User List":"Favorite List"
            self.listTable.reloadData()
        }
    }
}
