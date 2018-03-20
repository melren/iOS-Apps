//
//  ChatVC.swift
//  Ivory
//
//  Created by Melanie Ren on 3/12/18.
//  Copyright © 2018 Melanie Ren. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Outlets
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var messageTxtField: ColoredPlaceHolderText!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var typingUsersLbl: UILabel!
    
    // Variables
    var isTyping = false
    
    // Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Dynamically Size Message Cell for Large Messages, first set Lines: 0 in storyboard
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Toggles textfield ontop of keyboard
        view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        
        // SWReveal toggles
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        // Slide to open & tap to open from SWRevealController
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        // Add observer
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        // Load messages in real time from all users & after pressing send
        SocketService.instance.getChatMessage { (success) in
            if success {
                // Show newest message
                self.loadNewestMessage()
            }
        }
        
        // Initial loading
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        } else {
            channelNameLbl.text = "Please Login"
        }
        
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
    }
    
    @objc func userDataDidChange(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            // Get channels
            onLoginGetMessages()
            updateWithChannel()
        } else {
            channelNameLbl.text = "Please Login"
            tableView.reloadData()
        }
    }
    
    func onLoginGetMessages() {
        MessageService.instance.findAllChannels(completion: { (success) in
            if success {
                // Do stuff with channels if there's at least one channel
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.channelNameLbl.text = "No channels yet!"
                }
            }
        })
    }
    
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLbl.text = "#\(channelName)"
        getMessages()
        
    }
    
    // Fetches messages from server upon first load
    func getMessages() {
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            if success {
                self.loadNewestMessage()
            }
        }
    }
    
    func loadNewestMessage() {
        self.tableView.reloadData()
        if MessageService.instance.messages.count > 0 {
            let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
            self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    // Actions
    
    // Only show send button when there's text in the field and user is logged in
    @IBAction func msgBoxEditing(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            if messageTxtField.text == "" {
                isTyping = false
                sendBtn.isHidden = true
            } else {
                if isTyping == false {
                    sendBtn.isHidden = false
                }
                isTyping = true
            }
        }
    }
    
    @IBAction func sendMsgPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            // If logged in, get channel ID and send the text
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            guard let message = messageTxtField.text else { return }
            
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
                if success {
                    self.messageTxtField.text = ""
                    // Dismiss textfield
                    self.messageTxtField.resignFirstResponder()
                }
            })
        }
    }

}
