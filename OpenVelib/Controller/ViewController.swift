//
//  ViewController.swift
//  OpenVelib
//
//  Created by Salomé Russier on 29/06/2018.
//  Copyright © 2018 Salomé Russier. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableViewStation: UITableView!
    var stations : [Station] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewStation.delegate = self
        tableViewStation.dataSource = self
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewStation.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StationCell
        let station = stations[indexPath.row]
        cell.nameLabel.text = "(\(station.number) - \(station.name)"
        cell.statusLabel.text = station.status
        cell.availableLabel.text = "\(station.availableBike)/\(station.availableBikeStands)"
        cell.lastUpdateLabel.text = "Depuis \(station.lastUpdate)"
        return cell
    }
    
    func refreshAllTableView(){
        
        let api = APIController()
        
        var result = api.getStation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

