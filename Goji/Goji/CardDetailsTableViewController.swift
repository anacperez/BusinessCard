//
//  CardDetailsTableViewController.swift
//  Goji
//
//  Created by Naelin Aquino on 11/23/16.
//  Copyright © 2016 Anae. All rights reserved.
//

import UIKit

class CardDetailsTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var imageQRCode: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var streetAddressTextField: UITextField!
    @IBOutlet weak var siteUrlTextField: UITextField!
    @IBOutlet weak var jobTitleTextField: UITextField!
    @IBOutlet weak var otherTextField: UITextField!
    
    var cardId: String!
    var ownerId: String!
    var cardTitle: String!
    var firstName: String?
    var lastName: String?
    var companyName: String?
    var phoneNumber: String?
    var emailAddress: String?
    var streetAddress: String?
    var siteUrl: String?
    var jobTitle: String?
    var other: String?
    
    var isNew: Bool!
    var card: Card?
    var qrCodeImage: CIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        titleTextField.text = cardTitle
        firstNameTextField.text = firstName
        lastNameTextField.text = lastName
        companyNameTextField.text = companyName
        phoneNumberTextField.text = phoneNumber
        emailAddressTextField.text = emailAddress
        streetAddressTextField.text = streetAddress
        siteUrlTextField.text = siteUrl
        jobTitleTextField.text = jobTitle
        otherTextField.text = other
        
        titleTextField.delegate = self
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        companyNameTextField.delegate = self
        phoneNumberTextField.delegate = self
        emailAddressTextField.delegate = self
        streetAddressTextField.delegate = self
        siteUrlTextField.delegate = self
        jobTitleTextField.delegate = self
        otherTextField.delegate = self
        
        saveButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            titleTextField.becomeFirstResponder()
        }
    }
    
    /*
     * This function prepares to send the data back to the MyCardsViewController.
     * It makes the sure that empty fields are replaced with the empty string.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segues.SaveCardDetail {
            
            if(isNew == true) {
                if firstNameTextField.text == nil { firstName = "" }
                if lastNameTextField.text == nil { lastName = "" }
                if companyNameTextField.text == nil { companyName = "" }
                if phoneNumberTextField.text == nil { phoneNumber = "" }
                if emailAddressTextField.text == nil { emailAddress = "" }
                if streetAddressTextField.text == nil { streetAddress = "" }
                if siteUrlTextField.text == nil { siteUrl = "" }
                if jobTitleTextField.text == nil { jobTitle = "" }
                if otherTextField.text == nil { other = "" }

                
                card = Card(title: cardTitle, first: firstName, last: lastName, company: companyName, phone: phoneNumber, email: emailAddress, address: streetAddress, site: siteUrl, job: jobTitle, other: other)
            } else {
                
            }
            
        }
    }
    

    @IBAction func performGenerateButton(_ sender: Any) {
        if qrCodeImage == nil {
            if titleTextField.text == "" {
                return
            }
            
            let data = titleTextField.text?.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
            
            let filter = CIFilter(name: "CIQRCodeGenerator")
            
            filter?.setValue(data, forKey: "inputMessage")
            filter?.setValue("Q", forKey: "inputCorrectionLevel")
            
            qrCodeImage = filter?.outputImage
            
            displayQRCodeImage()
            
            titleTextField.resignFirstResponder()
            
            generateButton.setTitle("Clear", for: UIControlState.normal)
            
        }
        else {
            imageQRCode.image = nil
            qrCodeImage = nil
            generateButton.setTitle("Generate", for: UIControlState.normal)
        }
    }
    
    func displayQRCodeImage() {
        let scaleX = imageQRCode.frame.size.width / qrCodeImage.extent.size.width
        let scaleY = imageQRCode.frame.size.height / qrCodeImage.extent.size.height
        
        let transformedImage = qrCodeImage.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
        
        imageQRCode.image = UIImage(ciImage: transformedImage)
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        saveButton.isEnabled = true
        return true
    }


    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
