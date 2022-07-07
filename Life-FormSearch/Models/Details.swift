//
//  LifeFormItem.swift
//  Life-FormSearch
//
//  Created by Vladimir Pisarenko on 05.07.2022.
//

import Foundation
import UIKit

struct LifeFormItem {
    var image: UIImage?
    var taxonomySource: String
    var scientificName: String
    var kingdom: String
    var phylum: String
//    var class: String
    var order: String
    var family: String
    var genus: String
    
}

struct PageApiResponse: Codable {
    let taxonConcept: [TaxonConcept]
}

struct TaxonConcept: Codable {
//    var identifier: Int
    var scientificName: String
    var taxonConcepts: [TaxonConcepts]?
    var dataObjects: [DataObjects]?
}

struct TaxonConcepts: Codable {
    var identifier: Int
    var scientificName: String
//    var name: String
    var nameAccordingTo: String
//    var canonicalForm: String
//    var sourceIdentifier: String
}

struct DataObjects: Codable {
//    var identifier: String
//    var dataObjectVersionID: Int
//    var dataType: String
//    var dataSubtype: String
//    var vettedStatus: String
//    var mediumType: String
//    var dataRating: String
    var mimeType: String
//    var created: String
//    var modified: String
    var license: String?
//    var license_id: Int
    var rightsHolder: String?
//    var source: String
//    var mediaURL: String
    var eolMediaURL: String
//    var eolThumbnailURL: String
    var agents: [Agents]?
}

struct Agents: Codable {
    var full_name: String
//    var homepage: String?
    var role: String
}
