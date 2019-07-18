//
//  ViewController.swift
//  ResumeBuilder
//
//  Created by Sachin Ajit Patil on 08/07/19.
//  Copyright © 2019 Sachin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.backgroundColor = .blue
        self.title = "Home"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - - Button action
    //Action : This action will push Landing view and fetch data from server
    @IBAction func fetchSaved(_ sender: Any) {
        DataHolder.sharedInstance.fetchSaved = 0
        pushView()
    }
    
    //Action : This action will push Landing view to create new Resume
    @IBAction func onNewResumeClick(_ sender: Any) {
        DataHolder.sharedInstance.fetchSaved = 1
        pushView()
    }
    
    // MARK: - - Create next view and push
    fileprivate func pushView() {
        let landingViewController =  LandingViewController()
        let presenter = LandingPresenter()
        let router = LandingRouter(view: landingViewController)
        presenter.routerDelegate = router
        landingViewController.presenterDelegate = presenter
        self.navigationController?.pushViewController(landingViewController, animated: true)
    }
    
}

