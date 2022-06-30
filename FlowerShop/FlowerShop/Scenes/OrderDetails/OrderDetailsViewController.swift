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
    var statusValues = ["new", "pending", "deliver"]
    let statusPickerViewComponentsNumber = 1
    
    var statusPickerView = UIPickerView()
    

    @IBOutlet weak var orderDescriptionLabel: UILabel!
    @IBOutlet weak var orderPriceLabel: UILabel!
    @IBOutlet weak var orderImageView: UIImageView!
    @IBOutlet weak var orderStatusTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        statusPickerView.delegate = self
        statusPickerView.dataSource = self
        downloadOrderImage()
        orderDescriptionLabel.text = "Description \(orderDescriptionLabelText)"
        orderPriceLabel.text = "Price \(orderPriceLabelText)" 
        orderStatusTextField.placeholder = "Status: \(orderStatusText)"
        orderStatusTextField.inputView = statusPickerView
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

extension OrderDetailsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return statusPickerViewComponentsNumber
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return statusValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return statusValues[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        orderStatusTextField.text = "Status: \(statusValues[row])"
        orderStatusTextField.resignFirstResponder()
    }
    

}
