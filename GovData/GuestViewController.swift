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
    
    var senatorPickerData: [String] = [String]()
    
    private let senatorPicker: UIPickerView = {
        let p = UIPickerView()
        return p
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        senatorPickerData = ["Lisa", "Fred", "Jim"]
        
        senatorPicker.delegate = self
        
        view.addSubview(senatorPicker)
        senatorPicker.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(20)
            make.centerX.equalTo(view)
        }
    }
}

extension GuestViewController: UIPickerViewDelegate {
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return senatorPickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return senatorPickerData[row]
    }
}
