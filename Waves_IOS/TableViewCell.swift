//
//  TableViewCell.swift
//  Waves_iOS
//
//  Created by Захар on 07.08.17.
//  Copyright © 2017 Ronnie. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pointerImage: UIImageView!
    
    override func awakeFromNib() {
        pointerImage.image = UIImage(named:"pointerForMenu.png")
    }
    
}
