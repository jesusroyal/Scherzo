//
//  ViewController.swift
//  Scherzo
//
//  Created by Mike Shevelinsky on 06.01.2021.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var setupLine: UILabel!
    @IBOutlet weak var punchLine: UILabel!
    @IBOutlet weak var addToBookMarks: UIButton!
    @IBOutlet weak var getJoke: UIButton!
    
    // MARK: - Private Properties
    
    private let service = JokeService()
    private var isLoading = false
    private var gradient: CALayer {
        let gradient = CAGradientLayer()
        gradient.colors = [Colors.blue.cgColor, Colors.lightBlue.cgColor]
        gradient.locations = [0.0, 1.0]
            gradient.frame = self.view.bounds
        return gradient
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.setNavigationBar()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        self.setupLine.text = ""
        self.punchLine.text = ""
        addToBookMarks.isHidden = true
        getJoke.layer.cornerRadius = getJoke.layer.frame.height / 3
        getJoke.backgroundColor = Colors.pink
        
        self.title = "Scherzo"
        
        self.view.layer.insertSublayer(gradient, at: 0)
        
    }
    
    private func saveJoke(title: String) {
                let delegate = UIApplication.shared.delegate as! AppDelegate
                let joke = Joke(context: delegate.persistentContainer.viewContext)
                joke.id = 12
                joke.setup = setupLine.text
                joke.punchline = punchLine.text
                joke.title = title
                delegate.saveContext()
    }
    
    private func presentLoadingAlert() {
        let alert = UIAlertController(title: nil, message: "Loading".localized, preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()

        alert.view.addSubview(loadingIndicator)
        isLoading = true
        present(alert, animated: true)
    }
    
    private func dismissLoadingAlert() {
        dismiss(animated: true) {
            self.isLoading = false
        }
    }

    private func presentErrorAlert() {
        let alert = UIAlertController(title: "Error".localized, message: "ErrorLoading".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        if isLoading {
            dismiss(animated: true) {
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func presentSaveToBookmarksAlert(){
        let alert = UIAlertController(title: "SaveToBookmarks".localized, message: "SaveToBookmarksSub".localized, preferredStyle: .alert)
        alert.addTextField() {textField in
            textField.text = "Title".localized
        }
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _  in
            self.saveJoke(title: alert.textFields![0].text ?? "Notitle".localized)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setJoke(_ joke: ApiJoke){
        setupLine.text = joke.setup
        punchLine.text = joke.punchline
        addToBookMarks.isHidden = false
        dismissLoadingAlert()
    }
    
    // MARK: - IBActions

    @IBAction func jokeDidTap(_ sender: UIButton) {
        presentLoadingAlert()
        service.getJoke { (joke) in
            guard let joke = joke else {
                DispatchQueue.main.async {
                    self.presentErrorAlert()
                }
                return
            }
            DispatchQueue.main.async {
                self.setJoke(joke)
            }
        }
    }
    
    @IBAction func addToBookmarksDidTap(_ sender: UIButton) {
        presentSaveToBookmarksAlert()
    }
}

