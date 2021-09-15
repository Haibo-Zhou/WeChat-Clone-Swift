//
//  ViewController.swift
//  WeChat Clone
//
//  Created by HaiboZhou on 2021/9/13.
//

import UIKit

class MessageViewController: UIViewController {
    
    var messages: [Message]?
    
    // MARK: - UI elements
    lazy var tableView: UITableView = {
        let table = UITableView()
//        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(MessageTableViewCell.self, forCellReuseIdentifier: MessageTableViewCell.cellIdentifier)
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    lazy var addButton: UIButton = {
        let btn = UIButton(type: .custom)
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .default)
        btn.setBackgroundImage(UIImage(systemName: "plus.circle", withConfiguration: config), for: .normal)
        btn.tintColor = .label
        //        btn.backgroundColor = .gray
        btn.tag = 1
//        btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return btn
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
//        title = "微信(199)"
        self.navigationItem.title = "微信(199)"
        
        setupViews()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }
    
    func setupViews() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 66
        
        // MARK: setup navigaion items
        let addButtonItem = UIBarButtonItem(customView: addButton)
        self.navigationItem.rightBarButtonItem = addButtonItem
        
        // MARK: setup search bar
        // setupSearchBar()
    }
    
    
}

// MARK: - tableView datasource
extension MessageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.cellIdentifier, for: indexPath) as? MessageTableViewCell else {
            fatalError("Unable to dequeue ConversationTableViewCell")
        }
        
        cell.message = messages?[indexPath.row]
        
        // I could give a muteBell property to indicate if this friend is muted, but I would leave it for now
//        cell.bellImageView.image = UIImage(systemName: "bell.slash")
        
        return cell
    }
}

// MARK: - tableView delegate
extension MessageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 16
        let controller = ChatLogController()
        controller.friend = self.messages?[indexPath.item].friend
        navigationController?.pushViewController(controller, animated: true)
    }
}

