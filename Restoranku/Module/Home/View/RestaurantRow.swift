//
//  RestaurantRow.swift
//  Restoranku
//
//  Created by mac on 25/11/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct RestaurantRow: View {
    
    var restaurant: RestaurantModel
    var pictureImg = "https://restaurant-api.dicoding.dev/images/small"
    var body: some View {
        VStack(alignment: .leading) {
            pictureRestaurant
            content
        }
        .frame(width: UIScreen.main.bounds.width - 40)
    }
    
}

extension RestaurantRow {
    
    var pictureRestaurant: some View {
        ZStack(alignment: .bottomLeading) {
            WebImage(url: URL(string: "\(pictureImg)/\(restaurant.picture)"))
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
                    Text(restaurant.city)
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
            Text(restaurant.name)
                .font(.title3)
            Text(restaurant.description)
                .font(.system(size: 16))
                .lineLimit(2)
                .foregroundColor(Color("mySecondaryColorCustom"))
        }
    }
    
}

struct RestaurantRow_Previews: PreviewProvider {
    
    static var previews: some View {
        let restaurant = RestaurantModel(id: "1", name: "Kafekita", description: "Kafekita adalah restoran yang sangat keren banget lohh, kamu wajib nyobain kafekita ini.", city: "Jakarta", picture: "https://restaurant-api.dicoding.dev/images/small/14", rating: 4.5)
        return RestaurantRow(restaurant: restaurant)
    }
    
}
