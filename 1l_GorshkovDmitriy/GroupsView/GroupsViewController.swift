//
//  GroupsViewController.swift
//  1l_GorshkovDmitriy
//
//  Created by Дмитрий Горшков on 02.04.2020.
//  Copyright © 2020 Дмитрий Горшков. All rights reserved.
//

import UIKit

class GroupsViewController: UITableViewController {

    var myGroups: [group] = [
    group(title: "Тест", avatar: UIImage(named: "iconVK")),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
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

    
    
    
    
    
    
}
