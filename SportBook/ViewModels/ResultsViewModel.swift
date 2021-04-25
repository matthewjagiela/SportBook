//
//  ResultsViewModel.swift
//  SportBook
//
//  Created by Matthew Jagiela on 4/24/21.
//

import Foundation

enum Category: String {
    case all = "All"
    case f1 = "F1"
    case NBA = "NBA"
    case Tennis = "Tennis"
}

struct TableViewData {
    var headline: String
    var date: String
    var type: Category
    var dateObject: Date
}

class ResultsViewModel {
    private var results: Results //All Results
    private var tableViewData = [TableViewData]()
    private var currentFilter: Category = .all
    var controllerDelegate: ResultsViewControllerDelegate?
    init(results: Results) {
        self.results = results
        fillData()
    }
    
    func getCurrentFilter() -> String {
        return currentFilter.rawValue
    }
    
    func setCurrentFilter(category: Category) {
        self.currentFilter = category
        fillData()
        controllerDelegate?.updateFilterButton(category: category)
    }
    
    func fillData() {
        tableViewData.removeAll()
        switch currentFilter {
        case .all:
            fillF1Data()
            fillTennisData()
            fillNBAData()
        case .NBA:
            fillNBAData()
        case .f1:
            fillF1Data()
        case .Tennis:
            fillTennisData()
        }
        tableViewData = tableViewData.sorted {
            $0.dateObject.compare($1.dateObject) == .orderedDescending
        }
        controllerDelegate?.refreshTableView()
    }
    
    private func fillF1Data() {
        for event in results.f1Results {
            tableViewData.append(TableViewData(headline: createF1Headline(event: event),
                                               date: event.publicationDate,
                                               type: .f1,
                                               dateObject: getDateObject(date: event.publicationDate)))
        }
    }
    
    private func fillTennisData() {
        for event in results.tennis {
            tableViewData.append(TableViewData(headline: createTennisHeadline(event: event),
                                               date: event.publicationDate,
                                               type: .Tennis,
                                               dateObject: getDateObject(date: event.publicationDate)))
        }
    }
    
    private func fillNBAData() {
        for event in results.nbaResults {
            tableViewData.append(TableViewData(headline: createNBAHeadline(event: event),
                                               date: event.publicationDate,
                                               type: .NBA,
                                               dateObject: getDateObject(date: event.publicationDate)))
        }
    }
    
    private func createF1Headline(event: F1Result) -> String {
        return "\(event.winner) wins \(event.tournament) by \(event.seconds)"
    }
    
    private func createTennisHeadline(event: TennisResult) -> String {
        return "\(event.tournament): \(event.winner) wins against \(event.looser) in \(event.numberOfSets) sets"
    }
    
    private func createNBAHeadline(event: NbaResult) -> String {
        return
            "\(event.mvp) leads \(event.winner) to game \(event.gameNumber) in the NBA Playoffs"
    }
    
    func getData(at index: Int) -> TableViewData {
        return tableViewData[index]
    }
    
    func getNumberOfEntries() -> Int {
        return tableViewData.count
    }
    
    func getDateObject(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy h:mm:ss a"
        return dateFormatter.date(from: date) ?? Date()
    }
}
