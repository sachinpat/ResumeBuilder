//
//  PersonalInterface.swift
//  ResumeBuilder
//
//  Created by Sachin Ajit Patil on 10/07/19.
//  Copyright © 2019 Sachin. All rights reserved.
//

import UIKit

protocol PersonalPresenterProtocol {
    func navigateToPersonal()
    func getModelClass()
    func saveData(info:PersonalInfo)
    func loadViewWithData(info:PersonalInfo?) 
}

protocol PersonalRouterProtocol {
    func pushToShowPdfView(personalModel:PersonalInfo)
}

protocol PersonalInteractorProtocol {
    func saveData(info: PersonalInfo)
    func getModelClass()
    func getDataFromLocalData() -> PersonalInfo?
}

protocol PersonalViewProtocol {
    func loadViewWithSavedorFetchedData(info: PersonalInfo?)
}


