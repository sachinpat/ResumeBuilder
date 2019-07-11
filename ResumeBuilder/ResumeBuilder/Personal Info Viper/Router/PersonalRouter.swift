//
//  PersonalRouter.swift
//  ResumeBuilder
//
//  Created by Sachin Ajit Patil on 10/07/19.
//  Copyright © 2019 Sachin. All rights reserved.
//

import UIKit

class PersonalRouter: NSObject {
    let view:PersonalViewController?
    init(view:PersonalViewController ) {
        self.view = view
    }
}

extension PersonalRouter:PersonalRouterProtocol {
    func pushToShowPdfView(personalModel:PersonalInfo) {
        let previewViewController = PreviewViewController()
        previewViewController.invoiceInfo = personalModel
        view?.navigationController?.pushViewController(previewViewController, animated: true)
    }
    
    
}
