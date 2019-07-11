//
//  LandingRouter.swift
//  ResumeBuilder
//
//  Created by Sachin Ajit Patil on 08/07/19.
//  Copyright © 2019 Sachin. All rights reserved.
//

import UIKit

class LandingRouter: NSObject {
    let view: LandingViewController?
    
    init(view:LandingViewController) {
        self.view = view
    }
}

extension LandingRouter:LandingRouterProtocol {
    func pushToPersonal() {
        let personalViewController = PersonalViewController()
        let presenter = PersonalPresentor()
        let interactor = PersonalInteractor()
        let router = PersonalRouter(view: personalViewController)
        interactor.presenterDelegate = presenter
        presenter.interactorDelegate = interactor
        presenter.view = personalViewController
        presenter.routerDelegate = router
        personalViewController.presenterDelegate = presenter
        self.view?.navigationController?.pushViewController(personalViewController, animated: true)
    }
}
