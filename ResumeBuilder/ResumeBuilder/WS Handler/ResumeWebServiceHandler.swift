//
//  ResumeWebServiceHandler.swift
//  ResumeBuilder
//
//  Created by Sachin Ajit Patil on 11/07/19.
//  Copyright © 2019 Sachin. All rights reserved.
//

import UIKit


class ResumeWebServiceHandler: NSObject {
    
    func getProfileDataFromServer(url: URL, completion: @escaping (PersonalInfo?, Error?) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print(error!)
                completion(nil,error)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                completion(nil,error)
                return
            }
            do {
                let peronalInfoModel = try JSONDecoder().decode(PersonalInfo.self, from: responseData)
                print(peronalInfoModel)
                completion(peronalInfoModel, nil)
            } catch {
                completion(nil,error)
                print("Error in parsing")
            }
            
        }
        task.resume()
    }
}
