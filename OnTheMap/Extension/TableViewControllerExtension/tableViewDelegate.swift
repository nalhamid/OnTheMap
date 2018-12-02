//
//  tableViewDelegate.swift
//  OnTheMap
//
//  Created by Moviefreak89 on 01/12/2018.
//  Copyright © 2018 Moviefreak89. All rights reserved.
//

import UIKit

extension TableViewController: UITableViewDelegate, UITableViewDataSource{
    // Mark: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numOfRows = locationModel.numberOfRows()
        return numOfRows
    }
    // Mark: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell")!
        // get student info
        let fullName = locationModel.fullNameForIndexPath(indexPath)
        let studentUrl = locationModel.linkForIndexPath(indexPath)
        cell.textLabel?.text = fullName
        cell.detailTextLabel?.text = studentUrl
        return cell
    }
    // Mark: didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let studentUrl = locationModel.linkForIndexPath(indexPath)
        // check url then open in safari
        if let convertedUrl = URL(string : studentUrl) {
            UIApplication.shared.open(convertedUrl)
        }
    }
}
