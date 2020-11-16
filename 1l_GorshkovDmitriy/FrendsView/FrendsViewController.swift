//
//  FrendsViewController.swift
//  1l_GorshkovDmitriy
//
//  Created by Дмитрий Горшков on 02.04.2020.
//  Copyright © 2020 Дмитрий Горшков. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

// НАЧАЛО - структура для загрузки данных с VK.COM
struct InfoFriend: Decodable{
    let id: Int
    let name: String
    let surname: String
    let photo: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "first_name"
        case surname = "last_name"
        case photo = "photo_100"
    }
}

struct ResponseFriend: Decodable {
    let count: Int
    let items: [InfoFriend]
}

struct DateFriend: Decodable {
    let response: ResponseFriend
    
}
// КОНЕЦ - структура для загрузки данных с VK.COM

class FrendsViewController: UITableViewController {
    
    var sectionFriend : [SectionFriend] = []
    var searhResult: [SectionFriend] = []
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        
        
        loadFriendsData(){ [weak self] datafriends in
            
            //print("ТЕСТ = ",datafriends)
            var friends: [Friend] = []
            var friendsTemp: [Friend] = []
            var temp: [Friend] = []
            
            
            var temp_: Friend = Friend(id: 0, title: "", avatar: UIImage(named: "iconVK"), photos:[UIImage(named: "iconVK")])
            
            var image: UIImage?
            
            for i in 0...datafriends.count-1{
                temp_.id = datafriends[i].id
                temp_.title = datafriends[i].name + " " + datafriends[i].surname
                //print(temp.title)
                
                let urlString = datafriends[i].photo
                let url = NSURL(string: urlString)! as URL
                if let imageData: NSData = NSData(contentsOf: url) {
                    image = UIImage(data: imageData as Data)
                }
                temp_.avatar = image
                friends.append(temp_)
                
            }
            
            //из структуры friends - создаем массив неповторяющихся сортированных по алфавиту первых букв имени
            let sectionTitle = Array(Set(friends.compactMap { $0.title.prefix(1) } )).sorted()
            
            friendsTemp = friends
            
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
                self?.sectionFriend.append(sectionFriendtemp)
                temp = []
            }
            self?.tableView.reloadData()
        }
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
            // return friends_.count
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
            //cell.friendAvatarImageView.af_setImage(withURL: <#T##URL#>)
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
    
    
    
    
    //НАЧАЛО - загрузка списка друзей с VK.COM
    func loadFriendsData(completion: @escaping ([InfoFriend]) -> Void ){
        //https://api.vk.com/method/METHOD_NAME?PARAMETERS&access_token=ACCESS_TOKEN&v=V
        //получение списка друзей
        let paramters: Parameters = [
            "fields": "photo_100",
            "access_token": Session.instance.token,
            "v": "5.124"
        ]
        
        AF.request("https://api.vk.com/method/friends.get", parameters: paramters).responseData { response in
            
            do {
                let friends = try JSONDecoder().decode(DateFriend.self, from: response.value!)
                completion(friends.response.items)

            } catch {
                print(error)
            }
        }
    }
    //КОНЕЦ - загрузка списка друзей с VK.COM
    
    
    
    
    
    
    
    
    
}



