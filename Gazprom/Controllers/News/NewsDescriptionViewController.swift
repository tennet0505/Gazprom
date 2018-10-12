//
//  NewsDescriptionViewController.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/12/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit

class NewsDescriptionViewController: UIViewController {
    
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var DescriptionTextView: UITextView!
    
    var lblTitle = ""
    var lblDate = ""
    var descriptionNews = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelTitle.text = lblTitle
        labelDate.text = lblDate
        DescriptionTextView.text = descriptionNews
       
    }
    
}
