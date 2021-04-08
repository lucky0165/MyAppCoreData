//
//  ViewController.swift
//  MyAppCoreData
//
//  Created by Łukasz Rajczewski on 07/04/2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var quotes = [Quote]()
    
    var addQuoteVC: AddQuoteViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addQuoteVC = storyboard?.instantiateViewController(identifier: Constants.addQuoteVC) as? AddQuoteViewController
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addQuoteVC?.delegate = self 

        getQuotes()
    }
    
    // MARK: - Fetch quotes from Core Data
    
    func getQuotes() {
        
        let request: NSFetchRequest<Quote> = Quote.fetchRequest()
        
        do {
            quotes = try context.fetch(request)
        } catch {
            print("Error fetching data from CoreData")
        }
        
        tableView.reloadData()
        
    }
    
    // MARK: - Add new quotes
    
    @IBAction func addQuoteTapped(_ sender: UIBarButtonItem) {
      
        guard addQuoteVC != nil else { return }
        
        present(addQuoteVC!, animated: true, completion: nil)
        
    }


}

// MARK: - AddQuote Delegate
extension ViewController: AddQuoteDelegate {
    
    func saveQuote() {
        getQuotes()
    }
    
}


// MARK: - TableView Delegate & DataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.quoteCell, for: indexPath) as! QuoteCell
        
        let quote = quotes[indexPath.row]
        
        cell.quoteLabel.text = quote.title
        cell.starState = quote.state
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard addQuoteVC != nil else { return }
        
        let quoteToEdit = quotes[indexPath.row]
        
        addQuoteVC?.quote = quoteToEdit
        
        present(addQuoteVC!, animated: true, completion: nil)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (delete, view, nil) in
            
            let quoteToDelete = self.quotes[indexPath.row]
            
            self.context.delete(quoteToDelete)
            
            do {
                try self.context.save()
                
                self.getQuotes()
                
            } catch {
                print("Error deleting quote.")
            }
            
        }
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
}
