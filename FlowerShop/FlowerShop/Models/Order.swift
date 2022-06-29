//
//  Order.swift
//  FlowerShop
//
//  Created by andreea.ungureanu on 27.06.2022.
//

import Foundation

struct Order: Codable {
    let id: Int
    let description: String
    let price: Double
    let receiver: Receiver
    let imageUrlString: String
    let status: String
    
    private enum CodingKeys: String, CodingKey {
        case id, description, price, receiver = "deliver_to" , imageUrlString = "image_url", status
    }
}
