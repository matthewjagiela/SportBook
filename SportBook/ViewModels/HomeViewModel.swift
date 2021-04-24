//
//  HomeViewModel.swift
//  SportBook
//
//  Created by Matthew Jagiela on 4/24/21.
//

import Foundation
import Combine

class HomeViewModel {
    var controllerDelegate: HomeViewControllerDelegate!
    var subscriptions: Set<AnyCancellable> = []
    
    func makeApiRequest() {
        let api = APIRequest()
        controllerDelegate.showLoading()
        api.getSportResults().receive(on: RunLoop.main).sink { [weak self] completion in
            switch completion {
            case .failure(let error): self?.controllerDelegate.presentAPIError(message: self?.determineErrorMessage(error: error) ?? "")
            case .finished: print("API Call Successfull")
            }
            
        } receiveValue: { [weak self] results in
            self?.controllerDelegate.presentDetails(data: results)
            
        }.store(in: &subscriptions)
    }
    
    func determineErrorMessage(error: APIError) -> String {
        switch error {
        case .decodingError: return "There was an error processing data..."
        case .genericError: return "Something has gone wrong... please try again later."
        case .error(let error):
            print("ERROR \(error)")
            return "An Error has occured. Please try again later."
        }
        
    }
}
