//
//  FavoriteRow.swift
//  Restoranku
//
//  Created by mac on 27/11/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteRow: View {
    
    var restaurant: RestaurantList
    var pictureImg = "https://restaurant-api.dicoding.dev/images/small"
    
    var body: some View {
        VStack(alignment: .leading) {
            pictureRestaurant
            content
        }
        .frame(width: UIScreen.main.bounds.width - 40)
    }
    
}

extension FavoriteRow {
    
    var pictureRestaurant: some View {
        ZStack(alignment: .bottomLeading) {
            WebImage(url: URL(string: "\(pictureImg)/\(restaurant.picture ?? "")"))
                .resizable()
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width - 40, height: 180)
                .clipped()
                .cornerRadius(5)
            ZStack {
                HStack {
                    Image(systemName: "mappin.circle.fill")
                        .font(.system(size: 14))
                    Text(restaurant.city ?? "")
                        .bold()
                        .font(.system(size: 14))
                        .padding(.leading, -2)
                }
                .padding(.leading, 10)
                .padding(.bottom, 5)
                .padding(.trailing, 8)
                .padding(.top, 5)
                .background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(5)
            }
            .padding(.leading, 10)
            .padding(.bottom, 10)
        }
    }
    
    var content: some View {
        VStack(alignment: .leading) {
            Text(restaurant.name ?? "")
                .font(.title3)
            Text(restaurant.desc ?? "")
                .font(.system(size: 16))
                .lineLimit(2)
                .foregroundColor(Color("mySecondaryColorCustom"))
        }
    }
    
}

