//
//  ResultsViewController.swift
//  SportBook
//
//  Created by Matthew Jagiela on 4/24/21.
//

import UIKit
protocol ResultsViewControllerDelegate {
    func refreshTableView()
    func updateFilterButton(category: Category)
}
class ResultsViewController: UIViewController {
    var viewModel: ResultsViewModel!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 108
        filterButton.setTitle(viewModel.getCurrentFilter(), for: .normal)
        viewModel.controllerDelegate = self
    }
    
    @IBAction func changeFilter(_ sender: Any) {
        let filter = UIAlertController(title: "Choose a filter", message: nil, preferredStyle: .actionSheet)
        filter.addAction(UIAlertAction(title: Category.all.rawValue, style: .default, handler: { [weak self] _ in
            self?.viewModel.setCurrentFilter(category: .all)
        }))
        filter.addAction(UIAlertAction(title: Category.f1.rawValue, style: .default, handler: { [weak self] _  in
            self?.viewModel.setCurrentFilter(category: .f1)
        }))
        filter.addAction(UIAlertAction(title: Category.NBA.rawValue, style: .default, handler: { [weak self] _  in
            self?.viewModel.setCurrentFilter(category: .NBA)
        }))
        filter.addAction(UIAlertAction(title: Category.Tennis.rawValue, style: .default, handler: { [weak self] _  in
            self?.viewModel.setCurrentFilter(category: .Tennis)
        }))
        filter.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(filter, animated: true, completion: nil)
    }
    
}

extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfEntries()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell") as! SportResultTableViewCell
        let result = viewModel.getData(at: indexPath.row)
        cell.headline.text = result.headline
        cell.date.text = result.date
        cell.type.text = result.type.rawValue
        return cell
    }
    
    
}

extension ResultsViewController: UITableViewDelegate {
    
}

extension ResultsViewController: ResultsViewControllerDelegate {
    func updateFilterButton(category: Category) {
        DispatchQueue.main.async {
            self.filterButton.setTitle(category.rawValue, for: .normal)
        }
    }
    
    func refreshTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
