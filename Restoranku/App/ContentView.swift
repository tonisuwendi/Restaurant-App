//
//  ContentView.swift
//  Restoranku
//
//  Created by mac on 25/11/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var homePresenter: HomePresenter
    
    var body: some View {
        TabView {
            NavigationView {
                HomeView(presenter: homePresenter)
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            NavigationView {
                FavoriteView()
            }
            .tabItem {
                Image(systemName: "heart.fill")
                Text("Favorite")
            }
            NavigationView {
                HomeView(presenter: homePresenter)
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            NavigationView {
                AboutView()
            }
            .tabItem {
                Image(systemName: "person.circle")
                Text("About")
            }
        }
        .accentColor(.green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
