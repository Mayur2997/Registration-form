//
//  ViewController.swift
//  Registration form
//
//  Created by Agstya Technologies on 22/10/19.
//  Copyright © 2019 Mayur. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    //MARK:- Outlets
    @IBOutlet weak var txtFname: UITextField!
    @IBOutlet weak var txtLname: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var datePickerDOB: UIDatePicker!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- IBAction
    @IBAction func onBtnSubmitClick(_ sender: UIButton) {
        checkTxtNilorNot()
        matchPassword()
        if isValidEmail(emailStr: txtEmail.text!) != true {
            alertPopUp(aleartMessage: "Please Enter Valid Email Address!")
        }
        
    }
    
    //MARK:- Other Method
    func checkTxtNilorNot() {
        if txtFname.text == "" {
            alertPopUp(aleartMessage: "Please Enter First Name")
        } else if txtLname.text == "" {
            alertPopUp(aleartMessage: "Please Enter Last Name")
        } else if txtEmail.text == "" {
            alertPopUp(aleartMessage: "Please Enter Email Address")
        } else if txtPassword.text == "" {
            alertPopUp(aleartMessage: "Please Enter Password")
        } else if txtConfirmPassword.text == "" {
            alertPopUp(aleartMessage: "Please Confirm Password")
        }
    }
    
    func matchPassword() {
        if txtPassword.text != txtConfirmPassword.text {
            alertPopUp(aleartMessage: "Password Does not Match!")
        }
    }
    
    func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    func alertPopUp(aleartMessage :String) {
        let alert = UIAlertController(title: "Mandatory Field", message: aleartMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
