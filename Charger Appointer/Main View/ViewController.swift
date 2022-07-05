//
//  ViewController.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 29.06.2022.
//

import UIKit

class ViewController: UIViewController {

    var viewModel: MainViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        print("loaded")
    }
    
    private func setupUI(){
        view.backgroundColor = .cyan
        self.navigationItem.title = NSLocalizedString("mainViewTitle", comment: "Title of view!")
    }

}

