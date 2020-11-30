//
//  HomePresenter.swift
//  Restoranku
//
//  Created by mac on 25/11/20.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {
    
    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase
    
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var restaurants: [RestaurantModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func getRestaurants() {
        loadingState = true
        homeUseCase.getRestaurants()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { restaurants in
                self.restaurants = restaurants
            })
            .store(in: &cancellables)
    }
    
    func linkBuilder<Content: View>(
        for restaurant: RestaurantModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: router.makeDetailView(for: restaurant)) { content() }
    }
    
}
