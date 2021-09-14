//
//  ViewController.swift
//  WeChat Clone
//
//  Created by HaiboZhou on 2021/9/13.
//

import UIKit

class MessageViewController: UIViewController {
    
    // MARK: - UI elements
    lazy var tableView: UITableView = {
        let table = UITableView()
//        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ConversationTableViewCell.self, forCellReuseIdentifier: ConversationTableViewCell.cellIdentifier)
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
    }
    
    func setupViews() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.rowHeight = 66
        
        // setup navigaion items
        let addButtonItem = UIBarButtonItem(customView: addButton)
        self.navigationItem.rightBarButtonItem = addButtonItem
        
        // setup search bar
//        setupSearchBar()
    }
}

// MARK: - tableView datasource
extension MessageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 26
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ConversationTableViewCell.cellIdentifier, for: indexPath) as? ConversationTableViewCell else {
            fatalError("Unable to dequeue ConversationTableViewCell")
        }
        
        cell.imageCover.image = UIImage(named: "gen")
        cell.bellImageView.image = UIImage(systemName: "bell.slash")
        cell.titleLabel.text = "熊孩子书店 ｜ 热爱生活的小伙伴们"
        cell.subTitleLabel.text = "杜丘: 健谈但却不是话唠那种"
        cell.dateLabel.text = "10:12 AM"
        
        return cell
    }
}

// MARK: - tableView delegate
extension MessageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

