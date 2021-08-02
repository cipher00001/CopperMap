//
//  FavouritesVC.swift
//  SureshRewarCopperDemo
//
//  Created by Suresh Rewar on 30/07/21.
//

import UIKit
import GoogleMaps
class FavouritesVC: UIViewController {

    @IBOutlet weak var tableVIew: UITableView!
    var delegateUpdateMarker:UpDateMarkerOnMap?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableVIew.register(UINib(nibName:Constants.SearchCell.rawValue, bundle: nil), forCellReuseIdentifier: Constants.SearchCell.rawValue)
        tableVIew.delegate = self
        tableVIew.dataSource = self
        tableVIew.tableFooterView = UIView()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tableVIew.reloadData()
    }
    
}

extension FavouritesVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (UIApplication.shared.delegate as! AppDelegate).fav.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.SearchCell.rawValue, for: indexPath) as! SearchCell
        cell.placeName.text = (UIApplication.shared.delegate as! AppDelegate).fav[indexPath.row].name
        cell.favUnfavBtn.tag  = indexPath.row
        cell.favUnfavBtn.setImage(UIImage(named: "select"), for: .normal)
        cell.favUnFav = {[weak self](tag, isSelected) in
                DispatchQueue.main.async {
                    let arr = (UIApplication.shared.delegate as! AppDelegate).fav
                    (UIApplication.shared.delegate as! AppDelegate).fav.removeAll(where:{$0.place_id == arr[tag].place_id})
                    self?.tableVIew.reloadData()
                }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userInfo = ["latLng":(UIApplication.shared.delegate as! AppDelegate).fav[indexPath.row].geometry.location]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.updateMarkerNotification.rawValue), object: self, userInfo: userInfo)
    }
}




