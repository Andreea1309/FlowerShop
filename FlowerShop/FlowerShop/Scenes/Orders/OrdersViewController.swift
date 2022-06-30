//
//  OrdersViewController.swift
//  FlowerShop
//
//  Created by andreea.ungureanu on 27.06.2022.
//

import UIKit

class OrdersViewController: UIViewController {
    
    var orders = [Order]()
    
    @IBOutlet weak var ordersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ordersTableView.delegate = self
        ordersTableView.dataSource = self
        ordersTableView.register(UINib(nibName: "OrderCell", bundle: nil),
                           forCellReuseIdentifier: "OrderCell")
//        Task {
//
//            do {
//
//                orders = try await OrderService.shared.fetchOrdersWithAsyncURLSession()
//
//                // Update collection view content
//
//                ordersTableView.reloadData()
//                ordersTableView.layoutIfNeeded()
//
//            } catch {
//                print("Request failed with error: \(error)")
//            }
//
//        }
        guard let jsonData = MockOrderService.shared.readJsonFile(forFileName: "orders") else { return }
        orders = MockOrderService.shared.parseJsonData(jsonData: jsonData)!
        ordersTableView.reloadData()
        print("Orders \(orders)")

    }


}

extension OrdersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell
        cell.orderDescriptionLabel.text = orders[indexPath.item].description
        cell.orderPriceLabel.text = String(orders[indexPath.item].price)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderDetailsViewController = OrderDetailsViewController.instantiateFromXib()
        orderDetailsViewController.orderDescriptionLabelText = orders[indexPath.item].description
        orderDetailsViewController.orderPriceLabelText = String(orders[indexPath.item].price)
        orderDetailsViewController.orderImageStringUrl = orders[indexPath.item].imageUrlString
        orderDetailsViewController.orderStatusText = orders[indexPath.item].status
        navigationController?.pushViewController(orderDetailsViewController, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Orders"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel!.font = UIFont.boldSystemFont(ofSize: 24)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIConstants.headerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIConstants.rowHeight
    }
    
}
