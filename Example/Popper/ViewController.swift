//
//  ViewController.swift
//  Popper
//
//  Created by mitulmanish on 03/06/2019.
//  Copyright (c) 2019 mitulmanish. All rights reserved.
//

import UIKit
import Popper

class ViewController: UIViewController {
    private var animator: UIViewControllerTransitioningDelegate?
    
    @IBAction func buttonTouched(_ sender: UIButton) {
        let fruitsViewController = DraggableViewController()
        animator = DraggableTransitionDelegate()
        fruitsViewController.transitioningDelegate = animator
        fruitsViewController.modalPresentationStyle = .custom
        present(fruitsViewController, animated: true, completion: .none)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

class DraggableViewController: UIViewController {
    
    private static let originalFruitsList: [String] = ["Apple 🍎", "Orange 🍊", "Pine Apple 🍍", "WaterMelon 🍉", "Banana 🍌", "Cherries 🍒", "Mango 🥭", "Strawberry 🍓", "Grapes 🍇", "Melon 🍈", "Peach 🍑", "Kiwi 🥝"]
    
    private var filteredFruitsList: [String] = DraggableViewController.originalFruitsList {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    private lazy var containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .darkGray
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var handlerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .groupTableViewBackground
        view.layer.cornerRadius = 4
        return view
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
        searchBar.barTintColor = .darkGray
        (searchBar.value(forKey: "_searchField") as? UITextField)?.backgroundColor = .groupTableViewBackground
        searchBar.isTranslucent = false
        searchBar.searchBarStyle = .default
        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        return UITableView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupContainerView()
        setupHandlerView()
        setupSearchBar()
        setupTableView()
    }
    
    private func setupContainerView() {
        view.addSubview(containerView)
        [containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         containerView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
         containerView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor)
            ].forEach { $0.isActive = true }
    }
    
    private func setupHandlerView() {
        containerView.addSubview(handlerView)
        [handlerView.heightAnchor.constraint(equalToConstant: 4),
         handlerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
         handlerView.widthAnchor.constraint(equalToConstant: 90),
         handlerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8)
            ].forEach { $0.isActive = true }
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(searchBar)
        [searchBar.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
         searchBar.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
         searchBar.topAnchor.constraint(equalTo: handlerView.bottomAnchor, constant: 8),
         searchBar.heightAnchor.constraint(equalToConstant: 44),
         searchBar.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            ].forEach { $0.isActive = true }
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(tableView)
        [tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
         tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
         tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
         tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
            ].forEach { $0.isActive = true }
        
        tableView.backgroundColor = .darkGray
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cellID")
    }
    
    override func viewDidLayoutSubviews() {
        view.round(corners: [.topLeft, .topRight], radius: 8)
    }
}

extension DraggableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchString = searchText.lowercased()
        if searchText.isEmpty {
            filteredFruitsList = DraggableViewController.originalFruitsList
        } else {
            filteredFruitsList = filteredFruits(searchString: searchString)
        }
    }
    
    func filteredFruits(searchString: String) -> [String] {
        let filteredFruits = DraggableViewController.originalFruitsList.filter {
            ($0 == searchString.lowercased())
                || $0.lowercased().hasPrefix(searchString.lowercased())
        }
        return filteredFruits
    }
}

extension DraggableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFruitsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.text = filteredFruitsList[indexPath.item]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if searchBar.isFirstResponder {
            searchBar.resignFirstResponder()
        }
    }
}

extension DraggableViewController: DraggableViewType {
    
    var scrollView: UIScrollView {
        return tableView
    }
    
    func handleInteraction(enabled: Bool) {
        tableView.isUserInteractionEnabled = enabled
        searchBar.isUserInteractionEnabled = enabled
    }
    
    func dismissKeyboard() {
        guard searchBar.isFirstResponder else { return }
        searchBar.resignFirstResponder()
    }
}

class CustomTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .darkGray
        textLabel?.textColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

