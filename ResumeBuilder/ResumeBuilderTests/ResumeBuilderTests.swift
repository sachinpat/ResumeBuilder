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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
         let promise = expectation(description: "Status code: 200")
        let resumeWebServiceHandler = ResumeWebServiceHandler()
        guard let url = URL.init(string: StringConstant().kURL) else { return }
        resumeWebServiceHandler.getProfileDataFromServer(url: url, completion:({(data:PersonalInfo?, error:Error?) in
            if let personaInfo = data {
                XCTAssertNotNil(personaInfo)
                promise.fulfill()
            }else {
                //No data saved in server
                if let error = error{
                    XCTFail("Error: \(error.localizedDescription)")
                }
            }}))
        wait(for: [promise], timeout: 5)

    }
    
    func testGetImageFromLocal() {
        //Check image path is available or not
        XCTAssertNotNil(DataHolder.sharedInstance.getImage(imageName: "Profile"))
    }
    
}

