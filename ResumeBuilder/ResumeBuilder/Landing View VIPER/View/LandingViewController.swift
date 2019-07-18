//
//  LandingViewController.swift
//  ResumeBuilder
//
//  Created by Sachin Ajit Patil on 08/07/19.
//  Copyright © 2019 Sachin. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    @IBOutlet weak var catagoryTableView: UITableView!
    let cellId = "indexCell"
    var dashboardOptions = ["Personal Information","Education","Topics of Knowledge","Past Project","Current/latest Company Details","Additional Info"]
    var presenterDelegate: LandingPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Landing"
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark:- Alert after incorect data
    func showAlert(message:String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }
}

extension LandingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dashboardOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = UITableViewCell.init(style: .default, reuseIdentifier: cellId)
        tableViewCell.textLabel?.text = dashboardOptions[indexPath.row]
        return tableViewCell
    }
}

extension LandingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            presenterDelegate?.navigateToPersonal()
        } else {
            showAlert(message: "Under Development. Use Personal Information.")
        }
        
    }
}

