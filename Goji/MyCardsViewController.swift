//
//  MyCardsViewController.swift
//  Goji
//
//  Created by Naelin Aquino on 11/23/16.
//  Copyright © 2016 Anae. All rights reserved.
//

import UIKit

class MyCardsViewController: UITableViewController {

    var myCards:[Card] = myCardsData
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCards.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCardCell", for: indexPath) as! MyCardCell
        
        let card = myCards[indexPath.row] as Card
        cell.textLabel?.text = card.title
        
        return cell
    }
    
    @IBAction func cancelToMyCardsViewController(segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveCardDetail(segue:UIStoryboardSegue) {
        if let cardDetailsTableViewController = segue.source as? CardDetailsTableViewController {
            // Add the new card to the myCards array
            if let card = cardDetailsTableViewController.card {
                myCards.append(card)
                
                // Update the table view
                let indexPath = IndexPath(row: myCards.count - 1, section: 0)
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
            
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if(segue.identifier == "MyCardCell") {
            let destination = segue.destination as? CardDetailsTableViewController
            let cell = sender as! MyCardCell
            let selectedRow = tableView.indexPath(for: cell)!.row
            
            // Set the values to populate the text fields in CardDetailsTableView
            let selectedCard = myCards[selectedRow]
            destination!.cardId = selectedCard.cardId
            destination!.cardTitle = selectedCard.title
            destination!.ownerId = selectedCard.ownerId
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
