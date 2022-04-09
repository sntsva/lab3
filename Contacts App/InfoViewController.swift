//
//  DetailsViewController.swift
//  Contacts App
//
//  Created by Alua Santassova on 06.04.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var call: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    var person: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Contact Info"
        
        nameLabel.text = person?.name
        
        if person?.gender == "female" {
            image.image = UIImage(named: "female")
        } else
        if person?.gender == "male" { image.image = UIImage(named: "male")
        } else {
            image.image = UIImage(systemName: "person")
        }
        number.text = person?.number
        call.layer.cornerRadius = 25
        
        // Do any additional setup after loading the view.
    }
}


