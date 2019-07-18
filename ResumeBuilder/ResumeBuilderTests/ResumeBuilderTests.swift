//
//  ResumeBuilderTests.swift
//  ResumeBuilderTests
//
//  Created by Sachin Ajit Patil on 08/07/19.
//  Copyright © 2019 Sachin. All rights reserved.
//

import XCTest
@testable import ResumeBuilder

class ResumeBuilderTests: XCTestCase {
    
    var urlSession: URLSession!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        urlSession = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        urlSession = nil
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testLandingViewController() {
        let landingViewController = LandingViewController()
        XCTAssertNotNil(landingViewController.dashboardOptions)
        XCTAssertEqual(landingViewController.dashboardOptions.count, 6)
    }
    
    func testPersonalView()  {
        let personalViewController = PersonalViewController()
        DataHolder.sharedInstance.fetchSaved = 2
        //Fetch Data from  local
        personalViewController.presenterDelegate?.getModelClass()
        //Check if data is present in local data
        XCTAssertNotNil(personalViewController.personalModel)
        //Check if URL is working or not
        testValidCallToURLGetsHTTPStatusCode200()
        //Check data fetched and parsed successfully
        DataHolder.sharedInstance.fetchSaved = 0
        personalViewController.presenterDelegate?.getModelClass()
        //Check if data is present From url
        XCTAssertNotNil(personalViewController.personalModel)
    }
    
    // Asynchronous test: success fast, failure slow
    func testValidCallToURLGetsHTTPStatusCode200() {
        // given
        let url =
            URL(string: "https://api.jsonbin.io/b/5d27724f0e09805769fec4da/1")
        // 1
        let promise = expectation(description: "Status code: 200")
        
        // when
        let dataTask = urlSession.dataTask(with: url!) { data, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 5)
    }
    
    func testGetImageFromLocal() {
        //Check image path is available or not
        XCTAssertNotNil(DataHolder.sharedInstance.getImage(imageName: "Profile"))
    }
    
}

