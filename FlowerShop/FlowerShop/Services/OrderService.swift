//
//  OrderService.swift
//  FlowerShop
//
//  Created by andreea.ungureanu on 27.06.2022.
//

import Foundation

enum OrderError: Error {
    case invalidUrl
}

protocol OrderServiceProtocol {
    func fetchOrdersWithAsyncURLSession() async throws -> [Order]
    func setStatusForOrder(id: Int, status: String) async throws
}

struct OrderService: OrderServiceProtocol {
    
    static let shared = OrderService()
    
    enum HTTPMethod: String {
        case options = "OPTIONS"
        case get     = "GET"
        case head    = "HEAD"
        case post    = "POST"
        case put     = "PUT"
        case patch   = "PATCH"
        case delete  = "DELETE"
        case trace   = "TRACE"
        case connect = "CONNECT"
    }
    
    
    enum Request {
        case fetchOrdersWithAsyncURLSession
        case setStatusForOrder(id: Int, status: String)
        
        var basePath: String {
            switch self {
            case .fetchOrdersWithAsyncURLSession: return "/orders"
            case .setStatusForOrder(let id, let status):      return "/id/\(id)/status/\(status)"
            }
        }
        
        var baseUrl: String { return "https://demo2344567.mockable.io" }
        
        var url: String { return baseUrl + basePath }
    }
    
    func fetchOrdersWithAsyncURLSession() async throws -> [Order] {

        guard let url = URL(string: Request.fetchOrdersWithAsyncURLSession.url) else {
            throw OrderError.invalidUrl
        }
        let (data, response) = try await URLSession.shared.data(from: url)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error while fetching data") }
        let orders = try JSONDecoder().decode([Order].self, from: data)
        return orders
    }
    
    func setStatusForOrder(id: Int, status: String) async throws {
        guard let url = URL(string: Request.setStatusForOrder(id: id, status: status).url) else {
            throw OrderError.invalidUrl
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error while fetching data") }
    }
}
