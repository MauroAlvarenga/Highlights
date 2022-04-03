//
//  HomeViewController.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 29/03/2022.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: Properties
    typealias Product = (id: String, img: UIImage)
    let products: [Product] = [
        (id: "car1", img: UIImage(named: "car1")!),
        (id: "car2", img: UIImage(named: "car2")!),
        (id: "car3", img: UIImage(named: "car3")!),
        (id: "car4", img: UIImage(named: "car4")!),
        (id: "productViewCar", img: UIImage(named: "productViewCar")!),
    ]
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    // MARK: Methods
    func navigateToProduct(_ receivedData: UIImage) {
        let productDetailVC = ProductDetailViewController()
        // Customize bar buttons and remove back text
        let pVCrightItem1 = barButtonFromImage("CartEmpty24")
        let pVCrightItem2 = barButtonFromImage("Search24")
        let rightItem3 = barButtonFromImage("FavoriteOutlined24")
        productDetailVC.navigationItem.rightBarButtonItems = [pVCrightItem1, pVCrightItem2, rightItem3]
        self.navigationItem.backButtonTitle = ""
        // Navigate
        productDetailVC.productImg = receivedData
        self.navigationController?.pushViewController(productDetailVC, animated: true)
    }
}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell {
            cell.setCellImage(products[indexPath.row].img)
            cell.setCellID(products[indexPath.row].id)
            return cell
        }
        return UITableViewCell()
    }
    
    // TODO: navigate to product view on row selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? TableViewCell {
            print("Hola! Selected row: \(cell.getCellID())")
            let img = cell.getCellImage()
            navigateToProduct(img)
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    
    func setNavBarAppeareance2(_ navbar: UINavigationBar) {
        
    }
    
    private func barButtonFromImage (_ name: String) -> UIBarButtonItem {
        return UIBarButtonItem(image: UIImage(named: name), style: .plain, target: .none, action: .none)
    }
}
