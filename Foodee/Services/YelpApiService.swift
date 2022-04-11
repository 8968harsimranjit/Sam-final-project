//
//  YelpApiService.swift
//  Foodee
//
//  Created by user210897 on 4/10/22.
//

import Foundation
import CoreLocation
import Combine

let apiKey = "iAMPhKSoNYklemW2XUuwRsWLPvirt5xdfhr37DR8OH6-vNct5EdzV6_SGD7F0TX_Gw6WHnbPoHCWWJSmyR292EHEy5kio-Nydz9-EUEZIyiuHuorGnXOWmSFrJhTYnYx"

struct YelpApiService {
    //search term, user location, category       //output to update list
    var search: (String, CLLocation, String?) -> AnyPublisher<SearchResult, Never>
}

extension YelpApiService{
    static let live = YelpApiService {term, location,cat in
        
        var urlComponents = URLComponents(string: "https://api.yelp.com")!
        urlComponents.path = "/v3/businesses/search"
        urlComponents.queryItems = [
            .init(name: "term", value: term),
            .init(name: "longitude", value: String(location.coordinate.longitude)),
            .init(name: "latitude", value: String(location.coordinate.latitude)),
            .init(name: "categories", value: cat)
        ]
        let url = urlComponents.url!
        var request = URLRequest(url:url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        //URL request and return
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: SearchResult.self, decoder: JSONDecoder())
            .replaceError(with: .init(businesses: <#[Business]#>))
            .eraseToAnyPublisher()
    }
}

// MARK - SearchResult

struct SearchResult: Codable{
    let businesses: [Business]
}

// MARK: - Business
struct Business: Codable {
    let rating: Int?
    let price, phone, id, alias: String?
    let isClosed: Bool?
    let categories: [Category]?
    let reviewCount: Int?
    let name: String?
    let url: String?
    let coordinates: Coordinates?
    let imageURL: String?
    let location: Location?
    let distance: Double?
    let transactions: [String]?

    enum CodingKeys: String, CodingKey {
        case rating, price, phone, id, alias
        case isClosed = "is_closed"
        case categories
        case reviewCount = "review_count"
        case name, url, coordinates
        case imageURL = "image_url"
        case location, distance, transactions
    }
}

// MARK: - Category
struct Category: Codable {
    let alias, title: String?
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: Double?
}

// MARK: - Location
struct Location: Codable {
    let city, country, address2, address3: String?
    let state, address1, zipCode: String?

    enum CodingKeys: String, CodingKey {
        case city, country, address2, address3, state, address1
        case zipCode = "zip_code"
    }
}

