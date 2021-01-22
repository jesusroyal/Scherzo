//
//  BookMarkTableViewController.swift
//  Scherzo
//
//  Created by Mike Shevelinsky on 07.01.2021.
//

import UIKit
import CoreData

final class BookMarkTableViewController: UITableViewController {
    
    // MARK: - Private Properties
    
    private let cellReuseIdentifier = "bookMarkCell"
    
    private var jokes = [Joke]()
    
    private var coreDataContext: NSManagedObjectContext {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    private var gradient: CALayer {
        let gradientBackgroundColors = [Colors.green.cgColor, Colors.purple.cgColor]
        let gradientLocations:[NSNumber] = [0.0,1.0]
        let gradient = CAGradientLayer()
        gradient.colors = gradientBackgroundColors
        gradient.locations = gradientLocations
        gradient.frame = self.tableView.bounds
        return gradient
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchJokes()
        
        setupView()
        setupNevigationBar()
    }
    
    // MARK: - Private Methods
    
    private func fetchJokes(){
        let fetchRequest: NSFetchRequest<Joke> = Joke.fetchRequest()
        guard let array = try? coreDataContext.fetch(fetchRequest) else {return }
        self.jokes = array
    }
    
    private func setupView(){
        self.title = "BookMarkTitle".localized
        
        let backgroundView = UIView(frame: self.tableView.bounds)
        backgroundView.layer.insertSublayer(gradient, at: 0)
        self.tableView.backgroundView = backgroundView
    }
    
    private func setupNevigationBar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = Colors.pink
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)

        cell.textLabel?.text = jokes[indexPath.row].title
        cell.detailTextLabel?.text = jokes[indexPath.row].setup

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showJoke", sender: jokes[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            coreDataContext.delete(jokes[indexPath.row])
            jokes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showJoke"){
            guard let destinationVC = segue.destination as? JokeDetailViewController, let joke = sender as? Joke else {
                return
            }
            destinationVC.joke = joke
        }
    }
}
