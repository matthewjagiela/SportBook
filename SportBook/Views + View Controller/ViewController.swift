//
//  ViewController.swift
//  SportBook
//
//  Created by Matthew Jagiela on 4/24/21.
//

import UIKit

protocol HomeViewControllerDelegate {
    func showLoading()
    func presentDetails(data: Results)
    func presentAPIError(message: String)
}

class ViewController: UIViewController {
    
    let loadingAlert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    
    let handler = APIRequest()
    var viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.controllerDelegate = self
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    @IBAction func fetchRecords(_ sender: Any) {
        viewModel.makeApiRequest()
    }
    
}

extension ViewController: HomeViewControllerDelegate {
    func presentAPIError(message: String) {
        let alert = UIAlertController(title: "Sorry", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showLoading() {
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        
        loadingAlert.view.addSubview(loadingIndicator)
        DispatchQueue.main.async {
            self.present(self.loadingAlert, animated: true, completion: nil)
        }
    }
    
    func presentDetails(data: Results) {
        //TODO: present detail controller
        DispatchQueue.main.async {
            self.loadingAlert.dismiss(animated: true) { [weak self] in
                self?.performSegue(withIdentifier: "showResults", sender: self)
            }
        
        }
        print(data)
    }
    
    
}

