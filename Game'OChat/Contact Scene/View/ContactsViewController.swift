//
//  ContactsViewController.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/11/20.
//  Copyright (c) 2020 personal. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ContactsViewControllerInput: class {
    func displayLogOut(viewModel: Contacts.Logout.ViewModel)
    func displayData(viewModel: Contacts.Fetch.ViewModel)
    func displayMessages(viewModel: Contacts.Message.ViewModel)
    func displayDeletedMessage(viewModel: Contacts.Delete.ViewModel)
    func displayAlert(viewModel: Contacts.AlertMessage.ViewModel)

}

protocol ContactsViewControllerOutput {
    func checkLogFetch(request: Contacts.Check.Request)
    func fetchLogout(request: Contacts.Logout.Request)
    func loadMessages(request: Contacts.Message.Request)
    func deleteMessage(request: Contacts.Delete.Request)
}

class ContactsViewController: UIViewController {
    
    var output: ContactsViewControllerOutput!
    var router: (NSObjectProtocol & ContactsRoutingLogic & ContactsDataPassing)!
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure(){
        ContactsConfigurator.configure(viewController: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    var viewMessages: Contacts.Message.ViewModel?
    var timer: Timer?
    
    @IBOutlet weak var contactMessageTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loadMessages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkLog()
        loadMessages()
        contactMessageTableView.allowsMultipleSelectionDuringEditing = true
    }
        
    fileprivate func checkLog() {
        
        output.checkLogFetch(request: Contacts.Check.Request())
    }
    
    fileprivate func loadMessages(){
        
        output.loadMessages(request: Contacts.Message.Request())
    }
    
    @IBAction func logOut(_ sender: Any) {
        
        output.fetchLogout(request: Contacts.Logout.Request())
    }
    @IBAction func addNewContacts(_ sender: Any) {
        
        router.routeToAddContactsScene()
    }
}

extension ContactsViewController: ContactsViewControllerInput {
    
    func displayLogOut(viewModel: Contacts.Logout.ViewModel){
        
        router.routeToLoginOrRegisterScene()
    }
    
    func displayData(viewModel: Contacts.Fetch.ViewModel){
        
        guard let titleName = viewModel.userData[K.name] as? String, let profileImage = viewModel.userData[K.profileImageURL] as? String else { return }
        setNavigationItems(title: titleName, profileImage: profileImage)
    }
    
    func displayMessages(viewModel: Contacts.Message.ViewModel){
        
        viewMessages = viewModel
        
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.handleReloadtable), userInfo: nil, repeats: false)
    }
    
    
    func displayDeletedMessage(viewModel: Contacts.Delete.ViewModel){
        
        self.viewMessages?.messageViewModel.remove(at: viewModel.rowIndex)
        self.contactMessageTableView.reloadData()
    }
    
    func displayAlert(viewModel: Contacts.AlertMessage.ViewModel){
        
        let alert = UIAlertController(title: K.alert, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: K.okay, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

extension ContactsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewMessages?.messageViewModel.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = contactMessageTableView.dequeueReusableCell(withIdentifier: K.Cell.contactMessage, for: indexPath) as! ContactMessageCell
        
        guard let contactData = viewMessages?.messageViewModel[indexPath.row] else { return cell }
        cell.configure(contactDetail: contactData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let contactData = viewMessages?.messageViewModel[indexPath.row] else { return }
        goToChatLog(contactData: contactData)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        output.deleteMessage(request: Contacts.Delete.Request(rowIndex: indexPath.row))
    }
}


extension ContactsViewController{
    
    func goToChatLog(contactData: MessageModel){
        
        let msgPartner = MessagePartners()
        guard let currentUserID = msgPartner.getPartnerID(messageDetail: contactData) else { return }
        
        K.Reference.database.child(K.users).child(currentUserID).observeSingleEvent(of: .value, with: { (snapShot) in
            
            guard let dictionary = snapShot.value as? [String: AnyObject] else { return }
            let uniqueID = currentUserID
            let name = dictionary[K.name] as? String
            let email = dictionary[K.email] as? String
            let profileImage = dictionary[K.profileImageURL] as? String
            let contactDetail = AddContactsModel(name: name, email: email, profileImageURL: profileImage, uniqueUserID: uniqueID)
            self.router.routeToChatLogScene(contactDetail: contactDetail)
        }, withCancel: nil)
    }
    
    @objc func handleReloadtable(){
        
        DispatchQueue.main.async {
            
            self.contactMessageTableView.reloadData()
        }
    }
}
