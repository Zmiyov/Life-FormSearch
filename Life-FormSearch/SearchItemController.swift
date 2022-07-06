//
//  SearchItemController.swift
//  Life-FormSearch
//
//  Created by Vladimir Pisarenko on 06.07.2022.
//

import Foundation
import UIKit

class SearchItemController {
    
    enum SearchItemError: Error, LocalizedError {
        case itemsNotFound
    }
    
    func fetchItems(matching query: [String : String]) async throws -> [SearchItem] {
        
        var urlComponents = URLComponents(string: "https://eol.org/api/search/1.0.json")!
        urlComponents.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw SearchItemError.itemsNotFound
        }
        data.prettyPrintedJSONString()
        
        let decoder = JSONDecoder()
        let searchResponse =  try decoder.decode(SearchResponse.self, from: data)
        
        return searchResponse.results
    }
    

}
