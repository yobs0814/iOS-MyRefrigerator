//
//  MyTableViewCell.swift
//  secondProject
//
//  Created by YOSEPH NOH on 2018. 6. 11..
//  Copyright © 2018년 YOSEPH NOH. All rights reserved.
//

import UIKit



class MyTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblExpiredDate: UILabel!

    @IBOutlet weak var lblCnt: UILabel!
    

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }


}
