//
//  HomeVC.swift
//  SureshRewarCopperDemo
//
//  Created by Suresh Rewar on 30/07/21.
//

import UIKit
import GoogleMaps
import GooglePlaces
class HomeMapVC: UIViewController{
    lazy var search: SearchVC = {
        return SearchVC()
    }()
    
    lazy var gmsMarker: GMSMarker = {
        let marker = GMSMarker()
        marker.icon = UIImage(named: "marker")
        return marker
    }()
    var searchController: UISearchController?    
    
    @IBOutlet weak var mapView: GMSMapView!
    fileprivate func setupView() {
        searchController = UISearchController(searchResultsController: search)
        search.searchController = self.searchController
        search.delegateUpdateMarker = self
        let subView = UIView(frame: CGRect(x: 0, y: self.view.safeAreaInsets.top+20, width: self.view.frame.width, height: 45.0))
        searchController?.searchBar.barTintColor = .black
        subView.addSubview((searchController?.searchBar)!)
        view.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(updateMarker), name: NSNotification.Name(rawValue: Constants.updateMarkerNotification.rawValue), object: nil)
    }
    @objc func updateMarker(noftification:Notification){
        if let data = noftification.userInfo?["latLng"] as? Location {
            upDateMarkerOnMap(coordinate:CLLocationCoordinate2D(latitude:data.lat, longitude: data.lat))
         }
    }
}

extension HomeMapVC:UpDateMarkerOnMap{
    func upDateMarkerOnMap(coordinate: CLLocationCoordinate2D?) {
        gmsMarker.position = coordinate!
        gmsMarker.map = self.mapView
        self.mapView.animate(to: GMSCameraPosition(latitude:(coordinate?.latitude)!, longitude:(coordinate?.longitude)!, zoom: 14))
    }
}
