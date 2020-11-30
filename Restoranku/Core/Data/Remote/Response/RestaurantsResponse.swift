//
//  RestaurantsResponse.swift
//  Restoranku
//
//  Created by mac on 25/11/20.
//

import Foundation

struct RestaurantsResponse: Decodable {
    
    let restaurants: [RestaurantResponse]
    
}

struct RestaurantResponse: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case city = "city"
        case picture = "pictureId"
        case rating = "rating"
    }
    
    let id: String?
    let name: String?
    let description: String?
    let city: String?
    let picture: String?
    let rating: Double?
    
}
