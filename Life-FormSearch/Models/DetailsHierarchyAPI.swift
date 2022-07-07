//
//  DetailsHierarchyAPI.swift
//  Life-FormSearch
//
//  Created by Vladimir Pisarenko on 07.07.2022.
//

import Foundation

struct HierarchyAPIResponse: Codable {
    var nameAccordingTo: String
    var ancestors: [Ancestors]
}

struct Ancestors: Codable {
    var source: String
    var taxonConceptID: Int
    var taxonID: Int
    var sourceIdentifier: String
    var taxonRank: String
    var parentNameUsageID: Int
    var scientificName: String
}
