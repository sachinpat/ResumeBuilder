//
//  PersonalPresentor.swift
//  ResumeBuilder
//
//  Created by Sachin Ajit Patil on 10/07/19.
//  Copyright © 2019 Sachin. All rights reserved.
//

import UIKit

class PersonalPresentor: NSObject {
    var view: PersonalViewController?
    var routerDelegate: PersonalRouterProtocol?
    var interactorDelegate: PersonalInteractorProtocol?
}

extension PersonalPresentor: PersonalPresenterProtocol {
    func loadViewWithData(info: PersonalInfo?) {
        DispatchQueue.main.async {
            self.view?.loadViewWithSavedorFetchedData(info: info)
        }
        
    }
    
    func saveData(info: PersonalInfo) {
        interactorDelegate?.saveData(info: info)
    }
    
    func navigateToPersonal() {
        if let personalModel = interactorDelegate?.getDataFromLocalData() {
            routerDelegate?.pushToShowPdfView(personalModel: personalModel)
        }
    }
    
    func getModelClass()  {
        interactorDelegate?.getModelClass()
    }
    
    
}
