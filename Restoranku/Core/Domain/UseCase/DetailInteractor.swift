//
//  DetailInteractor.swift
//  Restoranku
//
//  Created by mac on 25/11/20.
//

import Foundation

protocol DetailUseCase {
    
    func getRestaurant() -> RestaurantModel
    
}

class DetailInteractor: DetailUseCase {
    
    private let repository: RestaurantRepositoryProtocol
    private let restaurant: RestaurantModel
    
    required init(
        repository: RestaurantRepositoryProtocol,
        restaurant: RestaurantModel
    ) {
        self.repository = repository
        self.restaurant = restaurant
    }
    
    func getRestaurant() -> RestaurantModel {
        return restaurant
    }
    
}
