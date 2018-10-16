//
//  PayDescriptionsViewController.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/12/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit
import AlamofireImage

class PayDescriptionsViewController: UIViewController {

    let serverUrl = "https://puppit.spalmalo.com"
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var img = ""
    var descriptionPayment = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlStringFull = "\(serverUrl)\(img)"
        if let urlImg = URL(string: urlStringFull ) {
            imageLogo.af_setImage(withURL: urlImg)
        }
        descriptionTextView.text = descriptionPayment
        
    }
    

   

}
