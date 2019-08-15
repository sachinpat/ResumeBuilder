//
//  ResumeBuilderUITests.swift
//  ResumeBuilderUITests
//
//  Created by Sachin Ajit Patil on 08/07/19.
//  Copyright © 2019 Sachin. All rights reserved.
//

import XCTest

class ResumeBuilderUITests: XCTestCase {
    var resumeBuilder:XCUIApplication?
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func launchApp() {
        resumeBuilder = XCUIApplication()
        resumeBuilder?.launch()
        
        resumeBuilder?.buttons["create"].tap()
        let articleTableView = resumeBuilder?.tables["catagoryTableView"]
        
        XCTAssertTrue((articleTableView?.exists)!, "The catagoryTableView tableview exists")
        
        // Get an array of cells
        if let tableCells = articleTableView?.cells {
            if tableCells.count > 0 {
                let tableCell = tableCells.element(boundBy: 0)
                tableCell.tap()
                
            } else {
                XCTAssert(false, "Was not able to find any table cells")
            }
        }
        addPeronalDetails()
       
    }
    
    func addPeronalDetails() {
        let name = resumeBuilder?.textFields["Enter first name"]
        let wait = name?.waitForExistence(timeout: 10)
        XCTAssert(wait == true)
        name?.tap()
        name?.typeText("Sachin")
        let lastName = resumeBuilder?.textFields["Enter last name"]
        let wait1 = lastName?.waitForExistence(timeout: 10)
        XCTAssert(wait1 == true)
        lastName?.tap()
        lastName?.typeText("Patil")
        let phone = resumeBuilder?.textFields["Enter phone number"]
        let wait2 = phone?.waitForExistence(timeout: 10)
        XCTAssert(wait2 == true)
        phone?.tap()
        phone?.typeText("9665305220")
        let email = resumeBuilder?.textFields["Enter email Id"]
        email?.tap()
        email?.typeText("sachin.patil@gmail.com")
        let address1 = resumeBuilder?.textFields["Enter address Line 1"]
        address1?.tap()
        address1?.typeText("Madhuvanti A 303")
        let address2 = resumeBuilder?.textFields["Enter address Line 2"]
        address2?.tap()
        address2?.typeText("Pune Maharashtra")
        let DOB = resumeBuilder?.textFields["Select DOB."]
        DOB?.tap()
        let datePickers = XCUIApplication().datePickers
        datePickers.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "March")
        datePickers.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "29")
        datePickers.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "1988")
        
        XCUIApplication().navigationBars.buttons.element(boundBy: 1).tap()
        
    }
    
    func testExample() {
        launchApp()
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}

