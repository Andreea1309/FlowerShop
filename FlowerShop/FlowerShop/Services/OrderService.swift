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
    func readJsonFile(forFileName fileName: String) -> Data?
    func parseJsonData(jsonData: Data) -> [Order]?
}

struct OrderService: OrderServiceProtocol {
    
    static let shared = OrderService()
    
    func readJsonFile(forFileName fileName: String) -> Data? {
        do {
            guard let filePath = Bundle.main.path(forResource: fileName, ofType: "json") else {
                return nil
            }
            let url = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: url)
            return data
        } catch {
            print(error)
        }
        return nil
    }
    
    func parseJsonData(jsonData: Data) -> [Order]? {
        do {
            let decodedData = try JSONDecoder().decode([Order].self, from: jsonData)
            return decodedData
        } catch {
            print(error)
        }
        return nil
    }
    
    func fetchOrdersWithAsyncURLSession() async throws -> [Order] {

        guard let url = URL(string: "http://demo2344567.mockable.io/orders") else {
            throw OrderFetchError.invalidUrl
        }
        let (data, _) = try await URLSession.shared.data(from: url)

        let orders = try JSONDecoder().decode([Order].self, from: data)
        return orders
    }
}
