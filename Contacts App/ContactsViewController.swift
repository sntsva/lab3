//
//  ContactsViewController.swift
//  Contacts App
//
//  Created by Alua Santassova on 06.04.2022.
//

import UIKit
import RealmSwift

class ContactsViewController: UIViewController {
    
    @IBOutlet weak var contactsTable: UITableView!
    
    var contacts: [Contact] = []
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Contacts" 
        
        queryPeople()
        contactsTable.delegate = self
        contactsTable.dataSource = self
        print(contacts)
        
        print(realm.configuration.fileURL!)
        
        // Do any additional setup after loading the view.
    }
    
    func addPeople(contact: Contact) {
        try! realm.write {
            realm.add(contact)
        }
        print("Added to database")
    }
    
    func deleteContact(contact: Contact) {
        try! realm.write {
            realm.delete(contact)
        }
        print("Deleted from database")
    }
    
    func queryPeople() {
        let allPeople = realm.objects(Contact.self)
        for person in allPeople {
            contacts.append(person)
            contactsTable.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details" {
            guard let vc = segue.destination as? InfoViewController
            else {
                return
            }
            guard let indexPath = contactsTable.indexPathForSelectedRow
            else {
                return
            }
            vc.person = contacts[indexPath.row]
        }
    }
    
    @IBAction func unwindToContactList(segue: UIStoryboardSegue) {
        if let vc = segue.source as? AddContactViewController {
            if vc.name.text != "" &&
                vc.number.text != "" &&
                vc.gender != "" {
                let person = Contact()
                person.name = vc.name.text!
                person.number = vc.number.text!
                person.gender = vc.gender
                addPeople(contact: person)
                contacts.append(person)
                contactsTable.reloadData()
            }
            else {
                print("Error!")
            }
        }
    }
}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contactsTable.dequeueReusableCell(withIdentifier: "myCell")!
        
        cell.textLabel?.text = contacts[indexPath.row].name
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.detailTextLabel?.text = contacts[indexPath.row].number
        cell.detailTextLabel?.font = UIFont(name: "Helvetica Neue", size: 16)
        
        if contacts[indexPath.row].gender == "female" {
            cell.imageView?.image = UIImage(named: "female")
        } else
        if contacts[indexPath.row].gender == "male" {
            cell.imageView?.image = UIImage(named: "male")
        } 
      //  cell.imageView?.image = UIImage(named: contacts.gender)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        contactsTable.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteContact(contact: contacts[indexPath.row])
            self.contacts.remove(at: indexPath.row)
            self.contactsTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "Edit") {(contextualAction, view, actionPerformed: (Bool) -> ()) in
            self.performSegue(withIdentifier: "add", sender: nil)
            actionPerformed(true)
        }
        return UISwipeActionsConfiguration(actions: [edit])
    }
}

