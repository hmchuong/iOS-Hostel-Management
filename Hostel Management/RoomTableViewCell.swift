//
//  RoomTableViewCell.swift
//  Hostel Management
//
//  Created by Huỳnh Minh Chương on 1/15/17.
//  Copyright © 2017 chuonghuynh. All rights reserved.
//

import UIKit

class RoomTableViewCell: UITableViewCell {
    // MARK: - Properties
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var roomArea: UILabel!
    @IBOutlet weak var roomPrice: UILabel!
    @IBOutlet weak var roomState: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
