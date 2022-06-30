//
//  MockOrderService.swift
//  FlowerShop
//
//  Created by andreea.ungureanu on 30.06.2022.
//

import Foundation

protocol MockOrderServiceProtocol {
    func readJsonFile(forFileName fileName: String) -> Data?
    func parseJsonData(jsonData: Data) -> [Order]?
}

struct MockOrderService: MockOrderServiceProtocol {
    
    static let shared = MockOrderService()
    
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
}
