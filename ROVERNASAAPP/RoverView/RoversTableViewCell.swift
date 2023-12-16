//
//  RoversTableViewCell.swift
//  ROVERNASAAPP
//
//  Created by Cristian guillermo Romero garcia on 04/12/23.
//

import UIKit

class RoversTableViewCell: UITableViewCell {

    //MARK: OUTLETS
    @IBOutlet weak var roverImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var cameraNameLabel: UILabel!
    @IBOutlet weak var earthDateLabel: UILabel!
    @IBOutlet weak var roverLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
