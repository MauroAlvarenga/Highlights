//
//  HomeViewController.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 29/03/2022.
//

import UIKit

class HomeViewController: UIViewController {

    let photos = [
        UIImage(named: "car1"),
        UIImage(named: "car2"),
        UIImage(named: "car3"),
        UIImage(named: "car4"),
        UIImage(named: "productViewCar"),
        UIImage(named: "car1"),
        UIImage(named: "car2"),
        UIImage(named: "car3"),
        UIImage(named: "car4"),
        UIImage(named: "productViewCar")
    ].compactMap { $0 }
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    // MARK: Methods
    
}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell {
            cell.setCellImage(photos[indexPath.row])
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
    
}
