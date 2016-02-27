//
//  LoginSignUpViewController.swift
//  Timeline
//
//  Created by mac-admin on 2/27/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class LoginSignUpViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    
    enum ViewMode {
        case Login
        case Signup
        }
    
    var mode = ViewMode.Signup
    var fieldsAreValid: Bool {
        get {
            switch mode {
            case .Login:
                return !(emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty)
            case .Signup:
                return !(usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty || emailTextField.text!.isEmpty)
            }
        }
    }
    

 
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewBasedOnMode()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionButtonTapped(sender: AnyObject) {
        if fieldsAreValid {
            switch mode {
            case .Signup:
                UserController.createUser(emailTextField.text!, username: usernameTextField.text!, password: passwordTextField.text!, bio: bioTextField.text!, url: urlTextField.text!, completion: { (success, user) -> Void in
                    if success, let _ = user {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        self.presentValidationAlertWithTitle("Signup Unsuccessful", message: "Make sure all required fields are completed")
                    }
                })
            case .Login:
                UserController.authenticateUser(emailTextField.text!, password: passwordTextField.text!, completion: { (success, user) -> Void in
                    if success, let _ = user {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    } else {
                        self.presentValidationAlertWithTitle("Login Unsuccessful", message: "Email or password not recognized. Password or email fields can't be left blank.")
                    }
                })
            }
        }
    }
    
    
    func updateViewBasedOnMode() {
        switch mode {
        case .Login:
            usernameTextField.hidden = true
            bioTextField.hidden = true
            urlTextField.hidden = true
            actionButton.setTitle("Login", forState: .Normal)
        case .Signup:
            actionButton.setTitle("Signup", forState: .Normal)
            
            }
        }
    
    
func presentValidationAlertWithTitle(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    
    alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
    
    presentViewController(alert, animated: true, completion: nil)
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
