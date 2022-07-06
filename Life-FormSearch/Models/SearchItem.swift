//
//  SearchItem.swift
//  Life-FormSearch
//
//  Created by Vladimir Pisarenko on 05.07.2022.
//

import Foundation

struct SearchItem: Codable {
    var id: Int
    var scientificName: String
    var commonName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case scientificName = "title"
        case commonName = "content"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: CodingKeys.id)
        scientificName = try values.decode(String.self, forKey: CodingKeys.scientificName)
        commonName = try values.decode(String.self, forKey: CodingKeys.commonName)
    }
}

struct SearchResponse: Codable {
    let results: [SearchItem]
}
