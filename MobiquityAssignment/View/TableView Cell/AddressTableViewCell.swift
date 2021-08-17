//
//  AddressTableViewCell.swift
//  MobiquityAssignment
//
//  Created by MAC on 16/08/21.
//

import UIKit

protocol CellSubclassDelegate: class {
    func buttonTapped(cell: AddressTableViewCell)
}

class AddressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblAddressOutlet: UILabel!
    
    weak var delegate: CellSubclassDelegate?
    
    var location: Location!{
        didSet{
            lblAddressOutlet.text = location.address
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        self.delegate?.buttonTapped(cell: self)
    }

}
