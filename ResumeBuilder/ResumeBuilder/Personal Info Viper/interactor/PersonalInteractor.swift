//
//  PersonalInteractor.swift
//  ResumeBuilder
//
//  Created by Sachin Ajit Patil on 10/07/19.
//  Copyright © 2019 Sachin. All rights reserved.
//

import UIKit

class PersonalInteractor: NSObject {
    var presenterDelegate:PersonalPresenterProtocol?
    let url = "https://api.jsonbin.io/b/5d27724f0e09805769fec4da/1"
    
    //MARK: - Create Profile json file and save
    func saveUploadedFilesSet(fileName:PersonalInfo) {
        do {
            let jsonData = try JSONEncoder().encode(fileName)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
            if let path = Bundle.main.path(forResource: "Profile", ofType: ".json") {
                // and decode it back
                let pathAsURL = URL(fileURLWithPath: path)
                do {
                    try jsonString.write(to: pathAsURL, atomically: true, encoding: .utf8)
                }
                
            }
            
        } catch {
            print(error)
            
        }
    }
    
    //MARK: - Get Data From Local Json
    func getDataFromLocalJson() -> PersonalInfo? {
        
        if let path = Bundle.main.path(forResource: "Profile", ofType: ".json") {
            // and decode it back
            let pathAsURL = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: pathAsURL, options: .alwaysMapped)
                let peronalInfoModel = try JSONDecoder().decode(PersonalInfo.self, from: data)
                return peronalInfoModel
            }catch {
                print(error)
                
            }
        }
        return nil
    }
}

extension PersonalInteractor: PersonalInteractorProtocol {
    func saveData(info: PersonalInfo) {
        saveUploadedFilesSet(fileName: info)
    }
    
    func getDataFromLocalData() -> PersonalInfo? {
        return getDataFromLocalJson()
    }
    
    func getModelClass()  {
        //Fetch from local
        if DataHolder.sharedInstance.fetchSaved ==  2 {
            presenterDelegate?.loadViewWithData(info: getDataFromLocalData())
            return
        }
        //Fetch from server
        let resumeWebServiceHandler = ResumeWebServiceHandler()
        resumeWebServiceHandler.getProfileDataFromServer(url: URL.init(string: url)!, completion:({[weak self](data:PersonalInfo?, error:Error?) in
            if let personaInfo = data {
                self?.presenterDelegate?.loadViewWithData(info: personaInfo)
            }else {
                //No data saved in server
                if let _ = error{
                    print("Error while Fetching - Initial Load")
                    self?.presenterDelegate?.loadViewWithData(info: self?.getDataFromLocalData())
                }
            }}))
    }
    
    
}

