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
        case itemsFromSearchNotFound
        case itemsFromPageAPINotFound
        case itemsFromHierarchyAPINotFound
        case imageDataMissing
    }
    
    func fetchItemsFromSearch(matching query: [String : String]) async throws -> [SearchItem] {
        
        var urlComponents = URLComponents(string: "https://eol.org/api/search/1.0.json")!
        urlComponents.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw SearchItemError.itemsFromSearchNotFound
        }
        let decoder = JSONDecoder()
        let searchResponse =  try decoder.decode(SearchResponse.self, from: data)
        
        return searchResponse.results
    }
    
    func fetchItemFromPageAPI(with id: Int, matching query: [String : String]) async throws -> TaxonConcept {
        
        var urlComponents = URLComponents(string: "https://eol.org/api/pages/1.0/" + String(id) + ".json")!
        urlComponents.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        print(urlComponents.url)
        
        let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw SearchItemError.itemsFromPageAPINotFound
        }
        let decoder = JSONDecoder()
        let details = try decoder.decode(PageApiResponse.self, from: data)
        
        return details.taxonConcept
    }
    
    func fetchItemFromHierarchyAPI(with id: Int, matching query: [String : String]) async throws -> HierarchyAPIResponse {
        
        let urlComponents = URLComponents(string: "https://eol.org/api/hierarchy_entries/1.0/" + "String(\(id))" + ".json?language=en")!
        
        let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw SearchItemError.itemsFromHierarchyAPINotFound
        }
        data.prettyPrintedJSONString()
        
        let decoder = JSONDecoder()
        let searchResponse = try decoder.decode(HierarchyAPIResponse.self, from: data)
        
        return searchResponse
        
    }
    
    func fetchImageFromPageAPI(from url: URL) async throws -> UIImage {
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
                  throw SearchItemError.imageDataMissing
              }
        guard let image = UIImage(data: data) else {
            throw SearchItemError.imageDataMissing
        }
        return image
    }

}
