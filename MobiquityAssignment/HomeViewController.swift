//
//  HomeViewController.swift
//  MobiquityAssignment
//
//  Created by MAC on 16/08/21.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    let homeViewModel = HomeViewModel()
    var searchAddressArray = [Location](){
        didSet{
            DispatchQueue.main.async {
                self.tableViewOutlet.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.homeVC = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchAddressArray = homeViewModel.fetchDataFromDB()
        
    }
}

extension HomeViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchAddressArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell", for: indexPath) as! AddressTableViewCell
        cell.location = self.searchAddressArray[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CityScreenViewController") as? CityScreenViewController
        vc?.selectedAddress = self.searchAddressArray[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
extension HomeViewController: CellSubclassDelegate{
    func buttonTapped(cell: AddressTableViewCell) {
        guard let indexPath = self.tableViewOutlet.indexPath(for: cell) else {return}
        self.searchAddressArray = DatabaseHelper.shareInstance.deleteData(index: indexPath.row)
    }
    
    
}
extension HomeViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        if searchText == ""{
            searchAddressArray = homeViewModel.fetchDataFromDB()
        }else{
            self.searchAddressArray = (homeViewModel.addressArray?.filter { ($0.address?.contains(searchText))!})!
        }
    }
}
