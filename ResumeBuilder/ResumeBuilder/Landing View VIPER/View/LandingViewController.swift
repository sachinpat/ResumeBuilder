//
//  LandingViewController.swift
//  ResumeBuilder
//
//  Created by Sachin Ajit Patil on 08/07/19.
//  Copyright © 2019 Sachin. All rights reserved.
//

import UIKit

// This class display catagory of resume.
class LandingViewController: UIViewController {
    
    @IBOutlet weak var catagoryTableView: UITableView!
    let cellId = StringConstant().kIndexCell
    var dashboardOptions = [StringConstant().kPersonalInformation,    StringConstant().kEducation,StringConstant().kPastProject,StringConstant().kPersonalInformation,StringConstant().kAdditionalInfo]
    var presenterDelegate: LandingPresenterProtocol?
    
    //Mark:- View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = StringConstant().kLanding
        catagoryTableView.accessibilityIdentifier = StringConstant().kCatagoryTableView
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark:- Alert for user to give information.
    func showAlert(message:String) {
        let alert = UIAlertController(title: StringConstant().kUnderDevelopment, message: message, preferredStyle: .alert)
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

//Mark:- UITableViewDataSource methods
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

//Mark:- UITableViewDelegate methods
extension LandingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            presenterDelegate?.navigateToPersonal()
        } else {
            showAlert(message: StringConstant().kUnderDevelopmentMessage)
        }
        
    }
}

