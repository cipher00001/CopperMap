//
//  SearchVC.swift
//  SureshRewarCopperDemo
//
//  Created by Suresh Rewar on 30/07/21.
//

import UIKit
import GooglePlaces

protocol UpDateMarkerOnMap {
    func upDateMarkerOnMap(coordinate:CLLocationCoordinate2D?)
}

class SearchVC: UIViewController {
    lazy var srchVM: SearchVM = {
        return SearchVM()
    }()

    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    var delegateUpdateMarker:UpDateMarkerOnMap?

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName:Constants.SearchCell.rawValue, bundle: nil), forCellReuseIdentifier: Constants.SearchCell.rawValue)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        searchController?.searchResultsUpdater = self
    }
}



extension SearchVC:UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        srchVM.searchStr = searchController.searchBar.text ?? ""
        srchVM.findPlaces {[weak self](err) in
            guard let self  =  self else{
                return
            }
            if err == nil{
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
    }
}


extension SearchVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return srchVM.results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.SearchCell.rawValue, for: indexPath) as! SearchCell
        cell.placeName.text = srchVM.results[indexPath.row].name
        cell.favUnfavBtn.tag  = indexPath.row
        cell.favUnFav = {[weak self](tag, isSelected) in
            guard let self = self else {
                return
            }
            if isSelected{
                (UIApplication.shared.delegate as! AppDelegate).fav.removeAll(where:{$0.place_id == self.srchVM.results[tag].place_id})
                (UIApplication.shared.delegate as! AppDelegate).fav.append(self.srchVM.results[tag])
            }else{
                (UIApplication.shared.delegate as! AppDelegate).fav.removeAll(where:{$0.place_id == self.srchVM.results[tag].place_id})
            }
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchController?.isActive = false
            delegateUpdateMarker?.upDateMarkerOnMap(coordinate: CLLocationCoordinate2D(latitude: srchVM.results[indexPath.row].geometry.location.lat, longitude: srchVM.results[indexPath.row].geometry.location.lng))
    }
}



