//
//  LifeFormItem.swift
//  Life-FormSearch
//
//  Created by Vladimir Pisarenko on 05.07.2022.
//

import Foundation
import UIKit

struct PageApiResponse: Codable {
    let taxonConcept: TaxonConcept
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.taxonConcept = try container.decode(TaxonConcept.self, forKey: CodingKeys.taxonConcept)
    }
}

struct TaxonConcept: Codable {
    
    var scientificName: String
    var taxonConcepts: [TaxonConcepts]
    var dataObjects: [DataObjects]?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.scientificName = try container.decode(String.self, forKey: CodingKeys.scientificName)
        self.taxonConcepts = try container.decode([TaxonConcepts].self, forKey: CodingKeys.taxonConcepts)
        self.dataObjects = try container.decode([DataObjects].self, forKey: CodingKeys.dataObjects)
    }
}

struct TaxonConcepts: Codable {
    
    var identifier: Int
    var scientificName: String
    var nameAccordingTo: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.identifier = try container.decode(Int.self, forKey: CodingKeys.identifier)
        self.scientificName = try container.decode(String.self, forKey: CodingKeys.scientificName)
        self.nameAccordingTo = try container.decode(String.self, forKey: CodingKeys.nameAccordingTo)
    }
}

struct DataObjects: Codable {

    var mimeType: String
    var license: String?
    var rightsHolder: String?
    var eolMediaURL: String
    var agents: [Agents]?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mimeType = try container.decode(String.self, forKey: CodingKeys.mimeType)
        self.license = try container.decode(String.self, forKey: CodingKeys.license)
        self.rightsHolder = try container.decode(String.self, forKey: CodingKeys.rightsHolder)
        self.eolMediaURL = try container.decode(String.self, forKey: CodingKeys.eolMediaURL)
        self.agents = try container.decode([Agents].self, forKey: CodingKeys.agents)
    }
}

struct Agents: Codable {
    
    var fullName: String
    var role: String
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case role
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fullName = try container.decode(String.self, forKey: CodingKeys.fullName)
        self.role = try container.decode(String.self, forKey: CodingKeys.role)
    }
}
