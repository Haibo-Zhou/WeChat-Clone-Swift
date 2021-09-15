//
//  ChatLogController.swift
//  WeChat Clone
//
//  Created by HaiboZhou on 2021/9/15.
//

import UIKit

class ChatLogController: UIViewController {
    
    var friend: Friend? {
        didSet {
            navigationItem.title = friend?.name
            messages = friend?.messages?.allObjects as? [Message]
            messages?.sort {($0.date ?? Date() < $1.date ?? Date())}
            print("messages count in ChatLog page: \(String(describing: messages?.count))")
        }
    }
    
    var messages: [Message]?
    var bottomConstraint: NSLayoutConstraint!
    var imagePicker: ImagePicker!
    
    // UI elements
    var collectionView: UICollectionView!
    
    lazy var messageInputContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()
    
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.placeholder = "Enter text"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        return textField
    }()
    
    lazy var interphoneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let font = UIFont.systemFont(ofSize: 25, weight: .regular)
        let configuration = UIImage.SymbolConfiguration(font: font)
        let image = UIImage(systemName: "speaker.wave.1", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let font = UIFont.systemFont(ofSize: 25, weight: .regular)
        let configuration = UIImage.SymbolConfiguration(font: font)
        let image = UIImage(systemName: "plus.circle", withConfiguration: configuration)?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
//        button.setTitleColor(.label, for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)

        return button
    }()
    
    @objc func addButtonTapped(_ sender: UIButton) {
        print("addButton tapped")
        self.imagePicker.present(from: sender)
    }
    
    
    lazy var faceButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let font = UIFont.systemFont(ofSize: 25, weight: .regular)
        let configuration = UIImage.SymbolConfiguration(font: font)
        let image = UIImage(systemName: "face.smiling", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        //        button.addTarget(self, action: #selector(cycleModeButtonTapped(_:)), for: .touchUpInside)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
        
        // replace keyboard "return" with "Send"
        inputTextField.delegate = self
        inputTextField.returnKeyType = .send
        
        // dismiss keyboard when tap around
        self.hideKeyboardWhenTappedAround()
        
        setupViews()
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    private func setupViews() {
        configureCollectionView()
        view.addSubview(messageInputContainerView)
        
        bottomConstraint = messageInputContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let g = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: g.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: messageInputContainerView.topAnchor),
            
            messageInputContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageInputContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomConstraint,
            messageInputContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08),
        ])
        
        setupInputComponents()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ChatLogMessageCell.self, forCellWithReuseIdentifier: ChatLogMessageCell.cellId)
        collectionView.backgroundColor = .chatLogBgColor
        collectionView.delegate = self
        collectionView.dataSource = self
//        collectionView.backgroundColor = .myPink
        view.addSubview(collectionView)
    }
    
    @objc func handleKeyboardNotification(notification: Notification) {
        if let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            // change messageInputContainerView bottom constraint per keyboard showing state
            let isKeyboardShowing = (notification.name == UIResponder.keyboardWillShowNotification)
            bottomConstraint.constant = isKeyboardShowing ? -keyboardFrame.height : 0
            
            // add animation for messageInputContainerView position change
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut) {
                self.view.layoutIfNeeded()
            } completion: { completed in
                
                if isKeyboardShowing {
                    guard let messages = self.messages else { return }
                    let indexPath = IndexPath(item: messages.count - 1, section: 0)
                    self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
                }
            }
        }
    }
    
    private func setupInputComponents() {
        // add a border line on the top of messageInputContainerView
        let topBoardView = UIView()
        topBoardView.translatesAutoresizingMaskIntoConstraints = false
        topBoardView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        
        messageInputContainerView.addSubview(inputTextField)
        messageInputContainerView.addSubview(interphoneButton)
        messageInputContainerView.addSubview(addButton)
        messageInputContainerView.addSubview(faceButton)
        messageInputContainerView.addSubview(topBoardView)
        
        NSLayoutConstraint.activate([
            interphoneButton.leadingAnchor.constraint(equalTo: messageInputContainerView.leadingAnchor, constant: 16),
            interphoneButton.centerYAnchor.constraint(equalTo: inputTextField.centerYAnchor),
            interphoneButton.widthAnchor.constraint(equalToConstant: 30),
            
            inputTextField.leadingAnchor.constraint(equalTo: interphoneButton.trailingAnchor, constant: 16),
            inputTextField.trailingAnchor.constraint(equalTo: faceButton.leadingAnchor, constant: -16),
            inputTextField.topAnchor.constraint(equalTo: messageInputContainerView.topAnchor, constant: 8),
            inputTextField.heightAnchor.constraint(equalTo: messageInputContainerView.heightAnchor, multiplier: 0.5),
            
            addButton.trailingAnchor.constraint(equalTo: messageInputContainerView.trailingAnchor, constant: -16),
            addButton.centerYAnchor.constraint(equalTo: inputTextField.centerYAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 30),
            
            faceButton.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -8),
            faceButton.centerYAnchor.constraint(equalTo: inputTextField.centerYAnchor),
            faceButton.widthAnchor.constraint(equalToConstant: 30),
            
            topBoardView.leadingAnchor.constraint(equalTo: messageInputContainerView.leadingAnchor),
            topBoardView.trailingAnchor.constraint(equalTo: messageInputContainerView.trailingAnchor),
            topBoardView.topAnchor.constraint(equalTo: messageInputContainerView.topAnchor),
            topBoardView.heightAnchor.constraint(equalToConstant: 0.3),
        ])
    }
    
    
}

