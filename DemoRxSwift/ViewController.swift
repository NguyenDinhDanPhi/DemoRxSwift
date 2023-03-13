//
//  ViewController.swift
//  DemoRxSwift
//
//  Created by dan phi on 09/03/2023.
//

import UIKit
import RxSwift
import RxCocoa
struct Product {
    let imageName: String
    let tittle: String
}
struct ProductViewModel {
    var item = PublishSubject<[Product]>()
    func fetchItem() {
        let products = [
            Product(imageName: "house", tittle: "Home"),
            Product(imageName: "gear", tittle: "Setting"),
            Product(imageName: "person.cirle", tittle: "Profile"),
            Product(imageName: "airplane", tittle: "Flights"),
            Product(imageName: "bell", tittle: "Activity")
        
        ]
        item.onNext(products)
        item.onCompleted()
    }
}

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var viewModel = ProductViewModel()
    private var bag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        tableView.frame = view.bounds
        bindTableData()
    }

    func bindTableData() {
        // bind item to table
        viewModel.item.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { row, item,cell in
            cell.textLabel?.text = item.tittle
            cell.imageView?.image = UIImage(systemName: item.imageName)
        }.disposed(by: bag)
        //bind a model selected handle
        tableView.rx.modelSelected(Product.self).bind {
            product in
            print(product.tittle)
        }.disposed(by: bag)
        //fetch item
        viewModel.fetchItem()
    }

}

