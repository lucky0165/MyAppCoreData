//
//  AddQuoteViewController.swift
//  MyAppCoreData
//
//  Created by Łukasz Rajczewski on 07/04/2021.
//

import UIKit
import CoreData

protocol AddQuoteDelegate {
    func saveQuote()
}

class AddQuoteViewController: UIViewController {

    @IBOutlet weak var bodyBubble: UIView!
    @IBOutlet weak var titleBubble: UIView!
    
    @IBOutlet weak var saveBubble: UIView!
    @IBOutlet weak var cancelBubble: UIView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var delegate: AddQuoteDelegate?
    
    var quote: Quote?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleBubble.layer.cornerRadius = 10
        bodyBubble.layer.cornerRadius = 20
        
        saveBubble.layer.cornerRadius = 10
        cancelBubble.layer.cornerRadius = 10
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        titleTextField.text = quote?.title
        bodyTextView.text = quote?.body
    }

    
    @IBAction func cancelTapped(_ sender: UIButton) {
        
       dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func saveTapped(_ sender: UIButton) {
        
        if quote == nil {
            
            // Create a new one
            let newQuote = Quote(context: context)
            
            newQuote.title = titleTextField.text
            newQuote.body = bodyTextView.text
            newQuote.state = false
            
            do {
                try context.save()
            } catch {
                print("Error saving data to core data.")
            }
            
        } else {
            
            // Edit current one
            quote?.title = titleTextField.text
            quote?.body = bodyTextView.text
            
            do {
                try context.save()
            } catch {
                print("Error saving data to core data.")
            }
        }
        
        delegate?.saveQuote()
        
        dismiss(animated: true, completion: nil)
        
    }
    

}
