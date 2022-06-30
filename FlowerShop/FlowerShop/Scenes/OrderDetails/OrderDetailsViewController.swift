//
//  OrderDetailsViewController.swift
//  FlowerShop
//
//  Created by andreea.ungureanu on 27.06.2022.
//

import UIKit

class OrderDetailsViewController: UIViewController {
    
    var orderDescriptionLabelText: String = ""
    var orderPriceLabelText: String = ""
    var orderImageStringUrl: String = ""
    var orderStatusText: String = ""
    

    @IBOutlet weak var orderDescriptionLabel: UILabel!
    @IBOutlet weak var orderPriceLabel: UILabel!
    @IBOutlet weak var orderImageView: UIImageView!
   
    @IBOutlet weak var orderStatusTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadOrderImage()
        orderDescriptionLabel.text = "Description \(orderDescriptionLabelText)"
        orderPriceLabel.text = "Price \(orderPriceLabelText)" 
        orderStatusTextField.placeholder = "Status: \(orderStatusText)"
    }
    
    func downloadOrderImage(){
        guard let imageUrl = URL(string: orderImageStringUrl) else { return }
        DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        self.orderImageView.image = UIImage(data: data)
                    }
                }
            }
    }
}
