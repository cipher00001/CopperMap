//
//  SearchCell.swift
//  SureshRewarCopperDemo
//
//  Created by Suresh Rewar on 30/07/21.
//

import UIKit




class SearchCell: UITableViewCell {

    @IBOutlet weak var favUnfavBtn: UIButton!
    @IBOutlet weak var placeName: UILabel!
    var favUnFav:((_ tag:Int, _ isSelected:Bool)->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        favUnfavBtn.setImage(UIImage(named:"unselect" ), for: .normal)
    }
    
    @IBAction func favUnFav(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            favUnfavBtn.setImage(UIImage(named:"select" ), for: .normal)
        }else{
            favUnfavBtn.setImage(UIImage(named:"unselect" ), for: .normal)
        }
        favUnFav!(sender.tag, sender.isSelected)
        
    }
}
