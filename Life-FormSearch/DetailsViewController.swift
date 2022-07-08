//
//  DetailsViewController.swift
//  Life-FormSearch
//
//  Created by Vladimir Pisarenko on 05.07.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet var image: UIImageView!
    @IBOutlet var rightLabel: UILabel!
    @IBOutlet var urlLicence: UILabel!
    @IBOutlet var taxonomySource: UILabel!
    @IBOutlet var scientificName: UILabel!
    @IBOutlet var kingdomLabel: UILabel!
    @IBOutlet var phylumLabel: UILabel!
    @IBOutlet var classLabel: UILabel!
    @IBOutlet var orderLabel: UILabel!
    @IBOutlet var familyLabel: UILabel!
    @IBOutlet var genusLabel: UILabel!
    
    let searchItem: SearchItem
    var pageAPIItem = [TaxonConcept]()
    var hierarchyAPIItem = [HierarchyAPIResponse]()
    let searchItemController = SearchItemController()
    
    init?(coder:NSCoder, searchItem: SearchItem) {
        self.searchItem = searchItem
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPageAPIItem()
 //       fetchHierarchyAPIItem()
        
    }
    
    func updateUI() {
        
        guard let dataObject = pageAPIItem[0].dataObjects?[0] else { return }

        if let rights = dataObject.rightsHolder {
            rightLabel.text = rights
        } else {
            rightLabel.text = ((dataObject.agents?[0].role) ?? "") + ", " + (dataObject.agents?[0].fullName ?? "")
        }
        urlLicence.text = dataObject.license
        
        taxonomySource.text = pageAPIItem[0].taxonConcepts[0].nameAccordingTo
        scientificName.text = pageAPIItem[0].taxonConcepts[0].scientificName
        
        
//        let ancestors = hierarchyAPIItem[0].ancestors
//        for taxonRank in ancestors {
//            if taxonRank.taxonRank == "kingdom" {
//                kingdomLabel.text = taxonRank.scientificName
//            } else if taxonRank.taxonRank == "phylum" {
//                phylumLabel.text = taxonRank.scientificName
//            } else if taxonRank.taxonRank == "class" {
//                classLabel.text = taxonRank.scientificName
//            } else if taxonRank.taxonRank == "order" {
//                orderLabel.text = taxonRank.scientificName
//            } else if taxonRank.taxonRank == "family" {
//                familyLabel.text = taxonRank.scientificName
//            } else if taxonRank.taxonRank == "genus" {
//                genusLabel.text = taxonRank.scientificName
//            }
//        }
        
        guard let imageURL = URL(string: dataObject.eolMediaURL) else { return }
        Task.init {
            if let imageItem = try? await searchItemController.fetchImageFromPageAPI(from: imageURL) {
                image.image = imageItem
            }
        }
    }
    
    func fetchPageAPIItem() {
        
        let pageId = searchItem.id
        let query = ["taxonomy" : "true", "images_per_page" : "1", "language" : "1"]
        
        Task {
            do {
                let fetchedPageAPIDetails = try await searchItemController.fetchItemFromPageAPI(with: pageId, matching: query)
                pageAPIItem.append(fetchedPageAPIDetails)
                updateUI()
            } catch {
                print("Error fetching pageAPIItem data \(error)")
            }
        }
    }
    
    func fetchHierarchyAPIItem() {
        
        let hierarchyId = pageAPIItem[0].taxonConcepts[0].identifier
        let query = ["cache_ttl" : ""]
        
        Task {
            do {
                let fetchedHierarchyAPIDetails = try await searchItemController.fetchItemFromHierarchyAPI(with: hierarchyId, matching: query)
                hierarchyAPIItem.append(fetchedHierarchyAPIDetails)
                updateUI()
            } catch {
                print("Error fetching hierarchyAPIItem data \(error)")
            }
        }
    }
}
