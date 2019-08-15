//
//  PersonalViewController+ViewFactory.swift
//  ResumeBuilder
//
//  Created by Sachin Ajit Patil on 09/07/19.
//  Copyright © 2019 Sachin. All rights reserved.
//

import UIKit

extension PersonalViewController:UIFactoryProtocol {
    // MARK: Build view from UIFactory
    func buildViews(target:UITapGestureRecognizer) -> [UIView] {
        userImageView =  makeImageView(size: CGSize(width: 200, height: 200), target: target)
        firstName = makeTextField(size: CGSize(width: personalInfoScrollView.frame.width, height: 50), text: "Enter first name", keyboadType: UIKeyboardType.default)
        firstName?.delegate = self
        lastName = makeTextField(size: CGSize(width: personalInfoScrollView.frame.width, height: 50), text: "Enter last name", keyboadType: UIKeyboardType.default)
        lastName?.delegate = self
        phoneNumner = makeTextField(size: CGSize(width: personalInfoScrollView.frame.width, height: 50), text: "Enter phone number", keyboadType: UIKeyboardType.phonePad)
        phoneNumner?.delegate = self
        emailId = makeTextField(size: CGSize(width: personalInfoScrollView.frame.width, height: 50), text: "Enter email Id", keyboadType: UIKeyboardType.emailAddress)
        emailId?.delegate = self
        addressLine1 = makeTextField(size: CGSize(width: personalInfoScrollView.frame.width, height: 50), text: "Enter address Line 1", keyboadType: UIKeyboardType.default)
        addressLine1?.delegate = self
        addressLine2 = makeTextField(size: CGSize(width: personalInfoScrollView.frame.width, height: 50), text: "Enter address Line 2", keyboadType: UIKeyboardType.default)
        addressLine2?.delegate = self
        dateOfBirth = makeTextField(size: CGSize(width: personalInfoScrollView.frame.width, height: 50), text: "Select DOB.", keyboadType: UIKeyboardType.default)
        dateOfBirth?.delegate = self
        yearOfExperiece = makeTextField(size: CGSize(width: personalInfoScrollView.frame.width, height: 50), text: "Enter year of experiece.", keyboadType: UIKeyboardType.numberPad)
        yearOfExperiece?.delegate = self
        skillSetWorked = makeTextField(size: CGSize(width: personalInfoScrollView.frame.width, height: 50), text: "Enter skill set.", keyboadType: UIKeyboardType.default)
        skillSetWorked?.delegate = self
        primaryEducationMarks = makeTextField(size: CGSize(width: personalInfoScrollView.frame.width, height: 50), text: "Enter primary education marks.", keyboadType: UIKeyboardType.numberPad)
        primaryEducationMarks?.delegate = self
        secondaryEducationMarks = makeTextField(size: CGSize(width: personalInfoScrollView.frame.width, height: 50), text: "Enter secondary education marks.", keyboadType: UIKeyboardType.numberPad)
        secondaryEducationMarks?.delegate = self
        higherEducationMarks = makeTextField(size: CGSize(width: personalInfoScrollView.frame.width, height: 50), text: "Enter higher education marks.", keyboadType: UIKeyboardType.numberPad)
        higherEducationMarks?.delegate = self
        return [
            userImageView,
            firstName as Any,
            lastName as Any,
            phoneNumner as Any,
            emailId as Any,
            addressLine1 as Any,
            addressLine2 as Any,
            dateOfBirth as Any,
            yearOfExperiece as Any,
            skillSetWorked as Any,
            primaryEducationMarks as Any,
            secondaryEducationMarks as Any,
            higherEducationMarks as Any
            ].flatMap({$0}) as! [UIView]
    }
    
    func showDatePicker() {
        // DatePicker
        datePicker = makeDatePicker(view: self.view)
        
        // Add an event to call onDidChangeDate function when value is changed.
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        view.addSubview(datePicker)
        
        // ToolBar
        toolBar = makeToolBar(view: self.view)
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        view.addSubview(toolBar)
        toolBar.isHidden = false
        datePicker.isHidden = false
        
    }
}

// MARK: TextField Delegate methods.
extension PersonalViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        personalInfoScrollView.contentOffset = CGPoint(x: 0, y: 0)
        let point = textField.frame.origin//CGPoint(x: 0, y: textField.frame.origin.y + 100)
        personalInfoScrollView.contentOffset = point
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailId {
            if (emailId?.text?.isValidEmail() ?? false) {
                return
            } else {
                textField.becomeFirstResponder()
                showAlert(message: "Enter valid email id")
            }
        }
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == dateOfBirth {
            dismissKeyboard()
            showDatePicker()
            return false
        }
        cancelClick()
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == phoneNumner || textField == primaryEducationMarks || textField == secondaryEducationMarks || textField == higherEducationMarks || textField == yearOfExperiece)
        {
            var maxLength = 2 //To restrict only to enter 2 numberss
            if (textField == phoneNumner) {
                maxLength = 10 //To restrict only to enter 10 numberss
            }
            //To restrict only to enter 10 numberss
            guard let text  = textField.text else { return true }
            let currentString: NSString = text as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        personalInfoScrollView.contentOffset = CGPoint(x: 0, y: 0)
        textField.resignFirstResponder()
        return true
    }
}

extension PersonalViewController: PersonalViewProtocol {
    // MARK: load View With Saved or FetchedData
    func loadViewWithSavedorFetchedData(info: PersonalInfo?) {
        if let info = info {
            firstName?.text = info.firstName
            lastName?.text = info.lastName
            phoneNumner?.text = info.phoneNumner
            emailId?.text = info.emailId
            addressLine1?.text = info.addressLine1
            addressLine2?.text = info.addressLine2
            dateOfBirth?.text = info.dateOfBirth
            yearOfExperiece?.text = info.yearOfExperiece
            skillSetWorked?.text = info.skillSetWorked
            primaryEducationMarks?.text = info.primaryEducationMarks
            secondaryEducationMarks?.text = info.secondaryEducationMarks
            higherEducationMarks?.text = info.higherEducationMarks
            guard let url = URL(string: info.userImage) else {return}
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    if let imageData = data {
                        self.userImageView.image = UIImage(data: imageData)
                    } else {
                        self.userImageView.image = UIImage(contentsOfFile: info.userImage)
                    }
                    
                }
            }
        }
    }
}

