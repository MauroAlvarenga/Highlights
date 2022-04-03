//
//  ProductDetailViewController.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 02/04/2022.
//

import UIKit

class ProductDetailViewController: UIViewController {

    // MARK: Properties
    var productImg: UIImage?
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", image: UIImage(named: "ArrowLeft24"), primaryAction: .none, menu: .none)
    }
    
}

extension ProductDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailCell") as? ProductDetailCell else {
                return UITableViewCell()
            }
            if let img = self.productImg {
                cell.setCellImage(img)
            }
            cell.selectionStyle = .none
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDescriptionCell") as? ProductDescriptionCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Hard coded height values
        switch indexPath.row {
        case 0: return 600
        case 1: return 400
        default: return 350
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ProductDetailCell", bundle: nil), forCellReuseIdentifier: "ProductDetailCell")
        tableView.register(UINib(nibName: "ProductDescriptionCell", bundle: nil), forCellReuseIdentifier: "ProductDescriptionCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
    }
    
}

// TODO: Ver carrousel para las fotos
