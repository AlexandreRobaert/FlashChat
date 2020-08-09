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
    @IBOutlet weak var sendButton: UIButton!
    
    var messages:[Message] = []
    
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.meCellNibName, bundle: nil), forCellReuseIdentifier: K.meCellIdentifier)
        tableView.register(UINib(nibName: K.youCellNibName, bundle: nil), forCellReuseIdentifier: K.youCellIdentifier)
        title = K.appName
        navigationItem.hidesBackButton = true
        
        loadMessages()
    }
    
    // MARK: - Method Controller
    func loadMessages(){
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { (querySnapshot, error) in
            if let e = error {
                print("Não foi possível retornar os dados. \(e)")
            }else{
                if let documents = querySnapshot?.documents {
                    self.messages.removeAll()
                    for doc in documents {
                        let data = doc.data()
                        if let body = data[K.FStore.bodyField] as? String, let sender = data[K.FStore.senderField] as? String {
                            self.messages.append(Message(sender: sender, body: body))
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    let indexPah = IndexPath(row: self.messages.count - 1, section: 0)
                    self.tableView.scrollToRow(at: indexPah, at: .top, animated: true)
                }
            }
        }
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
        
        if let messageBody = messageTextField.text, !messageTextField.text!.isEmpty, let email = user?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: email,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print("Houve algum erro ao gravar os dados: \(e)")
                }else{
                    print("Gravou os dados com sucesso!")
                    
                    DispatchQueue.main.sync {
                        self.messageTextField.text = ""
                    }
                }
            }
        }
    }
}

// MARK: - Extensions
extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let email = user!.email
        let message = messages[indexPath.row]
        
        if email == message.sender {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.meCellIdentifier, for: indexPath) as! MeTableViewCell
            cell.messageLabel.text = message.body
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: K.youCellIdentifier, for: indexPath) as! YouTableViewCell
            cell.messageLabel.text = message.body
            return cell
        }
    }
}
