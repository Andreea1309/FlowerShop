//
//  OrderService.swift
//  FlowerShop
//
//  Created by andreea.ungureanu on 27.06.2022.
//

import Foundation

enum OrderFetchError: Error {
    case invalidUrl
}

protocol OrderServiceProtocol {
    func fetchOrdersWithAsyncURLSession() async throws -> [Order]
    func setStatusForOrder(id: Int, status: String)
}

struct OrderService: OrderServiceProtocol {
    
    static let shared = OrderService()
    
    
    enum Request {
        case fetchOrdersWithAsyncURLSession
        case setStatusForOrder(id: Int, status: String)
        
        var basePath: String {
            switch self {
            case .fetchOrdersWithAsyncURLSession: return "/orders"
            case .setStatusForOrder(let id, let status):      return "/id/\(id)/status/\(status)"
            }
        }
        
        var baseUrl: String { return "http://demo2344567.mockable.io" }
        
        var url: String { return baseUrl + basePath }
    }
    
    func fetchOrdersWithAsyncURLSession() async throws -> [Order] {

        guard let url = URL(string: Request.fetchOrdersWithAsyncURLSession.url) else {
            throw OrderFetchError.invalidUrl
        }
        let (data, _) = try await URLSession.shared.data(from: url)

        let orders = try JSONDecoder().decode([Order].self, from: data)
        return orders
    }
    
    func setStatusForOrder(id: Int, status: String) {
        //TODO
    }
}
