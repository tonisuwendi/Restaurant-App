//
//  HomeInteractor.swift
//  Restoranku
//
//  Created by mac on 25/11/20.
//

import Foundation
import Combine

protocol HomeUseCase {
    
    func getRestaurants() -> AnyPublisher<[RestaurantModel], Error>
    
}

class HomeInteractor: HomeUseCase {
    
    private let repository: RestaurantRepositoryProtocol
    
    required init(repository: RestaurantRepositoryProtocol) {
        self.repository = repository
    }
    
    func getRestaurants() -> AnyPublisher<[RestaurantModel], Error> {
        return repository.getRestaurants()
    }
    
}
