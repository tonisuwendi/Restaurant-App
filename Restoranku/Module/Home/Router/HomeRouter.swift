//
//  HomeRouter.swift
//  Restoranku
//
//  Created by mac on 25/11/20.
//

import SwiftUI

class HomeRouter {
    
    func makeDetailView(for restaurant: RestaurantModel) -> some View {
        let detailUseCase = Injection.init().provideDetail(restaurant: restaurant)
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        return DetailView(presenter: presenter)
    }
    
}
