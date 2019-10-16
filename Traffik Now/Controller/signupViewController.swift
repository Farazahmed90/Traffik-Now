

import UIKit

class signupViewController: UIViewController,UITextFieldDelegate {

    let dataConnection = Data()
    var checkBox = false
    @IBOutlet weak var alreadyButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var retypeTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        roundButton(button: alreadyButton)
        roundButton(button: signupButton)
        roundTextField(textfield: emailTextField)
        roundTextField(textfield: passwordTextField)
        roundTextField(textfield: retypeTextField)
       
        emailTextField.keyboardType = .emailAddress
    
        self.hideKeyboardWhenTappedAround()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        signUP()
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK:- SignUp Button
    @IBAction func signupButton_Clicked(_ sender: Any)
    {
        signUP()
    }
    
    func signUP()
    {
        if emailTextField.text != "" && passwordTextField.text != "" && retypeTextField.text != "" && checkBox != false{
            if passwordTextField.text == retypeTextField.text
            {
                dataConnection.SignUp(emailTextField: emailTextField , passwordTextField: passwordTextField , completion:
                    { message in
                        message == "Done" ? (self.performSegue(withIdentifier: "goToMenuFromSignUP", sender: self)) : self.makeAlert(message: "\(message)", clearTextBox: false)
                })
            }else{
                makeAlert(message: "Password does not match", clearTextBox: false)
            }
        }else{
            makeAlert(message: "Please enter some data or accept our policy", clearTextBox: true)
        }
    }
    
    //MARK:- AlreadyLogin Button
    @IBAction func alreadylogin_Clicked(_ sender: Any)
    {
        performSegue(withIdentifier: "goToLogin", sender: self)
    }
    
    //MARK:- Policy Button
    @IBAction func policyButton_Clicked(_ sender: Any)
    {
        performSegue(withIdentifier: "goToPolicy", sender: self)
    }
    
    //MARK:- CkeckBox Button
    
    @IBAction func checkBox_Button(_ sender: UIButton)
    {
        sender.isSelected = !sender.isSelected
        checkBox = sender.isSelected
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
                self.retypeTextField.text = ""
            }
        })
        alert.addAction(restartaction)
        present(alert, animated: true, completion: nil)
    }
}

