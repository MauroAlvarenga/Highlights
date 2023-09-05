//
//  FavoritesViewController.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 30/03/2022.
//

import UIKit

class FavoritesViewController: UIViewController {

    // MARK: Properties
//    let productImg: Dictionary<String, UIImage> = [
//        "car1": UIImage(named: "car1")!,
//        "car2": UIImage(named: "car2")!,
//        "car3": UIImage(named: "car3")!,
//        "car4": UIImage(named: "car4")!,
//        "productViewCar": UIImage(named: "productViewCar")!,
//    ]
    var favoritesList = Array(FavoritesList.shared.getFavorites())

    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    // Load favorites each time the view appears to dinamically update favorites.
    override func viewWillAppear(_ animated: Bool) {
        getFavorites()
    }

    private func getFavorites() {
        //viewModel?.getCategories { [weak self] in
        self.favoritesList = Array(FavoritesList.shared.getFavorites())
        self.tableView.reloadData()
        //}
    }
    
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //favoritesList.count
        FavoritesList.shared.getFavorites().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell {
            cell.hideFavoriteButton()
            let id = favoritesList[indexPath.row]
            cell.setCellID(id)
            //cell.setCellImage(productImg[id]!)
            return cell
        }
        return UITableViewCell()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }

    // Swipe to delete Favorites
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let cell = tableView.cellForRow(at: indexPath) as? TableViewCell {
                let id = cell.getCellID()
                FavoritesList.shared.removeFavorite(id)
                if let i = favoritesList.firstIndex(of: id) {
                    favoritesList.remove(at: i)
                }
                tableView.deleteRows(at: [indexPath], with: .fade)
                print(cell.getCellID())
                print("Deleted Item")
                print(FavoritesList.shared.getFavorites())
            }
        }
    }
}

