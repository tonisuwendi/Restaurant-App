//
//  DetailPresenter.swift
//  Restoranku
//
//  Created by mac on 25/11/20.
//

import SwiftUI

class DetailPresenter: ObservableObject {
    
    private let detailUseCase: DetailUseCase
    
    @Published var restaurant: RestaurantModel
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
        restaurant = detailUseCase.getRestaurant()
    }
    
}
