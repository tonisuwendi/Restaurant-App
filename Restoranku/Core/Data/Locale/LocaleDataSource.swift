//
//  LocaleDataSource.swift
//  Restoranku
//
//  Created by mac on 27/11/20.
//

import Foundation
import RealmSwift
import Combine

protocol LocaleDataSourceProtocol: class {
    
    func getRestaurants() -> AnyPublisher<[RestaurantEntity], Error>
    func addRestaurants(from restaurants: [RestaurantEntity]) -> AnyPublisher<Bool, Error>
}

final class LocaleDataSource: NSObject {
    
    private let realm: Realm?
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
        return LocaleDataSource(realm: realmDatabase)
    }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    
    func getRestaurants() -> AnyPublisher<[RestaurantEntity], Error> {
        return Future<[RestaurantEntity], Error> { completion in
            if let realm = self.realm {
                let restaurants: Results<RestaurantEntity> = {
                    realm.objects(RestaurantEntity.self)
                        .sorted(byKeyPath: "name", ascending: true)
                }()
                completion(.success(restaurants.toArray(ofType: RestaurantEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func addRestaurants(from restaurants: [RestaurantEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for restaurant in restaurants {
                            realm.add(restaurant, update: .all)
                        }
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
}

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
    
}
