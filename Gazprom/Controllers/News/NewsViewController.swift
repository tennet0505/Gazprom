//
//  NewsViewController.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/12/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

     var arrayOfNews = ["News 1", "News2", "News3"]
     var arrayOfDateNews = ["date1", "date2", "date3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
       
    }
}



extension NewsViewController: UITableViewDelegate, UITableViewDataSource{
  
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        cell.labelTitle.text = arrayOfNews[indexPath.row]
        cell.labelDate.text = arrayOfDateNews[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "NewsDescriptionViewController") as! NewsDescriptionViewController
     
        vc.lblTitle = arrayOfNews[indexPath.row]
        vc.lblDate = arrayOfDateNews[indexPath.row]
    
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
