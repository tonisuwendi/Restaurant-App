//
//  RestaurantEntity.swift
//  Restoranku
//
//  Created by mac on 27/11/20.
//

import Foundation
import RealmSwift

class RestaurantEntity: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var city: String = ""
    @objc dynamic var picture: String = ""
    @objc dynamic var rating: Double = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
