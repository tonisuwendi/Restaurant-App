//
//  RestaurantList+CoreDataProperties.swift
//  Restoranku
//
//  Created by Toni Suwendi on 28/11/20.
//
//

import Foundation
import CoreData

extension RestaurantList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RestaurantList> {
        return NSFetchRequest<RestaurantList>(entityName: "RestaurantList")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var city: String?
    @NSManaged public var picture: String?
    @NSManaged public var rating: Double
    
    var wrappedId: String {
        id ?? "Unknow"
    }
    
    var wrapperName: String {
        name ?? "Unknow"
    }
    
    var wrapperDesc: String {
        desc ?? "Unknow"
    }
    
    var wrapperCity: String {
        city ?? "Unknow"
    }
    
    var wrapperPicture: String {
        picture ?? "Unknow"
    }
    
    var wrapperRating: Double {
        rating
    }

}

extension RestaurantList : Identifiable {

}
