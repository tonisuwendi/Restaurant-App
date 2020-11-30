//
//  Injection.swift
//  Restoranku
//
//  Created by mac on 25/11/20.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
    
    private func provideRepository() -> RestaurantRepositoryProtocol {
        
        let realm = try? Realm()
        let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        return RestaurantRepository.sharedInstance(locale, remote)
        
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideDetail(restaurant: RestaurantModel) -> DetailUseCase {
        let repository = provideRepository()
        return DetailInteractor(repository: repository, restaurant: restaurant)
    }
    
}
