//
//  MyCardsViewController.swift
//  Goji
//
//  Created by Naelin Aquino on 11/23/16.
//  Copyright © 2016 Anae. All rights reserved.
//

import UIKit

import Firebase

@objc(MyCardsViewController)
class MyCardsViewController: UITableViewController {
    
    let userID = FIRAuth.auth()?.currentUser?.uid
    var ref = FIRDatabase.database().reference()
    var createdCardIds : [String]!
    
    var myCards: [FIRDataSnapshot]! = []
    var cards: [Card]! = []
    fileprivate var _refHandle: FIRDatabaseHandle!

    var storageRed: FIRStorageReference!
    var remoteConfig: FIRRemoteConfig!
    
    @IBOutlet weak var myCardsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Retrieves cardIds that the current user has created and populates the tableView
        ref.child(Constants.TableNames.USERS).child(userID!).child(Constants.UserFields.created).observeSingleEvent(of: .value, with: { (snapshot) in

            self.createdCardIds = snapshot.value as! [String]
            print(snapshot.value as! [String])
            self.retrieveCards()
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    override func viewDidAppear(_  animated: Bool) {

        
    }
    
    func retrieveCards() {
        for createdCardId in createdCardIds {

            let child = ref.child(Constants.TableNames.CARDS).child(createdCardId)
            child.observe(.value) { (snap: FIRDataSnapshot) in
                print((snap.value as AnyObject))
                self.myCards.append(snap)
                self.tableView.insertRows(at: [IndexPath(row: self.myCards.count - 1, section: 0)], with: .automatic)
            }
        }
    }
    
    func convertSnapshotToModel() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCards.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCardCell", for: indexPath)
    
        
        let cardSnapshot: FIRDataSnapshot! = self.myCards[indexPath.row]
        let cardSnapshotValue = cardSnapshot.value as! NSDictionary
        
        let address = cardSnapshotValue.object(forKey: Constants.CardFields.address) as! String
        let title = cardSnapshotValue.object(forKey: Constants.CardFields.title) as! String
        let company = cardSnapshotValue.object(forKey: Constants.CardFields.company) as! String
        let email = cardSnapshotValue.object(forKey: Constants.CardFields.email) as! String
        let first = cardSnapshotValue.object(forKey: Constants.CardFields.first) as! String
        let job = cardSnapshotValue.object(forKey: Constants.CardFields.job) as! String
        let last = cardSnapshotValue.object(forKey: Constants.CardFields.last) as! String
        let other = cardSnapshotValue.object(forKey: Constants.CardFields.other) as! String
        let phone = cardSnapshotValue.object(forKey: Constants.CardFields.phone) as! String
        let site = cardSnapshotValue.object(forKey: Constants.CardFields.site) as! String

        cell.textLabel?.text = title
        
        let card = Card(title: title, first: first, last: last, company: company, phone: phone, email: email, address: address, site: site, job: job, other: other)
        
        cards.append(card)
        
        return cell
    }
    
    
//    
//        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            // Dequeue cell
//            let cell = self.tableView.dequeueReusableCell(withIdentifier: "MyCardCell", for: indexPath)
//            // Unpack message from Firebase DataSnapshot
//            let cardSnapshot: FIRDataSnapshot! = self.myCards[indexPath.row]
//            let card = cardSnapshot.value as! Dictionary<String, String>
//            let title = card[Constants.CardFields.title] as String!
//            cell.textLabel?.text = title!
////            cell.imageView?.image = UIImage(named: "ic_account_circle")
////            if let photoURL = message[Constants.MessageFields.photoURL], let URL = URL(string: photoURL), let data = try? Data(contentsOf: URL) {
////                cell.imageView?.image = UIImage(data: data)
////            }
//            return cell
//        }
    
    
    
    @IBAction func cancelToMyCardsViewController(segue:UIStoryboardSegue) {
    }
    
//    @IBAction func saveCardDetail(segue:UIStoryboardSegue) {
//        if let cardDetailsTableViewController = segue.source as? CardDetailsTableViewController {
//            // Add the new card to the myCards array
//            if let card = cardDetailsTableViewController.card {
//                myCards.append(card)
//                
//                // Update the table view
//                let indexPath = IndexPath(row: myCards.count - 1, section: 0)
//                tableView.insertRows(at: [indexPath], with: .automatic)
//            }
//            
//        }
//    }


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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if(segue.identifier == Constants.Segues.MyCardCell) {
            let destination = segue.destination as? CardDetailsTableViewController
            let cell = sender as! MyCardCell
            let selectedRow = tableView.indexPath(for: cell)!.row
            
            // Set the values to populate the text fields in CardDetailsTableView
            let selectedCard = cards[selectedRow]
            destination!.cardTitle = selectedCard.title
            destination!.firstName = selectedCard.first
            destination!.lastName = selectedCard.last
            destination!.companyName = selectedCard.company
            destination!.phoneNumber = selectedCard.phone
            destination!.emailAddress = selectedCard.email
            destination!.streetAddress = selectedCard.address
            destination!.jobTitle = selectedCard.job
            destination!.siteUrl = selectedCard.site
            destination!.other = selectedCard.other
            
            // TODO: Find out if there is a better way to do this
            // Set isNew to false since we are not adding a new card
            destination!.isNew = false
        } else if(segue.identifier == "AddCard") {
            
        }

    }
    
    

}
