//
//  ViewController.swift
//  Registration form
//
//  Created by Agstya Technologies on 22/10/19.
//  Copyright © 2019 Mayur. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate{
    //MARK:- Outlets
    @IBOutlet weak var txtFname: UITextField!
    @IBOutlet weak var txtLname: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var datePickerDOB: UIDatePicker!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    var activeField: UITextField?
    
    //MARK:- View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldDelegate()
        keyBoardAddObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        keyBoardRemoveObserver()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissKeyboard()
    }
    
    //MARK:- IBAction
    @IBAction func onBtnSubmitClick(_ sender: UIButton) {
        validateField()
    }
    
    //MARK:- Other Method
    func textFieldDelegate() {
        txtFname.delegate = self
        txtLname.delegate = self
        txtEmail.delegate = self
        txtPassword.delegate = self
        txtConfirmPassword.delegate = self
    }
    
    func keyBoardAddObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(aNotification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(aNotification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func keyBoardRemoveObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func validateField() {
        if isValidName(nameStr: txtFname.text!) != true {
            alertPopUp(aleartMessage: "Please Enter Valid First Name!")
        } else if isValidName(nameStr: txtLname.text!) != true {
            alertPopUp(aleartMessage: "Please Enter Valid Last Name!")
        } else if isValidEmail(emailStr: txtEmail.text!) != true {
            alertPopUp(aleartMessage: "Please Enter Valid Email Address!")
        } else if txtPassword.text == "" {
            alertPopUp(aleartMessage: "Please Enter Password")
        } else if txtConfirmPassword.text == "" {
            alertPopUp(aleartMessage: "Please Confirm Password")
        } else if txtPassword.text != txtConfirmPassword.text {
            alertPopUp(aleartMessage: "Password Does not Match!")
        }
    }
    
    func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    func isValidName(nameStr:String) -> Bool {
        let nameRegEx = "[A-Za-z]{2,64}"
        let namePred = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return namePred.evaluate(with: nameStr)
    }
    
    func alertPopUp(aleartMessage :String) {
        self.dismissKeyboard()
        let alert = UIAlertController(title: "Mandatory Field", message: aleartMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK ", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK:- TextField Delegate Methods
extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeField = textField
        return true;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillBeHidden(aNotification: NSNotification) {
        let contentInsets: UIEdgeInsets = .zero
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillShow(aNotification: NSNotification) {
        var info = aNotification.userInfo!
        let kbSize = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        var aRect: CGRect = self.view.frame
        aRect.size.height -= kbSize.height
        if !aRect.contains(activeField!.frame.origin) {
            self.scrollView.scrollRectToVisible(activeField!.frame, animated: true)
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

