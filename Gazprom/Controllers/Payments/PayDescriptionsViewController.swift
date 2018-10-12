//
//  PayDescriptionsViewController.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/12/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit

class PayDescriptionsViewController: UIViewController {

    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var img = ""
    var descriptionPayment = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageLogo.image = UIImage(named: img)
        descriptionTextView.text = descriptionPayment
        
    }
    

   

}
