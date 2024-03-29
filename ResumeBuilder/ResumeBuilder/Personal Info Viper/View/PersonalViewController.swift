//
//  PersonalViewController.swift
//  ResumeBuilder
//
//  Created by Sachin Ajit Patil on 08/07/19.
//  Copyright © 2019 Sachin. All rights reserved.
//

import UIKit


class PersonalViewController: UIViewController {
    @IBOutlet weak var personalInfoScrollView: UIScrollView!
    
    var presenterDelegate:PersonalPresenterProtocol?
    var firstName:UITextField?
    var lastName: UITextField?
    var phoneNumner: UITextField?
    var emailId: UITextField?
    var addressLine1: UITextField?
    var addressLine2: UITextField?
    var dateOfBirth: UITextField?
    var yearOfExperiece: UITextField?
    var skillSetWorked: UITextField?
    var primaryEducationMarks: UITextField?
    var secondaryEducationMarks: UITextField?
    var higherEducationMarks: UITextField?
    var datePicker = UIDatePicker()
    var toolBar = UIToolbar()
    var userImageView = UIImageView().self
    var personalModel = PersonalInfo()
    
    // MARK: - View life cycle methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set up view intial view
        setUpInitialView()
        //Configure View from UIView Factory
        configureView()
        personalInfoScrollView.accessibilityIdentifier = "scrollView"
        if (DataHolder.sharedInstance.fetchSaved == 0 || DataHolder.sharedInstance.fetchSaved == 2) {
            //Fetch data from Server or Local
            presenterDelegate?.getModelClass()
            DataHolder.sharedInstance.fetchSaved = 1
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataHolder.sharedInstance.fetchSaved = 2
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        super.willMove(toParentViewController: parent)
        if parent == nil {
            presenterDelegate?.saveData(info: createPeronalInfoModel())
        }
    }
    
    // MARK: - Fill Personal Info model class from UI
    fileprivate func createPeronalInfoModel() -> PersonalInfo {
        personalModel = PersonalInfo()
        if let firstName = firstName?.text {
            personalModel.firstName = firstName
        }
        if let lastName = lastName?.text {
            personalModel.lastName = lastName
        }
        if let phoneNumner = phoneNumner?.text {
            personalModel.phoneNumner = phoneNumner
        }
        if let emailId = emailId?.text {
            personalModel.emailId = emailId
        }
        if let addressLine1 = addressLine1?.text {
            personalModel.addressLine1 = addressLine1
        }
        if let addressLine2 = addressLine2?.text {
            personalModel.addressLine2 = addressLine2
        }
        if let dateOfBirth = dateOfBirth?.text {
            personalModel.dateOfBirth = dateOfBirth
        }
        if let _ = userImageView.image {
            personalModel.userImage = DataHolder.sharedInstance.getImage(imageName: StringConstant().kProfileImage)
        }
        if let yearOfExperiece = yearOfExperiece?.text {
            personalModel.yearOfExperiece = yearOfExperiece
        }
        if let skillSetWorked = skillSetWorked?.text {
            personalModel.skillSetWorked = skillSetWorked
        }
        if let primaryEducationMarks = primaryEducationMarks?.text {
            personalModel.primaryEducationMarks = primaryEducationMarks
        }
        if let secondaryEducationMarks = secondaryEducationMarks?.text {
            personalModel.secondaryEducationMarks = secondaryEducationMarks
        }
        if let higherEducationMarks = higherEducationMarks?.text {
            personalModel.higherEducationMarks = higherEducationMarks
        }
        return personalModel
    }
    
    // MARK: - Set Up NavigationView
    fileprivate func setUpNavigationView() {
        let saveBarButtonItem = UIBarButtonItem.init(title: StringConstant().kShow, style: .done, target: self, action: #selector(saveSelector))
        self.navigationItem.rightBarButtonItem = saveBarButtonItem
        self.title = StringConstant().kPersonalInformation
    }
    
    fileprivate func setUpInitialView() {
        //Set up Navigation view
        setUpNavigationView()
        //set up scroll view
        personalInfoScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 1000)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        personalInfoScrollView.accessibilityIdentifier = "scrollView"
    }
    
    fileprivate func configureView() {
        setUpStackView()
    }
    
    // MARK: - Set Up Stack view
    fileprivate func setUpStackView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let views = buildViews(target: tapGestureRecognizer)
        let stackView = UIStackView()
        for view in views {
            stackView.addArrangedSubview(view)
        }
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        personalInfoScrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: personalInfoScrollView.leadingAnchor, constant: 18).isActive = true
        stackView.trailingAnchor.constraint(equalTo: personalInfoScrollView.trailingAnchor, constant: 8).isActive = true
        stackView.topAnchor.constraint(equalTo: personalInfoScrollView.topAnchor, constant: 8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: personalInfoScrollView.bottomAnchor, constant: 8).isActive = true
        
    }
    
    // MARK: - Save data locally.
    @objc func saveSelector() {
        presenterDelegate?.saveData(info: createPeronalInfoModel())
        presenterDelegate?.navigateToPersonal()
    }
    
    // MARK: - Dismiss Keyboard
    @objc func dismissKeyboard() {
        personalInfoScrollView.contentOffset = CGPoint(x: 0, y: 0)
        view.endEditing(true)
    }
    
    // MARK: - Show image picker
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        //        let tappedImage = tapGestureRecognizer.view as! UIImageView
        ImagePickerManager().pickImage(self) { image in
            //here is the image
            self.userImageView.image = image
            DataHolder.sharedInstance.saveImage(imageName: StringConstant().kProfileImage, image: image)
            
        }
    }
    // MARK:- Alert after incorect data
    func showAlert(message:String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    // MARK:- Tool bar button methods
    @objc func doneClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        //self.datePicker.resignFirstResponder()
        datePicker.isHidden = true
        toolBar.isHidden = true
    }
    
     @objc func cancelClick() {
        datePicker.isHidden = true
        toolBar.isHidden = true
    }
    
    // MARK:- datePickerValueChanged methods
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        // Apply date format
        let selectedDate: String = dateFormatter.string(from: sender.date)
        dateOfBirth?.text = selectedDate
    }
    
}



