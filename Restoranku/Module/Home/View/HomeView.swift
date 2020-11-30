//
//  HomeView.swift
//  Restoranku
//
//  Created by mac on 25/11/20.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var presenter: HomePresenter
    
    var body: some View {
        ZStack {
            if presenter.loadingState {
                VStack {
                    Text("Loading..")
                    ActivityIndicator()
                }
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(
                        self.presenter.restaurants,
                        id: \.id
                    ) { restaurant in
                        ZStack {
                            self.presenter.linkBuilder(for: restaurant) {
                                RestaurantRow(restaurant: restaurant)
                            }.buttonStyle(PlainButtonStyle())
                        }.padding(10)
                    }
                }
            }
        }.onAppear {
            if self.presenter.restaurants.count == 0 {
                self.presenter.getRestaurants()
            }
        }.navigationBarTitle(
            Text("Restoranku"),
            displayMode: .automatic
        )
    }
    
}
