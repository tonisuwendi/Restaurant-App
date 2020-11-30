//
//  RestaurantModel.swift
//  Restoranku
//
//  Created by mac on 25/11/20.
//

import Foundation

struct RestaurantModel: Equatable, Identifiable {
    
    let id: String
    let name: String
    let description: String
    let city: String
    let picture: String
    let rating: Double
    
}
