//
//  APIRequest.swift
//  SportBook
//
//  Created by Matthew Jagiela on 4/24/21.
//

import Foundation
import Combine

enum APIError: Error {
    case decodingError
    case error(Error)
    case genericError
}

class APIRequest {
    
    let endpoint = URL(string: "https://ancient-wood-1161.getsandbox.com/results")
    
    func getSportResults() -> Future<Results, APIError> {
        return Future { promise in
            if let endpoint = self.endpoint {
                var networkRequest = URLRequest(url: endpoint)
                networkRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                networkRequest.httpMethod = "POST"
                URLSession.shared.dataTask(with: networkRequest){ data, _, error in
                    if let error = error {
                        promise(.failure(.error(error)))
                    } else {
                        if let fetchedData = data {
                            let decoder = JSONDecoder()
                            do {
                                let results = try decoder.decode(Results.self, from: fetchedData)
                                promise(.success(results))
                            } catch {
                                promise(.failure(.decodingError))
                            }
                            
                        } else {
                            promise(.failure(.genericError))
                        }
                    }
                }.resume()
                
                
            }
            
        }
    }
    
}
