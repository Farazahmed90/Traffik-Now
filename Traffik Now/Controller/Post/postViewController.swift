
import UIKit

class postViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UITextViewDelegate , UIScrollViewDelegate
{
    var selected_tab = "Social"
    let pickerarray = ["Social","News","Updates"]
    let dataConnection = Data()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var postButton: UIButton!
    
    @IBOutlet weak var locationTextFiled: UITextField!
    @IBOutlet weak var issueTextField: UITextField!
    @IBOutlet weak var detailTextField: UITextView!
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        roundTextField(textfield: detailTextField)
        roundButton(button: postButton)
        
        scrollView.isScrollEnabled = false
        
        detailTextField.text = "details"
        detailTextField.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        picker.delegate = self
        picker.dataSource = self
        self.hideKeyboardWhenTappedAround()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        scrollView.isScrollEnabled = true
    }
 
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        scrollView.setContentOffset(.zero, animated: true)
        scrollView.isScrollEnabled = false
    }
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == "details" && textView.textColor == #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder() //Optional
        scrollView.isScrollEnabled = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            textView.text = "details"
            textView.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        textView.resignFirstResponder()
        
        scrollView.setContentOffset(.zero, animated: true)
        scrollView.isScrollEnabled = false
    }

    @IBAction func postButton_Clicked(_ sender: Any)
    {
        dataConnection.post(locationTextField: locationTextFiled, issueTextField: issueTextField, detailTextField: detailTextField, selected_tab: selected_tab, completion: { message in
            message == "Posted Succesfully" ? self.makeAlert(message: message, clearTextBox: true) : self.makeAlert(message: message, clearTextBox: false)
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    //MARK:- To make UIAlert
    func makeAlert(message: String , clearTextBox: Bool)
    {
        let alert = UIAlertController(title: "Traffik Now", message: "\(message)", preferredStyle: .alert)
        let restartaction = UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            if clearTextBox{
                self.locationTextFiled.text = nil
                self.issueTextField.text = nil
                self.detailTextField.text = nil
            }
        })
        alert.addAction(restartaction)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK:- Picker Functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerarray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerarray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(pickerarray[row])
        selected_tab = pickerarray[row]
    }
    
    //MARK:- To Make Button Round
    func roundButton(button: UIButton)
    {
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
    }
    
    //MARK:- To Make TextView Round
    func roundTextField(textfield:UITextView)
    {
        detailTextField.clipsToBounds = true
        detailTextField.layer.cornerRadius = 10.0
        self.detailTextField.layer.borderWidth = 1.0
        detailTextField.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        locationTextFiled.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        issueTextField.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    

}

