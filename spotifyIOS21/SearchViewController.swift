//
//  SearchViewController.swift
//  spotifyIOS21
//
//  Created by Isa Melsov on 2/2/24.
//

import UIKit
import WebKit

class SearchViewController: UIViewController {
    
    private var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "What do you want to listen to?"
        view.keyboardType = .default
        view.tintColor = UIColor.white
        view.keyboardAppearance = .dark
        view.searchTextField.font = .monospacedDigitSystemFont(ofSize: 15, weight: .semibold)
        return view
    }()
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black
        view.register(UITableViewCell.self, forCellReuseIdentifier: "id")
        return view
    }()
    
    private var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1.0)
        setup()
    }
    
    private func setup() {
        setupSubviews()
        setupConstraints()
        addDelegates()
        changeSearchBarColor()
    }
    
    private func setupSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        navigationItem.titleView = searchBar
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func addDelegates() {
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func changeSearchBarColor() {
        let searchField = searchBar.value(forKey: "searchField") as? UITextField
        searchField?.textColor = UIColor.white
        
        let placeholderLabel = searchField?.value(forKey: "placeholderLabel") as? UILabel
        placeholderLabel?.textColor = UIColor.lightGray
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            if let leftView = textField.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = UIColor.white
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id")!
        if let selectedIndexPath = selectedIndexPath, indexPath == selectedIndexPath {
            cell.contentView.backgroundColor = UIColor.darkGray
        } else {
            cell.contentView.backgroundColor = UIColor.black
        }
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedIndexPath = selectedIndexPath {
            if let cell = tableView.cellForRow(at: selectedIndexPath) {
                cell.contentView.backgroundColor = UIColor.black
            }
        }
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.contentView.backgroundColor = UIColor.darkGray
        }
        selectedIndexPath = indexPath
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
