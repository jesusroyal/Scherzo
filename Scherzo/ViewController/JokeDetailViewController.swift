//
//  JokeDetailViewController.swift
//  Scherzo
//
//  Created by Mike Shevelinsky on 11.01.2021.
//

import UIKit

final class JokeDetailViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var setupLine: UILabel!
    @IBOutlet weak var punchLine: UILabel!

    // MARK: - Public Properties

    var joke: Joke?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setJoke()
    }

    // MARK: - Private Methods

    private func setJoke() {
        setupLine.text = joke?.setup
        punchLine.text = joke?.punchline
    }
}
