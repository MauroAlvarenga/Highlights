//
//  HomeViewController.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 29/03/2022.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: Properties
    let searchVM = SearchViewModel(categoriesService: CategoriesPredictionService(), highlightsService: HighlightsService(), productsService: HighlightedProductsService())
    
    typealias Product2 = (id: String, img: UIImage)
    let products: [Product2] = [
        (id: "car1", img: UIImage(named: "car1")!),
        (id: "car2", img: UIImage(named: "car2")!),
        (id: "car3", img: UIImage(named: "car3")!),
        (id: "car4", img: UIImage(named: "car4")!),
        (id: "productViewCar", img: UIImage(named: "productViewCar")!),
    ]
    
    var thisProduct: Product?
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
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

// MARK: Table View delegate and data source.
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchVM.getHighlightsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell {
            let id = searchVM.getHighlightID(position: indexPath.row)
            cell.setCellID(id)
            if let product = self.thisProduct {
                cell.configure(product: product)
            }
            // TODO: load images
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
    
    // Configure table view delegate, data source, and cell.
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }

    private func barButtonFromImage (_ name: String) -> UIBarButtonItem {
        return UIBarButtonItem(image: UIImage(named: name), style: .plain, target: .none, action: .none)
    }
}

// MARK: Search Bar Delegate
extension HomeViewController: UISearchBarDelegate {
    
    func setupSearchBar() {
        let searchBar = UISearchBar()
        setSearchBarStyle(searchBar)
        // Add Search Bar to the navBar
        self.navigationItem.titleView = searchBar
        searchBar.delegate = self
    }
    
    func setSearchBarStyle(_ searchBar: UISearchBar) {
        searchBar.tintColor = .textPrimary
        searchBar.searchTextField.layer.cornerRadius = 20
        searchBar.searchTextField.layer.masksToBounds = true
        searchBar.searchTextField.backgroundColor = .backgroundWhite
        searchBar.searchTextField.placeholder = "Buscar en Mercado Libre 🇦🇷"
        searchBar.setValue("Cancelar", forKey: "cancelButtonText")
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("holiholi")
        // TODO: Show possible categories
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("A BUSCARLA!")
        guard let text = searchBar.searchTextField.text else { return }
        let keyword = text.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: " ", with: "%20")
        print(keyword)
        searchVM.getTopCategory(search: keyword) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.searchWithCategoryID()
        }
    }
    
    private func searchWithCategoryID() {
        let categories = searchVM.getCategories()
        let categoryID = categories[0].category_id
        searchVM.getHighlights(from: categoryID) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.getHighlightedProducts()
        }
    }
    
    private func getHighlightedProducts() {
        let IDs: [String] = searchVM.getHighlightsListID()
        searchVM.getProducts(withIDs: IDs) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.setProductsOnTableView()
        }
    }
    
    private func setProductsOnTableView() {
        let products = searchVM.getProductsList()
        print(products)
        for product in products {
            self.thisProduct = product
            self.tableView.reloadData()
        }
        self.tableView.reloadData()
    }
    
    
//    private func setHighlightsList() {
//        self.highlightsList = searchVM.getHighlightsList()
//    }
    
}
