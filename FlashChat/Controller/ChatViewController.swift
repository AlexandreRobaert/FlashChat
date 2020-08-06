//
//  ChatViewController.swift
//  FlashChat
//
//  Created by Alexandre Robaert on 01/08/20.
//  Copyright © 2020 Alexandre Robaert. All rights reserved.
//

import UIKit
import Firebase
class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var messages:[Message] = [Message(sender: "1@2.com", body: "Hey!"),
                              Message(sender: "A@B.com", body: "Olá, tudo bem?"),
                              Message(sender: "1@2.com", body: "Estou bem agora, asdfjalksdf aksfdklsdf askjdflaskjdf askdfjaslkdf sakdfjalskdfj asdkfjasldfj lkasdflkasjfd")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        title = K.appName
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
    }
}


extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageTableViewCell
        cell.messageLabel.text = messages[indexPath.row].body
        return cell
    }
}
