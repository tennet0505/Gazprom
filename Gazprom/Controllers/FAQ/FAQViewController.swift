//
//  FAQViewController.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/16/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit
import Alamofire


class FAQViewController: UIViewController {

    var arrayOfFAQ = [FAQModel]()
    let client = ApiClient()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        getFAQ()
        
    }
    
    func getFAQ() {
        client.getFAQ(successHandler: { (value) in
            
            let array = value
            for faq in array {
                self.arrayOfFAQ.append(faq)
                
            }
            self.tableView.reloadData()
            print(self.arrayOfFAQ)
        }) { (error) in
            print(error)
        }
    }
}

extension FAQViewController: UITableViewDelegate, UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfFAQ.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FAQTableViewCell
        cell.questionLabel.text = arrayOfFAQ[indexPath.row].question
        cell.answerLabel.text = arrayOfFAQ[indexPath.row].answer
        
        cell.buttonLabel.addTarget(self, action: #selector(FAQViewController.expandCollapse(sender:)), for: .touchUpInside)
        cell.questionLabel.layer.masksToBounds = true
        cell.questionLabel.layer.cornerRadius = 10
        cell.answerLabel.layer.masksToBounds = true
        cell.answerLabel.layer.cornerRadius = 10

        
        return cell
    }
    @objc func expandCollapse(sender:UIButton) {
        
        self.tableView.reloadData()
    }
    
   
}

