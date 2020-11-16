//
//  FrendFotoViewController.swift
//  1l_GorshkovDmitriy
//
//  Created by Дмитрий Горшков on 02.04.2020.
//  Copyright © 2020 Дмитрий Горшков. All rights reserved.
//

import UIKit
import Alamofire


struct sizeFoto: Decodable{
    let height: Int
    let url: String
    let width: Int
}

struct InfoAlbomFriend: Decodable{
    let album_id: Int
    let date: Int
    let id: Int
    let owner_id: Int
    let has_tags: Bool
    let sizes: [sizeFoto]
}

struct AlbomFriend: Decodable {
    let count: Int
    let items: [InfoAlbomFriend]
}

struct DateAlbomFriend: Decodable {
    let response: AlbomFriend
}


class FrendFotoViewController: UICollectionViewController {

    var friend: Friend!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friend.photos.removeAll()
        //
        print ("ПЕРЕДАННЫЙ ОБЪЕКТ: ", friend!)
        loadFriendsFoto(){ [weak self] friendfoto in
            var image: UIImage?
            
            
            
            for i in 0...friendfoto.count-1 {
                
                
                print("ФОТО",friendfoto[i].sizes[3].url)
                
                let urlString = friendfoto[i].sizes[3].url
                let url = NSURL(string: urlString)! as URL
                if let imageData: NSData = NSData(contentsOf: url) {
                    image = UIImage(data: imageData as Data)
                }
                self?.friend.photos.append(image)
                //print("1111111 = ")
                
            }
            //self?.tableView.reloadData()
            self?.collectionView.reloadData()
        }
        
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

    
    
    //НАЧАЛО - загрузка списка друзей с VK.COM
    func loadFriendsFoto(completion: @escaping ([InfoAlbomFriend]) -> Void ){
        //получение списка фотографий пользователя
        print("Френд id = ", friend.id)
        let paramters: Parameters = [
            "owner_id": friend.id,
            "access_token": Session.instance.token,
            "v": "5.77"
        ]

        AF.request("https://api.vk.com/method/photos.getAll", parameters: paramters).responseData { response in
        
            
            do {
                let friendfoto = try JSONDecoder().decode(DateAlbomFriend.self, from: response.value!)
                //print ("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
                //print ("1111 === ", friends.response.items)
                //print ("1111 === ", friendfoto.response.items)
                completion(friendfoto.response.items)
               // print("переменная фото = ", friendfoto.response.items)
            } catch {
                print("ОШИБКА = ", error)
            }
            
            
            
            
        print("ПРОВЕРКА = ",response.value) }
        
        
    }

}
