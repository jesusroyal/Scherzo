//
//  JokeDetailViewController.swift
//  Scherzo
//
//  Created by Mike Shevelinsky on 11.01.2021.
//

import UIKit

class JokeDetailViewController: UIViewController {
    
    @IBOutlet weak var setupLine: UILabel!
    @IBOutlet weak var punchLine: UILabel!
    var joke: Joke?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLine.text = joke?.setup
        punchLine.text = joke?.punchline
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
