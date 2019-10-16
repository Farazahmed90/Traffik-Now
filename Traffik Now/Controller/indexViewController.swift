

import UIKit

class indexViewController: UIViewController, UITextFieldDelegate
{
    let dataConnection = Data()
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        roundButton(button: loginButton)
        roundButton(button: signupButton)
        roundTextField(textfield: emailTextField)
        roundTextField(textfield: passwordTextField)
        emailTextField.keyboardType = .emailAddress
        
        self.hideKeyboardWhenTappedAround()

        CheckInternet.Connection() ? print("Connected To Internet") : (makeAlert(message: "You are not connected to internet", clearTextBox: false))
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        login()
        return true
    }
    
    @IBAction func loginButton_Clicked(_ sender: Any)
    {
       login()
    }
    
    func login()
    {
        if emailTextField.text != "" && passwordTextField.text != ""
        {
            dataConnection.SignIn(emailTextField: emailTextField , passwordTextField: passwordTextField , completion:
                { message in
                    message == "Done" ? (self.performSegue(withIdentifier: "goToMenu", sender: self)) : self.makeAlert(message: "\(message)", clearTextBox: false)
            })
        }
        else
        {
            makeAlert(message: "No Data is provided", clearTextBox: false)
        }
    }
    
    @IBAction func signupButton_Clicked(_ sender: Any)
    {
        performSegue(withIdentifier: "goToSignup", sender: self)
    }
    
    //MARK:- To Make Button Round
    
    func roundButton(button: UIButton)
    {
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
    }
    
    //MARK:- To Make TextField Round
    
    func roundTextField(textfield:UITextField)
    {
        textfield.borderStyle = UITextField.BorderStyle.roundedRect
    }

    //MARK:- To Make Alert

    func makeAlert(message: String , clearTextBox: Bool)
    {
        let alert = UIAlertController(title: "Traffik Now", message: "\(message)", preferredStyle: .alert)
        let restartaction = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            if clearTextBox{
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
            }
        })
        alert.addAction(restartaction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        self.performSegue(withIdentifier: "goToLogin", sender: self)
    }
    
    
    
}

extension UIViewController
{
    //MARK:- To make the keyboard close on tap
    
    func hideKeyboardWhenTappedAround()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

   


