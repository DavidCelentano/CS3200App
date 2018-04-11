//
//  GuestViewController.swift
//  GovData
//
//  Created by David Celentano on 4/11/18.
//  Copyright © 2018 David Celentano. All rights reserved.
//

import UIKit
import SnapKit

class GuestViewController: UIViewController {
    
    // TODO this data will be pullled!
    var senatorPickerData: [String] = ["-", "Lisa", "Fred", "Jim"]
    var billPickerData: [String] = ["-", "Bill 355", "Bill 378", "Bill 897"]
    
    private let logoutButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Logout", for: .normal)
        b.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        senatorPicker.delegate = self
        senatorPicker.dataSource = self
        billPicker.delegate = self
        billPicker.dataSource = self
        
        view.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(30)
            make.trailing.equalTo(view).offset(-15)
        }
        
        view.addSubview(infoSwitch)
        infoSwitch.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(30)
            make.leading.equalTo(view).offset(15)
        }
        
        view.addSubview(senatorPicker)
        senatorPicker.snp.makeConstraints { make in
            make.top.equalTo(logoutButton.snp.bottom).offset(10)
            make.centerX.equalTo(view)
            make.width.equalTo(150)
        }
        
        view.addSubview(billPicker)
        billPicker.isHidden = true
        billPicker.snp.makeConstraints { make in
            make.top.equalTo(logoutButton.snp.bottom).offset(10)
            make.centerX.equalTo(view)
            make.width.equalTo(150)
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
}

extension GuestViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        // TODO this data will be pullled!
        if(row == 1)
        {
            if infoSwitch.selectedSegmentIndex == 0 {
                infoLabel1.text = "Introduced Date: 1/4/2018"
                infoLabel2.text = "Tracker State: N/A"
                infoLabel3.text = "Recent Action: N/A"
            } else {
                infoLabel1.text = "State: FL"
                infoLabel2.text = "Party: Republican"
                infoLabel3.text = "Website: www.lisa.com"
            }
        }
        else if(row == 2)
        {
            if infoSwitch.selectedSegmentIndex == 0 {
                infoLabel1.text = "Introduced Date: 12/22/2017"
                infoLabel2.text = "Tracker State: N/A"
                infoLabel3.text = "Recent Action: N/A"
            } else {
                infoLabel1.text = "State: NY"
                infoLabel2.text = "Party: Democrat"
                infoLabel3.text = "Website: www.fred.com"
            }
        }
        else if(row == 3)
        {
            if infoSwitch.selectedSegmentIndex == 0 {
                infoLabel1.text = "Introduced Date: 5/22/2016"
                infoLabel2.text = "Tracker State: N/A"
                infoLabel3.text = "Recent Action: N/A"
            } else {
                infoLabel1.text = "State: CA"
                infoLabel2.text = "Party: Independant"
                infoLabel3.text = "Website: www.jim.com"
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
