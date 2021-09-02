//
//  ArtistTableCell.swift
//  AdidevTech Project
//
//  Created by Emmanuel on 8/26/21.
//

import Foundation
import UIKit


class ArtistTableCell: UITableViewCell, UITableViewDelegate {
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            // add label to the cell. the height of the cell will automatically resize
            addSubview(label)
            label.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 15, paddingRight: 15, width: screenWidth, height: 0)
        }

        let label: UILabel = {
          let iv = UILabel()
            iv.textAlignment = .left
            iv.lineBreakMode = .byWordWrapping
            iv.sizeToFit()
            iv.numberOfLines = 0
            return iv
        }()
    
    }


