//
//  ProductService.swift
//  digioStore
//
//  Created by Raduchiu Amaral on 26/05/24.
//

import Foundation

enum StoreServiceError: Error {
    case invalidURL
    case noData
}

class ProductService {
    func fetchProducts(completion: @escaping (Result<StoreResponse, Error>) -> Void){
        guard let URL = URL(string: "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox/products") else {
            completion(.failure(StoreServiceError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: URL) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(StoreServiceError.noData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(StoreResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