// MARK: - UICollectionView
extension ChatLogController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatLogMessageCell.cellId, for: indexPath) as? ChatLogMessageCell else {
            fatalError("Unable to dequeue ChatLogMessageCell")
        }
        // configure the cell
        let message = self.messages?[indexPath.item]
        cell.messageTextView.text = message?.text
        
        if let imageData = message?.imageData {
            cell.messageImageView.image = UIImage(data: imageData)
            // hide messageTextView related UI elements
            cell.messageTextView.isHidden = true
            cell.textBubbleView.isHidden = true
            cell.profileImageView.isHidden = true
            
            // show imageView
            cell.messageImageView.isHidden = false
        } else {
            cell.messageImageView.isHidden = true
            
            if let message = message, let messageText = message.text,
               let profileImageData = message.friend?.profileImageData {
                
                if let profileImage = UIImage(data: profileImageData) {
                    cell.profileImageView.image = profileImage
                }
                
                let size = CGSize(width: 250, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
                
                if message.isSender == false {
                    cell.messageTextView.frame = CGRect(x: 60 + 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                    cell.textBubbleView.frame = CGRect(x: 60, y: 0, width: estimatedFrame.width + 16 + 8, height: estimatedFrame.height + 20)
                    
                    cell.profileImageView.isHidden = false
                    cell.myImageView.isHidden = true
                    cell.textBubbleView.backgroundColor = .msgGrayBgColor
                } else { // I'm sender
                    cell.messageTextView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 16 - 16 - 40, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                    cell.textBubbleView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 16 - 8 - 16 - 40, y: 0, width: estimatedFrame.width + 16 + 8, height: estimatedFrame.height + 20)
                    
                    cell.profileImageView.isHidden = true
                    cell.myImageView.isHidden = false
                    cell.textBubbleView.backgroundColor = .msgGreenBgColor
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // if message only contains text
        let message = messages?[indexPath.item]
        if let messageText = message?.text {
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
            
            return CGSize(width: view.frame.width, height: estimatedFrame.height + 20)
        }
        // if message only contains image
        else if let _ = message?.imageData {
            return CGSize(width: view.frame.width, height: 200)
        }
        
        return CGSize(width: view.frame.width, height: 100)
    }
    
    // add a padding for content in cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
}

// MARK: - UITextFieldDelegate
extension ChatLogController: UITextFieldDelegate {
    // action for keyboard "Send" button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(inputTextField.text ?? "")
        
        if let friend = friend,
           let text = inputTextField.text, text != "" {
            DispatchQueue.global().async { [weak self] in
                // save sending text into DB
                CoreDataManager.shared.createMessage(friend: friend, text: text, minutesAgo: 0, isSender: true) { message in
                    
                    self?.messages?.append(message)
                    
                    DispatchQueue.main.async {
                        if let messages = self?.messages {
                            let indexPath = IndexPath(item: messages.count - 1, section: 0)
                            self?.collectionView.insertItems(at: [indexPath])
                            self?.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
                            self?.inputTextField.text = nil
                        }
                        
                    }
                }
            }
        }
        return true
    }
}

extension ChatLogController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        if let friend = self.friend {
            DispatchQueue.global().async { [weak self] in
                // save sending image into DB
                CoreDataManager.shared.createMessage(friend: friend, messageImage: image, minutesAgo: 0, isSender: true) { message in
                    
                    self?.messages?.append(message)
                    print("messages new count: \(self?.messages?.count ?? 0)")
                    
                    DispatchQueue.main.async {
                        if let messages = self?.messages {
                            let indexPath = IndexPath(item: messages.count - 1, section: 0)
                            self?.collectionView.insertItems(at: [indexPath])
                            self?.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
                            self?.inputTextField.text = nil
                        }
                    }
                }
            }
        }
    }
}
