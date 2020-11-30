//
//  RemoteDataSource.swift
//  Restoranku
//
//  Created by mac on 25/11/20.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: class {
    
    func getRestaurants() -> AnyPublisher<[RestaurantResponse], Error>
    
}

final class RemoteDataSource: NSObject {
    
    private override init() { }
    
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
    
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func getRestaurants() -> AnyPublisher<[RestaurantResponse], Error> {
        return Future<[RestaurantResponse], Error> { completion in
            if let url = URL(string: Endpoints.Gets.restaurants.url) {
                AF.request(url).validate().responseDecodable(of: RestaurantsResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value.restaurants))
                    case .failure:
                        completion(.failure(URLError.invalidResponse))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
}
