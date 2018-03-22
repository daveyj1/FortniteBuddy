//
//  StreamCell.swift
//  FortniteAPI
//
//  Created by Joseph Davey on 3/22/18.
//  Copyright © 2018 Joseph Davey. All rights reserved.
//

import UIKit

class StreamCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var viewerLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
