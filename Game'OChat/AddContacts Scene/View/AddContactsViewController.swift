//
//  AddContactsViewController.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/15/20.
//  Copyright (c) 2020 personal. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol AddContactsViewControllerInput: class {
    func display(viewModel: AddContacts.Fetch.ViewModel)
}

protocol AddContactsViewControllerOutput {
    func fetch(request: AddContacts.Fetch.Request)
}

class AddContactsViewController: UIViewController {
    
    var output: AddContactsViewControllerOutput!
    var router: (NSObjectProtocol & AddContactsRoutingLogic & AddContactsDataPassing)!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure(){
        
        AddContactsConfigurator.configure(viewController: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    

    @IBOutlet weak var addContactTableView: UITableView!
    var contactsView: AddContacts.Fetch.ViewModel?
    weak var contactsVC: ContactsViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: K.cancel, style: .plain, target: self, action: #selector(cancelContact))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        output.fetch(request: AddContacts.Fetch.Request())
    }
    

    @objc func cancelContact(){
        
        router.routeBackToContacts()
    }
    
}

extension AddContactsViewController: AddContactsViewControllerInput {
    
    func display(viewModel: AddContacts.Fetch.ViewModel) {
        
        DispatchQueue.main.async {
            
            self.contactsView = viewModel
            self.addContactTableView.reloadData()
            
        }
    }
}


extension AddContactsViewController: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contactsView?.contactViewModel.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = addContactTableView.dequeueReusableCell(withIdentifier: K.Cell.addContact, for: indexPath) as! AddContactViewCell
        guard let contact = contactsView?.contactViewModel[indexPath.row] else { return cell }
        cell.configure(viewModel: contact)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let contact = contactsView?.contactViewModel[indexPath.row] else { return }
        self.dismiss(animated: true, completion: {
            self.contactsVC?.router.routeToChatLogScene(contactDetail: contact)
        })
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        cell.layer.transform = transform
        UIView.animate(withDuration: 0.5) {
            cell.alpha = 1.0
            cell.layer.transform = CATransform3DIdentity
        }
    }

    
}
