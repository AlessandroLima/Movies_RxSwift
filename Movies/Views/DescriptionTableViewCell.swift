//
//  DescriptionTableViewCell.swift
//  Movies
//
//  Created by alessandro on 08/10/19.
//  Copyright © 2019 alessandro. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblDuration:UILabel!
    @IBOutlet weak var lblRelease_year:UILabel!
    @IBOutlet weak var lblOverview:UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


