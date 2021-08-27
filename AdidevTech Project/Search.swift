//
//  Search.swift
//  AdidevTech Project
//
//  Created by Emmanuel on 8/26/21.
//

import Foundation
import UIKit

class SearchView: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // set up view
        configuration()
    }
    
    let Search: UITextField = {
        let iv = UITextField()
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.black.cgColor
        iv.backgroundColor = .white
        iv.layer.cornerRadius = 5
        iv.attributedPlaceholder = NSAttributedString(string: "Enter Artist Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        iv.textAlignment = .center
        iv.keyboardType = UIKeyboardType.default
        iv.keyboardAppearance = UIKeyboardAppearance.default
        iv.returnKeyType = .search
        iv.addTarget(self, action: #selector(BeginSearch), for: UIControl.Event.primaryActionTriggered)
        return iv
    }()

    let SearchButton: UIButton = {
        let iv = UIButton()
        iv.titleLabel?.adjustsFontSizeToFitWidth = true
        iv.setTitle("Search", for: .normal)
        iv.backgroundColor = UIColor.black
        iv.layer.cornerRadius = 25
        iv.addTarget(self, action: #selector(BeginSearch), for: UIControl.Event.touchUpInside)
        return iv
    }()
    
    let spinner:SpinnerView = SpinnerView()

//    let spinner:SpinnerView = SpinnerView(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 75, y: UIScreen.main.bounds.height / 2, width: 150, height: 150))
    
    @objc func BeginSearch() {
        Search.endEditing(true)
        if CheckInternet.Connection() == true {
            // connected to internet
            searchArtist(search: Search.text!.trimmingCharacters(in: .whitespacesAndNewlines))
        } else {
            // not connected to internet
            let alert = UIAlertController(title: "oops", message: "no internet connection", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
        }
    }
    
    func searchArtist(search:String) {
        spinnerOn()
        var searchResults = [String]()
        let url = URL(string: "https://itunes.apple.com/search?term=\(search)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)

        let task = URLSession.shared.dataTask(with: url!) { [self] (data, response, error) in
            // there was an error
               if error != nil {
                    spinnerOff()
                    let alert = UIAlertController(title: "oops", message: "there was an error try again", preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                    Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
               } else {
                // the results
                if let content = data {
                    if let json = (try? JSONSerialization.jsonObject(with: content, options: [])) as? [String:Any],
                       let items = json["results"] as? [[String:Any]] {
                        // iterate through json
                        for songinfo in items {
                            // Store necessary information
                            let artistName = songinfo["artistName"] as? String ?? ""
                            let trackName = songinfo["trackName"] as? String ?? ""
                            let releaseDate = songinfo["releaseDate"] as? String ?? ""
                            let primaryGenreName = songinfo["primaryGenreName"] as? String ?? ""
                            var trackPrice = String( songinfo["trackPrice"] as? Double ?? 0.00 )
                            if trackPrice == "0.00" {
                                trackPrice = ""
                            }
                            let info = "Artist Name: \(artistName) \nTrack Name: \(trackName) \nTrack Price: \(trackPrice) \nRelease Date: \(releaseDate) \nPrimary Genre Name: \(primaryGenreName)"

                            // append to array
                            searchResults.append(info)
                        }
                    }
                    DispatchQueue.main.async {
                        if searchResults.count > 0 {
                            // there are results
                            spinnerOff()
                            let vc = ContentView()
                            vc.searchResults = searchResults
                            self.navigationController?.pushViewController(vc, animated: true)

                        } else {
                            // no results
                            spinnerOff()
                            let alert = UIAlertController(title: "oops", message: "no results for artist", preferredStyle: .alert)
                            self.present(alert, animated: true, completion: nil)
                            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
                        }
                    }
                }
               }
           }
    task.resume()
    }

    
    func NavBar() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor.black
        
        self.title = "Search Artist"
        let tlabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        tlabel.text = self.title
        tlabel.textColor = .black
        
        tlabel.backgroundColor = UIColor.clear
        tlabel.adjustsFontSizeToFitWidth = true
        tlabel.textAlignment = .center
        self.navigationItem.titleView = tlabel
    }
    
    func spinnerOn() {
        view.addSubview(spinner)
        spinner.anchor(top: SearchButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 25, paddingLeft: screenWidth / 2 - 37.5, paddingBottom: 0, paddingRight: screenWidth / 2 - 37.5, width: 0, height: 75)
        
    }
    func spinnerOff() {
        spinner.removeFromSuperview()
    }
    
    func configuration() {
        NavBar()
        view.backgroundColor = .white
        Search.delegate = self

        // set up views
        view.addSubview(Search)
        Search.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 150, paddingLeft: 25, paddingBottom: 0, paddingRight: 25, width: 0 , height: 50)
        
        view.addSubview(SearchButton)
        SearchButton.anchor(top: Search.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 25, paddingLeft: 25, paddingBottom: 0, paddingRight: 25, width: 0 , height: 50)
    }
}
