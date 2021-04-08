//
//  QuoteCell.swift
//  MyAppCoreData
//
//  Created by Łukasz Rajczewski on 07/04/2021.
//

import UIKit
import CoreData

class QuoteCell: UITableViewCell {
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var starState: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func starTapped(_ sender: UIButton) {
        
        starState.toggle()
        
        let imageName = starState == true ? "star.fill" : "star"
        starButton.setImage(UIImage(systemName: imageName), for: .normal)

        
    }
    
    func saveStarStatus() {
        
        
        
        
        
    }


}
