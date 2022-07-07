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
    var pageAPIItem: TaxonConcept
    var hierarchyAPIItem: HierarchyAPIResponse
    
    let hierarchyAPIDetails: PageApiResponse
    
    init?(coder:NSCoder, searchItem: SearchItem) {
        self.searchItem = searchItem
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        
    }
    
    func fetchPageAPIItem() {
        
        let pageId = searchItem.id
        let query = ["taxonomy" : "true", "images_per_page" : "1", "language" : "1"]
        
        Task {
            do {
                let fetchedPageAPIDetails = try await searchItemController.fetchItemFromPageAPI(with: pageId, matching: query)
                self.pageAPIItem = fetchedPageAPIDetails
            } catch {
                print("Error fetching data \(error)")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
