//
//  SettingsViewController.swift
//  PuntoTruco
//
//  Created by Martin Gonzalez Vega on 10/05/2020.
//  Copyright © 2020 T1incho. All rights reserved.
//

import UIKit

class VCSettings: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var gamePointsPickerView: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - vars and cons
    
    var dataSource = ["Points To Play"]
    var gamePointsDataSource = [15,18,30]
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        setupPickerView()
        setupTableView()
        setupNavigationBar()
    }
    
    // MARK: - private methods
    
    private func setupPickerView() {
        gamePointsPickerView.isHidden = true
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func setupNavigationBar() {
        let settingsButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        settingsButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = settingsButton
        title = "PuntoTruco"
    }
    
    // MARK: - actions
    
    @objc private func saveTapped(_ sender: Any) {
        GameManager.shared.gamePoints = gamePointsPickerView.selectedRow(inComponent: 0)
    }
}


// MARK: - UITableViewDelegate

extension VCSettings: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gamePointsPickerView.isHidden = !gamePointsPickerView.isHidden
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension VCSettings: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        cell.textLabel?.text = "\(dataSource[indexPath.row])"
        cell.detailTextLabel?.text = "\(GameManager.shared.gamePoints)"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

// MARK: - UIPickerViewDelegate

extension VCSettings: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gamePointsPickerView.isHidden = !gamePointsPickerView.isHidden
    }
}

// MARK: - UIPickerViewDataSource

extension VCSettings: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gamePointsDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(gamePointsDataSource[row])"
    }
}
