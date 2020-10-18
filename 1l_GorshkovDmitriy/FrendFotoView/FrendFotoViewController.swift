//
//  FrendFotoViewController.swift
//  1l_GorshkovDmitriy
//
//  Created by Дмитрий Горшков on 02.04.2020.
//  Copyright © 2020 Дмитрий Горшков. All rights reserved.
//

import UIKit

class FrendFotoViewController: UICollectionViewController {

    var friend: Friend!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        //print (frend.photos.count)
        return friend.photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrendFotoViewCell", for: indexPath) as! FrendFotoViewCell
        let photo = friend.photos[indexPath.row]
        cell.photo.image = photo
        cell.buttonLike.setImage(UIImage(named: "heart_1"), for: .normal)
        cell.buttonLike.setImage(UIImage(named: "heart_2"), for: .selected)
        let numberOfLikes: Int = 0;
        cell.lableLike.text = String(numberOfLikes)
        return cell
    }


}
