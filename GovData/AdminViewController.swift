//
//  AdminViewController.swift
//  GovData
//
//  Created by David Celentano on 4/11/18.
//  Copyright © 2018 David Celentano. All rights reserved.
//

import UIKit
import SnapKit

class AdminViewController: UIViewController {
    
    // TODO this data will be pullled!
    var senatorPickerData: [String] = ["-", "Tammy Baldwin", "John Barrasso", "Sherrod Brown"]
    var billPickerData: [String] = ["-", "Bill 355", "Bill 378", "Bill 897"]
    
    let adminLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.text = "Admin View"
        return l
    }()
    
    let addLabel: UILabel = {
        let l = UILabel()
        l.isHidden = true
        l.numberOfLines = 0
        l.text = "Provide Details"
        return l
    }()
    
    let detailLabel1: UILabel = {
        let l = UILabel()
        l.isHidden = true
        l.numberOfLines = 0
        l.text = "Provide Details"
        return l
    }()
    
    let detailLabel2: UILabel = {
        let l = UILabel()
        l.isHidden = true
        l.numberOfLines = 0
        l.text = "Provide Details"
        return l
    }()
    
    let detailLabel3: UILabel = {
        let l = UILabel()
        l.isHidden = true
        l.numberOfLines = 0
        l.text = "Provide Details"
        return l
    }()
    
    let detailLabel4: UILabel = {
        let l = UILabel()
        l.isHidden = true
        l.numberOfLines = 0
        l.text = "Provide Details"
        return l
    }()
    
    let detailTextField1: UITextField = {
        let t = UITextField()
        t.isHidden = true
        t.borderStyle = .roundedRect
        t.autocapitalizationType = .none
        t.clearButtonMode = .always
        return t
    }()
    
    let detailTextField2: UITextField = {
        let t = UITextField()
        t.isHidden = true
        t.borderStyle = .roundedRect
        t.autocapitalizationType = .none
        t.clearButtonMode = .always
        return t
    }()
    
    let detailTextField3: UITextField = {
        let t = UITextField()
        t.isHidden = true
        t.borderStyle = .roundedRect
        t.autocapitalizationType = .none
        t.clearButtonMode = .always
        return t
    }()
    
    let detailTextField4: UITextField = {
        let t = UITextField()
        t.isHidden = true
        t.borderStyle = .roundedRect
        t.autocapitalizationType = .none
        t.clearButtonMode = .always
        return t
    }()
    
    private let logoutButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Logout", for: .normal)
        b.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        return b
    }()
    
    private let addButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Add New", for: .normal)
        b.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        return b
    }()
    
    private let submitButton: UIButton = {
        let b = UIButton(type: .system)
        b.isHidden = true
        b.setTitle("Submit", for: .normal)
        b.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        return b
    }()
    
    private var infoSwitch: UISegmentedControl = {
        let s = UISegmentedControl()
        s.insertSegment(withTitle: "Bills", at: 0, animated: false)
        s.insertSegment(withTitle: "Senators", at: 1, animated: false)
        s.setWidth(75.0, forSegmentAt: 0)
        s.setWidth(75.0, forSegmentAt: 1)
        s.addTarget(self, action: #selector(infoSwitchChanged), for: UIControlEvents.valueChanged)
        s.selectedSegmentIndex = 1
        return s
    }()
    
    private let senatorPicker: UIPickerView = {
        let p = UIPickerView()
        return p
    }()
    
    private let billPicker: UIPickerView = {
        let p = UIPickerView()
        return p
    }()
    
    private let infoLabel1: UILabel = {
        let l = UILabel()
        return l
    }()
    
    private let infoLabel2: UILabel = {
        let l = UILabel()
        return l
    }()
    
    private let infoLabel3: UILabel = {
        let l = UILabel()
        return l
    }()
    
    private var addStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        senatorPicker.delegate = self
        senatorPicker.dataSource = self
        billPicker.delegate = self
        billPicker.dataSource = self
        
        view.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(50)
            make.trailing.equalTo(view).offset(-15)
        }
        
        view.addSubview(infoSwitch)
        infoSwitch.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(50)
            make.leading.equalTo(view).offset(15)
        }
        
        view.addSubview(adminLabel)
        adminLabel.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-20)
            make.centerX.equalTo(view)
        }
        
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(120)
            make.leading.equalTo(view).offset(15)
        }
        
        view.addSubview(submitButton)
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(120)
            make.leading.equalTo(view).offset(15)
        }
        
        view.addSubview(senatorPicker)
        senatorPicker.snp.makeConstraints { make in
            make.top.equalTo(logoutButton.snp.bottom).offset(80)
            make.centerX.equalTo(view)
            make.width.equalTo(250)
        }
        
        view.addSubview(billPicker)
        billPicker.isHidden = true
        billPicker.snp.makeConstraints { make in
            make.top.equalTo(logoutButton.snp.bottom).offset(80)
            make.centerX.equalTo(view)
            make.width.equalTo(250)
        }
        
        view.addSubview(infoLabel1)
        infoLabel1.snp.makeConstraints { make in
            make.top.equalTo(senatorPicker.snp.bottom).offset(15)
            make.centerX.equalTo(view)
        }

        view.addSubview(infoLabel2)
        infoLabel2.snp.makeConstraints { make in
            make.top.equalTo(infoLabel1.snp.bottom).offset(10)
            make.centerX.equalTo(view)
        }

        view.addSubview(infoLabel3)
        infoLabel3.snp.makeConstraints { make in
            make.top.equalTo(infoLabel2.snp.bottom).offset(10)
            make.centerX.equalTo(view)
        }
        
        addStackView = UIStackView(arrangedSubviews: [addLabel, detailLabel1, detailTextField1, detailLabel2, detailTextField2, detailLabel3, detailTextField3, detailLabel4, detailTextField4])
        addStackView.alignment = .center
        addStackView.axis = .vertical
        addStackView.spacing = 10
        
        
        view.addSubview(addStackView)
        addStackView.snp.makeConstraints { make in
            make.top.equalTo(logoutButton.snp.bottom).offset(80)
            make.centerX.equalTo(view)
        }
    }
    
    @objc func infoSwitchChanged() {
        if infoSwitch.selectedSegmentIndex == 0 {
            billPicker.isHidden = false
            billPicker.reloadAllComponents()
            billPicker.selectRow(0, inComponent: 0, animated: false)
            senatorPicker.isHidden = true
            resetInfoLabels()
        } else {
            billPicker.isHidden = true
            senatorPicker.isHidden = false
            senatorPicker.reloadAllComponents()
            senatorPicker.selectRow(0, inComponent: 0, animated: false)
            resetInfoLabels()
        }
    }
    
    private func resetInfoLabels() {
        infoLabel1.text = ""
        infoLabel2.text = ""
        infoLabel3.text = ""
    }
    
    @objc private func logoutTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func addTapped() {
        print("addTapped")
        addButton.isHidden = true
        submitButton.isHidden = false
        billPicker.isHidden = true
        senatorPicker.isHidden = true
        infoLabel1.isHidden = true
        infoLabel2.isHidden = true
        infoLabel3.isHidden = true
        addLabel.isHidden = false
        if infoSwitch.selectedSegmentIndex == 1 {
            addLabel.text = "Adding New Senator"
            detailLabel1.text = "Enter Senator Name"
            detailLabel2.text = "Enter Senator State"
            detailLabel3.text = "Enter Senator Party"
            detailLabel4.text = "Enter Senator Website"
        } else {
            addLabel.text = "Adding New bill"
            detailLabel1.text = "Enter Bill Name"
            detailLabel2.text = "Enter Last Update Date"
            detailLabel3.text = "Enter Date Created"
            detailLabel4.text = "Enter Recent Action"
        }
        detailLabel1.isHidden = false
        detailLabel2.isHidden = false
        detailLabel3.isHidden = false
        detailLabel4.isHidden = false
        detailTextField1.text = ""
        detailTextField2.text = ""
        detailTextField3.text = ""
        detailTextField4.text = ""
        detailTextField1.isHidden = false
        detailTextField2.isHidden = false
        detailTextField3.isHidden = false
        detailTextField4.isHidden = false
    }
    
    @objc func submitTapped() {
        submitButton.isHidden = true
        addButton.isHidden = false
        if infoSwitch.selectedSegmentIndex == 0 {
            billPickerData.append(detailTextField1.text!)
            infoSwitchChanged()
        } else {
            senatorPickerData.append(detailTextField1.text!)
            infoSwitchChanged()
        }
        infoLabel1.isHidden = false
        infoLabel2.isHidden = false
        infoLabel3.isHidden = false
        addLabel.isHidden = true
        detailLabel1.isHidden = true
        detailLabel2.isHidden = true
        detailLabel3.isHidden = true
        detailLabel4.isHidden = true
        detailTextField1.isHidden = true
        detailTextField2.isHidden = true
        detailTextField3.isHidden = true
        detailTextField4.isHidden = true
    }
}

