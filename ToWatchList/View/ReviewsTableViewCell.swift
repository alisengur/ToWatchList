//
//  ReviewsTableViewCell.swift
//  ToWatchList
//
//  Created by Ali Şengür on 31.08.2020.
//  Copyright © 2020 Ali Şengür. All rights reserved.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCell(author: String, content: String) {
        print("author : \(author)\ncontent : \(content)")
        self.authorLabel.text = author
        self.contentLabel.text = content
    }
    
}
