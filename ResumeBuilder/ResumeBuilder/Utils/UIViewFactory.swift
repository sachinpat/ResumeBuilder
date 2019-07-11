//
//  UIViewFactory.swift
//  ResumeBuilder
//
//  Created by Sachin Ajit Patil on 09/07/19.
//  Copyright © 2019 Sachin. All rights reserved.
//

import UIKit

protocol UIFactoryProtocol:UITextFieldDelegate {}
extension UIFactoryProtocol {
    func makeImageView(size:CGSize, target:UITapGestureRecognizer) -> UIImageView{
        let personalImageView = UIImageView()
        personalImageView.layer.borderWidth = 2.0
        personalImageView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        personalImageView.translatesAutoresizingMaskIntoConstraints = false
        personalImageView.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        personalImageView.widthAnchor.constraint(equalToConstant: size.width).isActive = true
//        personalImageView.leadingAnchor.constraint(equalTo: , constant: <#T##CGFloat#>
        personalImageView.isUserInteractionEnabled = true
        personalImageView.addGestureRecognizer(target)
        
        let tapLable = UILabel()
        tapLable.text = "Click hear"
        personalImageView.addSubview(tapLable)
        tapLable.translatesAutoresizingMaskIntoConstraints = false
        tapLable.centerXAnchor.constraint(equalTo: personalImageView.centerXAnchor).isActive = true
        tapLable.centerYAnchor.constraint(equalTo: personalImageView.centerYAnchor).isActive = true
        
        return personalImageView
    }
    
   
    
    func makeTextField(size:CGSize, text:String, keyboadType:UIKeyboardType) -> UITextField {
        let customTextField = UITextField()
        customTextField.placeholder = text
        customTextField.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedStringKey.foregroundColor:UIColor.darkGray])
        customTextField.keyboardType = keyboadType
        customTextField.layer.borderWidth = 1.0
        customTextField.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        customTextField.translatesAutoresizingMaskIntoConstraints = false
        customTextField.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        customTextField.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        return customTextField
    }
}

