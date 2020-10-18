//
//  ViewController.swift
//  1l_GorshkovDmitriy
//
//  Created by Дмитрий Горшков on 26.03.2020.
//  Copyright © 2020 Дмитрий Горшков. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleView: UILabel!
    
    @IBOutlet weak var loginTitle: UILabel!
    @IBOutlet weak var loginField: UITextField!

    @IBOutlet weak var passwordTitle: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBOutlet weak var scrollBottomConstraint: NSLayoutConstraint!
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //titleView.text = "Вконтакте"
        loginTitle.text = "Логин:"
        passwordTitle.text = "Пароль:"
        loginButton.setTitle("Вход", for: .normal)
        loginButton.layer.cornerRadius = 6
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWasShown(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillBeHidden(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        switch identifier {
            case "loginSegue":
                let isAuth = login()
            
                if !isAuth {
                    showErrorAlert()
                }
                return isAuth
            default:
                return true
        }
    }
    
    func login() -> Bool {
        let login = loginField.text!
        let password = passwordField.text!
        
        return (login == "admin" && password == "123456")
    }
    
    func showErrorAlert(){
        // Создаем контроллер
        let alert = UIAlertController(title: "Ошибка", message: "Введены неверные данные пользователя", preferredStyle: .alert)
        // Создаем кнопку для UIAlertController
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        // Добавляем кнопку на UIAlertController
        alert.addAction(action)
        // Показываем UIAlertController
        present(alert, animated: true, completion: nil)
    }
    
    @objc func keyboardWasShown(notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo as! [String: Any]
        let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        
        scrollBottomConstraint.constant = frame.height
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        scrollBottomConstraint.constant = 0
    }
}

