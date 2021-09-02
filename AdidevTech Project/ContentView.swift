//
//  ContentView.swift
//  AdidevTech Project
//
//  Created by Emmanuel on 8/26/21.
//

import SwiftUI
import Foundation

let screen = UIScreen.main.bounds.width
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

class ContentView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var searchResults = [Artist]()
    
    // number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    // add data to cells labes
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistTableCell", for: indexPath) as? ArtistTableCell else {fatalError("Unable to create cell")}
        let info = "Artist Name: \(searchResults[indexPath.row].artistName) \nTrack Name: \(searchResults[indexPath.row].trackName) \nTrack Price: \(searchResults[indexPath.row].trackPrice) \nRelease Date: \(searchResults[indexPath.row].releaseDate) \nPrimary Genre Name: \(searchResults[indexPath.row].primaryGenreName)"

        cell.label.text = info

        cell.label.numberOfLines = 0

        if indexPath.row % 2 == 0{
            cell.backgroundColor = .white
            cell.label.textColor = .black
            
        } else {
            cell.backgroundColor = .black
            cell.label.textColor = .white
        }

        return cell
    }
    
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        ArtistTable.delegate = self
        ArtistTable.estimatedRowHeight = 85
        configuration()
    }
    
    
    lazy var ArtistTable: UITableView = {
        let iv = UITableView()
        iv.register(ArtistTableCell.self, forCellReuseIdentifier: "ArtistTableCell")
        iv.dataSource = self
        iv.delegate = self
        iv.estimatedRowHeight = 250
        iv.rowHeight =  UITableView.automaticDimension
        iv.separatorStyle = .none
        iv.tableFooterView = UIView()
        return iv
    }()
    
    func NavBar() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor.black
        
        self.title = "Artist Results"
        let tlabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        tlabel.text = self.title
        tlabel.textColor = .black
        
        tlabel.backgroundColor = UIColor.clear
        tlabel.adjustsFontSizeToFitWidth = true
        tlabel.textAlignment = .center
        self.navigationItem.titleView = tlabel
    }
    
    func configuration() {
        // set up view

        NavBar()
        view.backgroundColor = .white
        view.addSubview(ArtistTable)
        ArtistTable.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 75, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0 , height: 0)
    }
}




extension UIView {

func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {

    translatesAutoresizingMaskIntoConstraints = false
    
    if let top = top {
        self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
    }
    
    if let left = left {
        self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
    }
    
    if let bottom = bottom {
        bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
    }
    
    if let right = right {
        rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
    }
    
    if width != 0 {
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    if height != 0 {
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}
}
