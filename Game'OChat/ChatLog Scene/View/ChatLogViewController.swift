//
//  ChatLogViewController.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/28/20.
//  Copyright (c) 2020 personal. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Firebase

protocol ChatLogViewControllerInput: class {
    func displayChat(viewModel: ChatLog.Message.Load.ViewModel)
    func displayContactDetail(viewModel: ChatLog.NewContact.ViewModel)
    func displayAlert(viewModel: ChatLog.AlertMessage.ViewModel)
}

protocol ChatLogViewControllerOutput {
    func sendMessage(request: ChatLog.Message.SaveText.Request)
    func sendImage(request: ChatLog.Message.SaveImage.Request)
    func loadChat(request: ChatLog.Message.Load.Request)
    func addContactDetail(request: ChatLog.NewContact.Request)
}

class ChatLogViewController: UIViewController {
    
    var output: ChatLogViewControllerOutput!
    var router: (NSObjectProtocol & ChatLogRoutingLogic & ChatLogDataPassing)!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure(){
        ChatLogConfigurator.configure(viewController: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var chatsCollectionView: UICollectionView!
    
    var viewModel: ChatLog.Message.Load.ViewModel?
    let messagePartners = MessagePartners()
    var timer: Timer?
    
    var startingFrame: CGRect?
    var blackBackgroundView: UIView?
    var startingImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.addContactDetail(request: ChatLog.NewContact.Request())
        output.loadChat(request: ChatLog.Message.Load.Request())
        
        chatsCollectionView.alwaysBounceVertical = true
        chatsCollectionView.register(ChatCollectionViewCell.self, forCellWithReuseIdentifier: K.Cell.chat)
        chatsCollectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 58, right: 0)
        chatsCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        output.loadChat(request: ChatLog.Message.Load.Request())
    }
    
    
    @IBAction func sendMessage(_ sender: Any) {
        
        guard let msg = messageTextField.text else { return }
        output.sendMessage(request: ChatLog.Message.SaveText.Request(messgae: msg))
        messageTextField.text = K.empty
    }
    
    @IBAction func sendImageMesssage(_sender: Any){
        
        sendImage()
    }
    
}

extension ChatLogViewController: ChatLogViewControllerInput {
    
    
    func displayContactDetail(viewModel: ChatLog.NewContact.ViewModel){
        
        self.navigationItem.title = viewModel.viewContactDetail.name
    }
    
    func displayChat(viewModel: ChatLog.Message.Load.ViewModel){
        
        self.viewModel = viewModel
        
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.handleReloadtable), userInfo: nil, repeats: false)
    }
    
    func displayAlert(viewModel: ChatLog.AlertMessage.ViewModel){
        
        let alert = UIAlertController(title: K.alert, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: K.okay, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
    
}

extension ChatLogViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel?.message.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = chatsCollectionView.dequeueReusableCell(withReuseIdentifier: K.Cell.chat, for: indexPath) as! ChatCollectionViewCell
        cell.chatLogController = self
        
        guard let messageModel = viewModel?.message[indexPath.row] else { return cell}
        configureCell(cell: cell, message: messageModel, chatPartner: viewModel?.chatPartner)
        
        if let text = messageModel.text{
            cell.bubbleWidthAnchor?.constant = estimateFrameForMessage(text: text).width + 32
            cell.textView.isHidden = false
        }
        else if messageModel.imageURL != nil{
            cell.bubbleWidthAnchor?.constant = 200
            cell.bubbleView.backgroundColor = .clear
            cell.textView.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 80
 
        if let text = viewModel?.message[indexPath.item].text{
            height = estimateFrameForMessage(text: text).height + 20
        }
        else if viewModel?.message[indexPath.row].imageURL != nil{
            height = 300
        }
        return CGSize(width: view.frame.width , height: height)
    }
    
}



extension ChatLogViewController{
    
    
    @objc func handleReloadtable(){
        
        DispatchQueue.main.async{
            self.chatsCollectionView.reloadData()
        }
    }
    
    private func estimateFrameForMessage(text: String) -> CGRect{
        
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
        
    }
    
    private func configureCell(cell: ChatCollectionViewCell, message: MessageModel, chatPartner: AddContactsViewModel?){
        
        cell.textView.text = message.text
        
        guard let partnerImage = chatPartner?.profileImage else { return }
        cell.profileImageView.loadImageUsingCache(image: partnerImage)
        
        if let messageUrl = message.imageURL{
            
            cell.bubbleView.backgroundColor = .clear
            cell.messageImageView.isHidden = false
            cell.messageImageView.loadImageUsingCache(image: messageUrl)
        
        }
        else{
            cell.messageImageView.isHidden = true
        }
        
        if message.fromID == Auth.auth().currentUser?.uid{
            
            cell.bubbleView.backgroundColor = ChatCollectionViewCell.blueColor
            cell.textView.textColor = .white
            cell.profileImageView.isHidden = true
            cell.bubbleRightAnchor?.isActive = true
            cell.bubbleLeftAnchor?.isActive = false
        }
        else{
            
            cell.bubbleView.backgroundColor = ChatCollectionViewCell.greyColor
            cell.textView.textColor = .black
            cell.profileImageView.isHidden = false
            cell.bubbleRightAnchor?.isActive = false
            cell.bubbleLeftAnchor?.isActive = true
        }
    }
    
    func performZoomIn(imageView: UIImageView){

        self.startingImageView = imageView
        startingFrame = imageView.superview?.convert(imageView.frame, to: nil)
        
        let zoomingImageView = UIImageView(frame: startingFrame!)
        zoomingImageView.backgroundColor = .red
        zoomingImageView.image = imageView.image
        zoomingImageView.isUserInteractionEnabled = true
        zoomingImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOutfromImage)))
          
        if let keyWindow = UIApplication.shared.windows.first(where: {$0.isKeyWindow}){
            
            blackBackgroundView = UIView(frame: keyWindow.frame)
            blackBackgroundView?.backgroundColor = .black
            blackBackgroundView?.alpha = 0
            keyWindow.addSubview(blackBackgroundView!)
            keyWindow.addSubview(zoomingImageView)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackBackgroundView?.alpha = 1
                   zoomingImageView.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: self.startingFrame!.height)
                   zoomingImageView.center = keyWindow.center
                
            },completion: nil)
        }

    }
    
    @objc func zoomOutfromImage(tapGesture: UITapGestureRecognizer){
        
        if let zoomOutImageView = tapGesture.view{
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                zoomOutImageView.frame = self.startingFrame!
                self.blackBackgroundView?.alpha = 0
                
            }) { (completed) in
                
                zoomOutImageView.removeFromSuperview()
            }
        }
    }
}

extension ChatLogViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    private func sendImage(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        var selectedImage: UIImage?
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            selectedImage = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            selectedImage = originalImage
        }
        
        if let selectImage = selectedImage{
            
            output.sendImage(request: ChatLog.Message.SaveImage.Request(image: selectImage))
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}

