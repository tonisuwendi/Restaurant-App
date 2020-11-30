//
//  RestaurantMapper.swift
//  Restoranku
//
//  Created by mac on 25/11/20.
//

final class RestaurantMapper {
    
    static func mapRestaurantResponsesToDomains(
        input restaurantResponses: [RestaurantResponse]
    ) -> [RestaurantModel] {
        
        return restaurantResponses.map { result in
            return RestaurantModel(id: result.id ?? "", name: result.name ?? "", description: result.description ?? "", city: result.city ?? "", picture: result.picture ?? "", rating: result.rating ?? 0)
        }
    }
    
    static func mapRestaurantResponsesToEntities(
        input restaurantResponses: [RestaurantResponse]
    ) -> [RestaurantEntity] {
        return restaurantResponses.map { result in
            let newRestaurant = RestaurantEntity()
            newRestaurant.id = result.id ?? ""
            newRestaurant.name = result.name ?? "Unknow"
            newRestaurant.desc = result.description ?? "Unknow"
            newRestaurant.city = result.city ?? "Unknow"
            newRestaurant.picture = result.picture ?? "Unknow"
            newRestaurant.rating = result.rating ?? 0
            return newRestaurant
        }
    }
    
    static func mapRestaurantEntitiesToDomains(
        input restaurantEntities: [RestaurantEntity]
    ) -> [RestaurantModel] {
        return restaurantEntities.map { result in
            return RestaurantModel(id: result.id, name: result.name, description: result.desc, city: result.city, picture: result.picture, rating: result.rating)
        }
    }
    
}
