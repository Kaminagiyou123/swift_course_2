//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages :[Message] = [
      
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "FlashChat"
        navigationItem.hidesBackButton = true
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        loadMessages()
    }
    
    func loadMessages(){
        messages = []
        db.collection(K.FStore.collectionName).getDocuments( completion: { (querySnapshot,error) in
            if let e = error {
                print ("error retreiving data from Firestore \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents{
                    for doc in snapshotDocuments {
                        let data = doc.data()
                     if let sender = data[K.FStore.senderField] as? String
                            ,let message = data[K.FStore.bodyField] as? String {
                         let newMessage = Message(sender: sender, body: message)
                         self.messages.append(newMessage)
                         DispatchQueue.main.async {
                             self.tableView.reloadData()
                         }
                       
                }
                    }
                }
            }
        })}
   
                
            
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text , let messageSender = Auth.auth().currentUser?.email{
            db.collection(K.FStore.collectionName).addDocument(data:[K.FStore.senderField: messageSender, K.FStore.bodyField:messageBody]) { error in
                if let e = error {
                    print("There was an issue saving data into Firestore \(e)")
                } else {
                    print("Successfully saved the data")
                }
            }
        }
    
    }
    
    @IBAction func logoutPressed(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = messages[indexPath.row].body
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
}
