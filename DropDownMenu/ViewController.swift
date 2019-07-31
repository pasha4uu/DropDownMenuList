//
//  ViewController.swift
//  DropDownMenu
//
//  Created by Rathna on 31/07/19.
//  Copyright © 2019 Pasha. All rights reserved.
//

import UIKit

class dropDownCell: UITableViewCell {
    
}

class ViewController: UIViewController {

    @IBOutlet weak var colorBtn: UIButton!
    @IBOutlet weak var genderBtn: UIButton!
    
    var selectedBtn = UIButton()
    
    let transparantView = UIView()
    let tableV = UITableView()
    
    var dropDownArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableV.delegate = self
        tableV.dataSource = self
        
        tableV.register(dropDownCell.self, forCellReuseIdentifier: "dropdown")
        print("aaaaa")
        // Do any additional setup after loading the view.
    }
    
    func addTransparant(frames:CGRect) {
        
        transparantView.frame = UIApplication.shared.keyWindow?.frame ?? self.view.frame
        transparantView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        self.view.addSubview(transparantView)
         self.tableV.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
        self.view.addSubview(tableV)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparantView.addGestureRecognizer(tapGesture);
        transparantView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.tableV.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height + 5, width: frames.width, height: CGFloat(50 * self.dropDownArr.count))
            self.transparantView.alpha = 0.8
        }, completion: nil)
        
        
        
    }
    
  @objc  func removeTransparentView(){
    let frames = selectedBtn.frame
    UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
        self.transparantView.alpha = 0
        self.tableV.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
    }, completion: nil)
        
    }
    

    @IBAction func colorClick(_ sender: Any) {
        selectedBtn = colorBtn
        dropDownArr = ["Red","White","Green","Yellow","Orange","Pink","Black","Blue"]
        tableV.reloadData()
        addTransparant(frames: colorBtn.frame)
        
    }
    
    @IBAction func genderClick(_ sender: Any) {
        selectedBtn = genderBtn
        dropDownArr = ["Female","Male"]
        tableV.reloadData()
        addTransparant(frames: genderBtn.frame)

    }
}


extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableV.dequeueReusableCell(withIdentifier: "dropdown", for: indexPath)

        cell.textLabel?.text = dropDownArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = dropDownArr[indexPath.row]
        selectedBtn.setTitle(selected, for: .normal)
        removeTransparentView()
    }
    
}

