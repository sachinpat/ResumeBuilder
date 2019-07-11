//
//  LandingPresenter.swift
//  ResumeBuilder
//
//  Created by Sachin Ajit Patil on 08/07/19.
//  Copyright © 2019 Sachin. All rights reserved.
//

import UIKit

class LandingPresenter: NSObject {
    var routerDelegate: LandingRouterProtocol?
}

extension LandingPresenter: LandingPresenterProtocol {
    func navigateToPersonal() {
        routerDelegate?.pushToPersonal()
    }
    
    
}
