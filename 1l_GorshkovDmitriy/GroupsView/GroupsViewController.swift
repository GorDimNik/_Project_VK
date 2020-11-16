//
//  GroupsViewController.swift
//  1l_GorshkovDmitriy
//
//  Created by Дмитрий Горшков on 02.04.2020.
//  Copyright © 2020 Дмитрий Горшков. All rights reserved.
//

import UIKit
import Alamofire


struct InfoGroups: Decodable {
    let id: Int
    let name: String
    let photo_200: String
}


struct DateGroupsResponse: Decodable {
    let count: Int
    let items: [InfoGroups]
}


struct DateGroups: Decodable {
    let response: DateGroupsResponse
    
}


class GroupsViewController: UITableViewController {
    
    var myGroups: [Group] = [
        Group(title: "Тест", avatar: UIImage(named: "iconVK")),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myGroups.removeAll()
        
        loadGrups(){ [weak self] grupsList in
            var temp: Group = Group(title: "", avatar: UIImage(named: "iconVK"))
            var image: UIImage?
            
            for i in 0...grupsList.count-1{
                //print("Имена Групп = ", grupsList[i].name)
                temp.title = grupsList[i].name
                
                let urlString = grupsList[i].photo_200
                let url = NSURL(string: urlString)! as URL
                if let imageData: NSData = NSData(contentsOf: url) {
                    image = UIImage(data: imageData as Data)
                }
                temp.avatar = image
                
                self?.myGroups.append(temp)
                print("Имена Групп = ", self?.myGroups[i])
                
            }
            
            self?.tableView.reloadData()
        }
        //print("", myGroups)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsViewCell", for: indexPath) as! GroupsViewCell
        cell.groupName.text = myGroups[indexPath.row].title
        cell.groupAvatar.image = myGroups[indexPath.row].avatar
        return cell
    }
    
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        
        
        
        if segue.identifier == "addGroup" {
            let searchGroupsViewController = segue.source as! SearchGroupsViewController
            if let indexPath = searchGroupsViewController.tableView.indexPathForSelectedRow {
                let groupT = searchGroupsViewController.allGroups[indexPath.row]
                
                
                if !myGroups.contains(where: { $0.title == groupT.title}){
                    //Я так и не смог сделать проверку на наличие группы с своих группах
                    myGroups.append(groupT)
                }
                tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    //НАЧАЛО - загрузка списка друзей с VK.COM
    func loadGrups(completion: @escaping ([InfoGroups]) -> Void ){
        
        //https://api.vk.com/method/METHOD_NAME?PARAMETERS&access_token=ACCESS_TOKEN&v=V
        //получение списка групп пользователя
        let paramters: Parameters = [
            "user_id": Session.instance.userId,
            "extended": 1,
            "access_token": Session.instance.token,
            "v": "5.124"
        ]
        
        AF.request("https://api.vk.com/method/groups.get", parameters: paramters).responseData { response in
            
            do {
                let groups = try JSONDecoder().decode(DateGroups.self, from: response.value!)
                //print ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
                //print ("1111 === ", friends.response.items)
                //print ("1111 === ", friendfoto.response.items)
                completion(groups.response.items)
                // print("переменная фото = ", friendfoto.response.items)
            } catch {
                print("ОШИБКА = ", error)
            }
            
            print("Полученные данные о групах = ", response.value) }
        
    }
    
    
    
    
}
