//
//  ConnectionsTableViewController.swift
//  Goji
//
//  Created by Naelin Aquino on 11/14/16.
//  Copyright © 2016 Anae. All rights reserved.
//

import UIKit

import Firebase

class ConnectionsTableViewController: UITableViewController {
    
    let userID = FIRAuth.auth()?.currentUser?.uid
    var ref = FIRDatabase.database().reference()
    var connectionsIds : [String]!
    
    var connectionsSnapshots: [FIRDataSnapshot]! = []
    var connections:[Card]! = []
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        print("HERE")
        retrieveConnectionsIds()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func retrieveConnectionsIds() {
        ref.child(Constants.TableNames.USERS).child(userID!).child(Constants.UserFields.connections).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let connectionsIds = snapshot.value as! NSDictionary
            print(connectionsIds)
            self.connectionsIds = connectionsIds.allKeys as! [String]
            print(snapshot.value as! NSDictionary)
            self.retrieveCards()
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    private func retrieveCards() {
        for connectionsId in connectionsIds {
            let child = ref.child(Constants.TableNames.CARDS).child(connectionsId)
            child.observe(.value) { (snap: FIRDataSnapshot) in
                print((snap.value as AnyObject))
                self.connectionsSnapshots.append(snap)
                self.tableView.insertRows(at: [IndexPath(row: self.connectionsSnapshots.count - 1, section: 0)], with: .automatic)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return connectionsSnapshots.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath)
        
        
        let cardSnapshot: FIRDataSnapshot! = self.connectionsSnapshots[indexPath.row]
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
        let cardId = connectionsIds[indexPath.row]
        cell.textLabel?.text = title
        
        let card = Card(cardId: cardId, title: title, first: first, last: last, company: company, phone: phone, email: email, address: address, site: site, job: job, other: other)
        
        connections.append(card)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navigationController = segue.destination as! UINavigationController

        if(segue.identifier == Constants.Segues.CardDetails) {
            let destination = navigationController.topViewController as! ConnectionsDetailsViewController

            let cell = sender as! CardCell
            let selectedRow = tableView.indexPath(for: cell)!.row
            
            // Set the values to populate the text fields in CardDetailsTableView
            let selectedCard = connections[selectedRow]
            print(selectedCard.cardId)
            destination.cardId = selectedCard.cardId
            destination.cardTitle = selectedCard.title
            destination.firstName = selectedCard.first
            destination.lastName = selectedCard.last
            destination.companyName = selectedCard.company
            destination.phoneNumber = selectedCard.phone
            destination.emailAddress = selectedCard.email
            destination.streetAddress = selectedCard.address
            destination.jobTitle = selectedCard.job
            destination.siteUrl = selectedCard.site
            destination.other = selectedCard.other
        }
        
    }

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