extension AdminViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        // TODO this data will be pullled!
        if(row == 1)
        {
            if infoSwitch.selectedSegmentIndex == 0 {
                infoLabel1.text = "Last Modified: 4/8/2017"
                infoLabel2.text = "Introduced on: 5/6/2018"
                infoLabel3.text = "Recent Action: N/A"
            } else {
                infoLabel1.text = "State: WI"
                infoLabel2.text = "Party: Democrat"
                infoLabel3.text = "Website: www.baldwin.senate.gov"
            }
        }
        else if(row == 2)
        {
            if infoSwitch.selectedSegmentIndex == 0 {
                infoLabel1.text = "Last Modified: 6/3/2017"
                infoLabel2.text = "Introduced on: 12/12/2015"
                infoLabel3.text = "Recent Action: N/A"
            } else {
                infoLabel1.text = "State: WY"
                infoLabel2.text = "Party: Republican"
                infoLabel3.text = "Website: www.barrasso.senate.gov"
            }
        }
        else if(row == 3)
        {
            if infoSwitch.selectedSegmentIndex == 0 {
                infoLabel1.text = "Last Modified: 4/6/2017"
                infoLabel2.text = "Introduced on: 8/3/2016"
                infoLabel3.text = "Recent Action: N/A"
            } else {
                infoLabel1.text = "State: OH"
                infoLabel2.text = "Party: Democrat"
                infoLabel3.text = "Website: www.brown.senate.gov"
            }
        }
        else if(row == 4)
        {
            if infoSwitch.selectedSegmentIndex == 0 {
                infoLabel1.text = "Last Modified: 4/6/2017"
                infoLabel2.text = "Introduced on: N/A"
                infoLabel3.text = "Recent Action: N/A"
            } else {
                infoLabel1.text = "State: CA"
                infoLabel2.text = "Party: Independant"
                infoLabel3.text = "Website: www.test.com"
            }
        }
        else
        {
            infoLabel1.text = ""
            infoLabel2.text = ""
            infoLabel3.text = ""
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if infoSwitch.selectedSegmentIndex == 0 {
            return billPickerData.count
        } else {
            return senatorPickerData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if infoSwitch.selectedSegmentIndex == 0 {
            return billPickerData[row]
        } else {
            return senatorPickerData[row]
        }
    }
}
