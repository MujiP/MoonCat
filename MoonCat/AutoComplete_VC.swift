//
//  AutoComplete_VC.swift
//  GoogleAutoComplete
//
//  Created by Yingsi Chu on 2019-11-13.
//  Copyright © 2019 Yingsi Chu. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class GoogleAutoComplete:UIViewController{
   
    var addressList = [GMSAutocompletePrediction]()
    lazy var filter: GMSAutocompleteFilter = {
           let filter = GMSAutocompleteFilter()
           filter.type = .address
           return filter
       }()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var SearchBar: UITextField!
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadUI(){
        tableView.tableFooterView = UIView()
    }
    
}

extension GoogleAutoComplete: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView:UITableView, numberOfRowsInSection NumRow:Int)->
        Int{
            return addressList.count
    }
    
    func tableView(_ tableView:UITableView, cellForRowAt RowatIndexP: IndexPath)->
        UITableViewCell{
            var cell = tableView.dequeueReusableCell(withIdentifier:"cell")
            if cell == nil{
                cell = UITableViewCell(style: .default, reuseIdentifier: "cell" )
            }
            cell?.textLabel?.attributedText =
                addressList[RowatIndexP.row].attributedFullText
            cell?.textLabel?.font = UIFont.systemFont(ofSize:16)
            return cell!
            
            
    }
        
    
}


//search functioality

extension GoogleAutoComplete:UITextFieldDelegate{
    func textField(_ textField: UITextField, range:NSRange, replaceString:String)->
        Bool{
            let searchStr = (textField.text! as NSString).replacingCharacters(in: range, with: replaceString)
            if searchStr == ""{
                self.addressList = [GMSAutocompletePrediction]()
            }
            else{
                GMSPlacesClient.shared().autocompleteQuery(searchStr, bounds: nil, filter: filter, callback:{(result, error) in
                    if result != nil && error == nil{
                        self.addressList=result!
                    }
                })
            }
            self.tableView.reloadData()
            return true
    }
}
