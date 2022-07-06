//
//  SearchItem.swift
//  Life-FormSearch
//
//  Created by Vladimir Pisarenko on 05.07.2022.
//

import Foundation

struct SearchItem: Codable {
    var id: Int
    var title: String
    var content: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "scientificName"
        case content = "commonName"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: CodingKeys.id)
        title = try values.decode(String.self, forKey: CodingKeys.title)
        content = try values.decode(String.self, forKey: CodingKeys.content)
    }
}

struct SearchResponse: Codable {
    let results: [SearchItem]
}
