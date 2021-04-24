//
//  ViewController.swift
//  SportBook
//
//  Created by Matthew Jagiela on 4/24/21.
//

import UIKit

protocol HomeViewControllerDelegate {
    func showLoading()
    func presentDetails()
    func presentAPIError(error: APIError)
}

class ViewController: UIViewController {
    
    let loadingAlert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    
    let handler = APIRequest()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    @IBAction func fetchRecords(_ sender: Any) {
        //TODO: Call View Model to handle fetching the records
    }
    
}

extension ViewController: HomeViewControllerDelegate {
    func presentAPIError(error: APIError) {
        
    }
    
    func showLoading() {
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        loadingAlert.view.addSubview(loadingIndicator)
        present(loadingAlert, animated: true, completion: nil)
    }
    
    func presentDetails() {
        //TODO: present detail controller
    }
    
    
}

