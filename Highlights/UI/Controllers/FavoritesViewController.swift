//
//  FavoritesViewController.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 30/03/2022.
//

import UIKit

class FavoritesViewController: UIViewController {

    // MARK: Properties
    let userDefaults = UserDefaults()
    var favoritesList: [Int] = []

    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFavorites()
    }

    func getFavorites() {
        //viewModel?.getCategories { [weak self] in
        self.favoritesList = FavoritesList.shared.getFavorites()
        self.tableView.reloadData()
        //}
    }
    
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoritesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell {
            cell.hideFavoriteButton()
            return cell
        }
        return UITableViewCell()
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        //tableView.backgroundColor = .backgroundPrimary
    }

//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            //objects.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//        }
//    }
    
}

