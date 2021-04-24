//
//  ViewController.swift
//  SportBook
//
//  Created by Matthew Jagiela on 4/24/21.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    var subscriptions: Set<AnyCancellable> = []
    
    let handler = APIRequest()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        handler.getSportResults().receive(on: RunLoop.main).sink { completion in
            
        } receiveValue: { [weak self] info in
            
        }.store(in: &subscriptions)
    }


}

