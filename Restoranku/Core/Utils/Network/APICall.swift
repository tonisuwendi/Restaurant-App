//
//  APICall.swift
//  Restoranku
//
//  Created by mac on 25/11/20.
//

import Foundation

struct API {
    
    static let baseUrl = "https://restaurant-api.dicoding.dev/"
    
}

protocol Endpoint {
    
    var url: String { get }
    
}

enum Endpoints {
    
    enum Gets: Endpoint {
        case restaurants
        case detail
        case search
        case smallPicture
        case mediumPicture
        case largePicture
        
        public var url: String {
            switch self {
            case .restaurants: return "\(API.baseUrl)list"
            case .detail: return "\(API.baseUrl)detail/"
            case .search: return "\(API.baseUrl)search?q="
            case .smallPicture: return "\(API.baseUrl)images/small/"
            case .mediumPicture: return "\(API.baseUrl)images/medium/"
            case .largePicture: return "\(API.baseUrl)images/large/"
            }
        }
    }
    
}
