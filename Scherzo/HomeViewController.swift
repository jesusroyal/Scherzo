//
//  ViewController.swift
//  Scherzo
//
//  Created by Mike Shevelinsky on 06.01.2021.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let service = JokeService()
    private var isLoading = false

    @IBOutlet weak var setupLine: UILabel!
    @IBOutlet weak var punchLine: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        self.setupLine.text = ""
        self.punchLine.text = ""
    }

    @IBAction func jokeDidTap(_ sender: UIButton) {
        showLoading()
        service.getJoke { (joke) in
            guard let joke = joke else {
                DispatchQueue.main.async {
                    self.showError()
                }
                return
            }
            DispatchQueue.main.async {
                self.setupLine.text = joke.setup
                self.punchLine.text = joke.punchline
                self.hideLoading()
            }
        }
    }

    private func showLoading() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()

        alert.view.addSubview(loadingIndicator)
        isLoading = true
        present(alert, animated: true)
    }
    
    private func hideLoading() {
        dismiss(animated: true) {
            self.isLoading = false
        }
    }

    private func showError() {
        let alert = UIAlertController(title: "Error", message: "Can not connect to server", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

        if isLoading {
            dismiss(animated: true) {
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

