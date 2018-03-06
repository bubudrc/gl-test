//
//  LoadItemsTableViewCell.swift
//  GL-Test
//
//  Created by Marcelo Perretta on 06/03/2018.
//  Copyright © 2018 MAWAPE. All rights reserved.
//

import UIKit

class LoadItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    
    var itemCell: Item? {
        didSet {
            if let item = itemCell {
                if let imageURL = item.imageURL {
                    itemImageView.downloadedFrom(link: imageURL)
                }
                
                itemTitleLabel.text = item.title
                itemDescriptionLabel.text = "\(getResumDescription(fromCompleteDescription: item.itemDescription ?? ""))."
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Private
    private func getResumDescription(fromCompleteDescription completeDescription: String) -> String {
        let splitedData = completeDescription.components(separatedBy: ".")
        return splitedData.first ?? ""
    }

}
