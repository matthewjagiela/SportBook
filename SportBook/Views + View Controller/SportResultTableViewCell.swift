//
//  SportResultCellTableViewCell.swift
//  SportBook
//
//  Created by Matthew Jagiela on 4/24/21.
//

import UIKit

class SportResultTableViewCell: UITableViewCell {

    @IBOutlet weak var headline: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
