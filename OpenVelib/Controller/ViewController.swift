//
//  ViewController.swift
//  OpenVelib
//
//  Created by Salomé Russier on 29/06/2018.
//  Copyright © 2018 Salomé Russier. All rights reserved.
//

import UIKit
import ESPullToRefresh

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating{
    
    
    @IBOutlet weak var tableViewStation: UITableView!
    @IBOutlet weak var statusControl: UISegmentedControl!
    
    var stations : [Station] = []
    var selectedStatus: String = ""
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshAllTableView()
        
        self.tableViewStation.delegate = self
        self.tableViewStation.dataSource = self
        
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.tableViewStation.tableHeaderView = searchController.searchBar
        
        self.tableViewStation.es.addPullToRefresh {
            [unowned self] in
            self.refreshAllTableView()
            self.tableViewStation.es.stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
            self.tableViewStation.es.stopLoadingMore()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewStation.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StationCell
        let station = stations[indexPath.row]
        cell.nameLabel.text = "\(station.name!)"
        cell.statusLabel.text = station.status
        cell.availableLabel.text = "\(station.availableBike)/\(station.bikeStands)"
        cell.lastUpdateLabel.text = "Depuis \(station.lastUpdate!.toString()!)"
        return cell
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text != ""{
            stations = Station.shared.SearchByStatus(selectedStatus, research: searchController.searchBar.text!)
        }else{
            stations = Station.shared.getAll()
        }
         self.tableViewStation.reloadData()
    }
    
    
    @IBAction func statusChanged(_ sender: Any) {
        
        selectedStatus = statusControl.titleForSegment(at: statusControl.selectedSegmentIndex)!
        selectedStatus = selectedStatus == "All" ? "" : selectedStatus
        stations =  Station.shared.getByStatus(selectedStatus)
         self.tableViewStation.reloadData()
    }
    
    
    func refreshAllTableView(){
        let api = APIController()
        
        if(api.internetAcces()){
            let group = DispatchGroup()
            group.enter()
            
            api.getStation(group)
            group.notify(queue: .global()){
                self.stations = Station.shared.getAll()
                
                DispatchQueue.main.async {
                   self.tableViewStation.reloadData()
                }
                
            }
        }else{
            let alert = UIAlertController(title: "Hors ligne", message: "Attention, vous n'êtes pas connecté à internet, les données ne sont pas à jours", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func reloadTableView(){
        
        if(stations.count == 0 ){
            let alert = UIAlertController(title: "Attention", message: "LA recherche ne ramene aucun résultat", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            stations = Station.shared.getAll()
            searchController.searchBar.text = ""
            statusControl.selectedSegmentIndex = 0
        }
        
        self.tableViewStation.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

