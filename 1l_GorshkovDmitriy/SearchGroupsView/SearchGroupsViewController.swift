//
//  SearchGroupsViewController.swift
//  1l_GorshkovDmitriy
//
//  Created by Дмитрий Горшков on 02.04.2020.
//  Copyright © 2020 Дмитрий Горшков. All rights reserved.
//

import UIKit
import Alamofire

class SearchGroupsViewController: UITableViewController {
   

    
    var allGroups: [Group] = [
        Group(title: "Фильмы", avatar: UIImage(named: "iconVK")),
        Group(title: "Музыка", avatar: UIImage(named: "iconVK")),
        Group(title: "Игры", avatar: UIImage(named: "iconVK")),
        Group(title: "Рукоделие", avatar: UIImage(named: "iconVK")),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        allGroups.append(group1)
//        allGroups.append(group2)
//        allGroups.append(group3)
//        allGroups.append(group4)
        
        //https://api.vk.com/method/METHOD_NAME?PARAMETERS&access_token=ACCESS_TOKEN&v=V
        //поиск по группам
        let paramters: Parameters = [
            "q": "франсавто",
            "access_token": Session.instance.token,
            "v": "5.54"
        ]

        AF.request("https://api.vk.com/method/groups.search", parameters: paramters).responseJSON { response in
        
        print(response.value) }
        
        
    }


    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroups.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchGroupsViewCell", for: indexPath) as! SearchGroupsViewCell
        cell.groupAvatar.image = allGroups[indexPath.row].avatar
        cell.groupName.text = allGroups[indexPath.row].title
        return cell
    }
}
