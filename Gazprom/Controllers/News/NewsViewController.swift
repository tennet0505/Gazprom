//
//  NewsViewController.swift
//  Gazprom
//
//  Created by Oleg Ten on 10/12/18.
//  Copyright © 2018 Oleg Ten. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD


class NewsViewController: UIViewController {
    
    var arrayOfNews = [NewsModel]()
    var personal = [PersonalModel]()
    let client = ApiClient()
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getOffices()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    func getOffices() {
        SVProgressHUD.show()
        arrayOfNews.removeAll()
        
        if UserDefaults.standard.string(forKey: "auth_token") != nil {
            client.getNews(successHandler: { (value) in
                
                let array = value
                for news in array {
                    self.arrayOfNews.append(news)
                }
                self.tableView.reloadData()
                SVProgressHUD.dismiss()
                print(self.arrayOfNews)
            }) { (error) in
                print(error)
                SVProgressHUD.dismiss()
            }
        }
    }
    
//    func getPersonal() {
//        SVProgressHUD.show()
//        
//        client.getPersonal(successHandler: { (value) in
//            
//            let array = value
//            for personal in array {
//                self.personal.append(personal)
//                
//            }
//            SVProgressHUD.dismiss()
//            print(self.personal)
//            
//        }) { (error) in
//            print(error)
//            SVProgressHUD.dismiss()
//        }
//    }
    
    func formatDate(date: String) -> String {
       
        let dateString = ""
//
//        let dateFormater = DateFormatter()
//        let dateFormater1 = DateFormatter()
//
//        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm.sssZ"
//        let stringDate = dateFormater.date(from: date)
//        print(stringDate)
        
      //  2018-10-16T08:20:16.281Z
//        dateFormater1.dateFormat = "yyyy-MM-dd"
//        date1 = dateFormater1.date(from: stringDate)
//        dateString = dateFormater1.string(from: date1)
        
//        print(dateString)
//
       return dateString
        
    }
}



extension NewsViewController: UITableViewDelegate, UITableViewDataSource{
  
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfNews.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        cell.labelTitle.text = arrayOfNews[indexPath.row].title
        cell.labelDate.text = arrayOfNews[indexPath.row].created_at

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "NewsDescriptionViewController") as! NewsDescriptionViewController
     
        vc.lblTitle = arrayOfNews[indexPath.row].title ?? "No news"
        vc.lblDate = arrayOfNews[indexPath.row].created_at ?? "No news"
        vc.descriptionNews = arrayOfNews[indexPath.row].description ?? "No news"
    
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
