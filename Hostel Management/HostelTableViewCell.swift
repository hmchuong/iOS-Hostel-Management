//
//  HostelTableViewCell.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/2/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import UIKit

class HostelTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var hostelIDLabel: UILabel!
    @IBOutlet weak var hostelAddressLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
