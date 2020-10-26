//
//  FrendsViewController.swift
//  1l_GorshkovDmitriy
//
//  Created by Дмитрий Горшков on 02.04.2020.
//  Copyright © 2020 Дмитрий Горшков. All rights reserved.
//

import UIKit
import Alamofire

class FrendsViewController: UITableViewController {
    
    //получение списка друзей
   
    /* https://api.vk.com/method/friends.get?access_token=5716cbc86e6bc378b43620ef988b7b97fd4ab988353c892acc40b3e7d7e94dabb3dbb62b275a1c91f1af2&v=5.124
    
*/
    
    // используем Alamofire для запроса к серверу, сразу передаем строку с URL и вызываем метод
    // responseJSON, передавая ему замыкание.
   
    
    
    
    let friends: [Friend] = [
        Friend(title: "Яблочкин Алексей", avatar: UIImage(named: "iconVK"), photos: [
            UIImage(named: "iconVK")
        ]),
        Friend(title: "Иванов Иван", avatar: UIImage(named: "iconVK"), photos: [
            UIImage(named: "iconVK"),
            UIImage(named: "iconVK")
        ]),
        Friend(title: "Борисов Василий", avatar: UIImage(named: "iconVK"), photos: [
            UIImage(named: "iconVK"),
            UIImage(named: "iconVK"),
            UIImage(named: "iconVK")
        ]),
        Friend(title: "Петров Петр", avatar: UIImage(named: "iconVK"), photos: [
            UIImage(named: "iconVK"),
            UIImage(named: "iconVK"),
            UIImage(named: "iconVK"),
            UIImage(named: "iconVK"),
        ]),
        Friend(title: "Сидоров Евгений", avatar: UIImage(named: "iconVK"), photos: [
            UIImage(named: "iconVK"),
            UIImage(named: "iconVK"),
            UIImage(named: "iconVK"),
            UIImage(named: "iconVK"),
            UIImage(named: "iconVK")
        ]),
        Friend(title: "Александров Сергей", avatar: UIImage(named: "iconVK"), photos: [
            UIImage(named: "iconVK"),
            UIImage(named: "iconVK"),
            UIImage(named: "iconVK"),
            UIImage(named: "iconVK"),
            UIImage(named: "iconVK"),
            UIImage(named: "iconVK")
        ]),
        Friend(title: "Алексеев Роман", avatar: UIImage(named: "iconVK"), photos: [
            UIImage(named: "iconVK"),
            UIImage(named: "iconVK"),
            UIImage(named: "iconVK"),
            UIImage(named: "iconVK"),
            UIImage(named: "iconVK"),
            UIImage(named: "iconVK"),
            UIImage(named: "iconVK")
        ])
    ]
    
    var sectionFriend : [SectionFriend] = []
    var searhResult: [SectionFriend] = []
    
    var friendsTemp: [Friend] = []
    var temp: [Friend] = []
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //https://api.vk.com/method/METHOD_NAME?PARAMETERS&access_token=ACCESS_TOKEN&v=V
        //получение списка друзей
        let paramters: Parameters = [
                    "access_token": Session.instance.token,
                    "v": "5.124"
                ]

        AF.request("https://api.vk.com/method/friends.get", parameters: paramters).responseJSON { response in
        
        print(response.value) }
        
        
        
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        
        //из структуры friends - создаем массив неповторяющихся сортированных по алфавиту первых букв имени
        let sectionTitle = Array(Set(friends.compactMap { $0.title.prefix(1) } )).sorted()
        //print(sectionTitle)
        
        friendsTemp = friends
        
        //проверка колличества секций в sectionTitle
        //print(sectionTitle.count)
        
        //проходим по всей структуре friendsTemp и вытаскиваем всех пользователей в алфавитном паорядке в новую структуру sectionFriend
        for j in 0...sectionTitle.count - 1
        {
            for i in 0...friendsTemp.count - 1
            {
                if (sectionTitle[j] == friendsTemp[i].title.prefix(1) && friendsTemp[i].title != "0")
                {
                    temp.append(friendsTemp[i])
                    friendsTemp[i].title = "0"
                }
            }
            
            let sectionFriendtemp = SectionFriend(sectionName: String(sectionTitle[j]), frendStruct: temp)
            sectionFriend.append(sectionFriendtemp)
            temp = []
        }
        
        //вывод на печать в консоль получившейся струруктуры для проверки
        //        for z in 0...sectionFriend.count - 1
        //        {
        //            print("секция: \(sectionFriend[z].sectionName)")
        //            for u in 0...sectionFriend[z].frendStruct.count - 1{
        //                print(sectionFriend[z].frendStruct[u].title)
        //            }
        //        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if(searchController.isActive){
            return searhResult.count
        }else{
            return sectionFriend.count
        }
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(searchController.isActive){
            return searhResult[section].sectionName
        }else{
            return sectionFriend[section].sectionName
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchController.isActive){
            return searhResult[section].frendStruct.count
        }else{
            return sectionFriend[section].frendStruct.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FrendsViewCell", for: indexPath) as! FrendsViewCell
        
        if(searchController.isActive){
            cell.friendName.text = searhResult[indexPath.section].frendStruct[indexPath.row].title
            cell.friendAvatarImageView.image = searhResult[indexPath.section].frendStruct[indexPath.row].avatar
            //return cell
        }else{
            cell.friendName.text = sectionFriend[indexPath.section].frendStruct[indexPath.row].title
            cell.friendAvatarImageView.image = sectionFriend[indexPath.section].frendStruct[indexPath.row].avatar
            //return cell
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let frendFotoViewController = segue.destination as? FrendFotoViewController { //проверка перехода на нужный контроллер
            if let indexPath = tableView.indexPathForSelectedRow {
                let friend = sectionFriend[indexPath.section].frendStruct[indexPath.row]
                frendFotoViewController.friend = friend
            }
        }
    }
}

// реализация поиска
extension FrendsViewController: UISearchResultsUpdating  {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText2 = searchController.searchBar.text {
            filterContent(searchText: searchText2)
            tableView.reloadData()
        }
    }
    
    func filterContent(searchText: String) {
        var frendStructTemp: [Friend] = []
        searhResult = []
        
        //вывод в консоль текст введеный в serchBar
        //print("текст который имем \(searchText)")
        for z in 0...sectionFriend.count - 1
        {
            for u in 0...sectionFriend[z].frendStruct.count - 1{
                let str1 = sectionFriend[z].frendStruct[u].title.lowercased()
                let str2 = searchText.lowercased()
                
                if ( str1.contains(str2)  ){
                    frendStructTemp.append(sectionFriend[z].frendStruct[u])
                }
            }
            if !frendStructTemp.isEmpty{
                let sectionFriendtemp = SectionFriend(sectionName: String(sectionFriend[z].sectionName), frendStruct: frendStructTemp)
                searhResult.append(sectionFriendtemp)
                frendStructTemp = []
            }
        }
    }
    
    
    
    
    


}



