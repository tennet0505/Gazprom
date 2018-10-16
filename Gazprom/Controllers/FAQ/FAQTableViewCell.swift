//
//  FAQTableViewCell.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/16/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit

class FAQTableViewCell: UITableViewCell {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var buttonLabel: UIButton!
    @IBOutlet weak var constraint: NSLayoutConstraint!
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func buttonTap(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if !sender.isSelected{
            
            self.constraint.constant = 0
            buttonLabel.setImage(UIImage(named: "downArrow"), for: .normal)
        }else{
            self.constraint.constant = heightForView(text: answerLabel.text ?? "NoAnswer", width: 200)
            buttonLabel.setImage(UIImage(named: "upArrow"), for: .normal)
        }
    }
    
    func heightForView(text:String, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }

    
}
