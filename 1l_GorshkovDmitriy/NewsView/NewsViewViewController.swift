//
//  NewsViewViewController.swift
//  1l_GorshkovDmitriy
//
//  Created by Дмитрий Горшков on 16.04.2020.
//  Copyright © 2020 Дмитрий Горшков. All rights reserved.
//

import UIKit

class NewsViewViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

}
