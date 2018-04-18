//
//  AdminViewController.swift
//  GovData
//
//  Created by David Celentano on 4/11/18.
//  Copyright © 2018 David Celentano. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class AdminViewController: UIViewController {
    
    var senatorPickerData: [String] = []
    var senatorBodyData: [String] = []
    
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
    
    private let senatorPicker: UIPickerView = {
        let p = UIPickerView()
        return p
    }()
    
    private let infoLabel1: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.font = UIFont.boldSystemFont(ofSize: 16)
        l.textAlignment = .center
        return l
    }()
    
    private var addStackView: UIStackView!
    
    private let api = DBAPIService()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.getSenators()
        api.senNames.asObservable().subscribe(onNext: { list in
            DispatchQueue.main.async {
                self.senatorPickerData = list
                self.senatorPicker.reloadAllComponents()
            }
        }).disposed(by: disposeBag)
        
        api.senBody.asObservable().subscribe(onNext: { list in
            DispatchQueue.main.async {
                self.senatorBodyData = list
                self.senatorPicker.reloadAllComponents()
            }
        }).disposed(by: disposeBag)
        
        senatorPicker.delegate = self
        senatorPicker.dataSource = self
        
        view.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(50)
            make.trailing.equalTo(view).offset(-15)
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
        
        view.addSubview(infoLabel1)
        infoLabel1.snp.makeConstraints { make in
            make.top.equalTo(senatorPicker.snp.bottom).offset(15)
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
    
    @objc private func logoutTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func addTapped() {
        print("addTapped")
        addButton.isHidden = true
        submitButton.isHidden = false
        senatorPicker.isHidden = true
        infoLabel1.isHidden = true
        addLabel.isHidden = false
        addLabel.text = "Adding New Senator"
        detailLabel1.text = "Enter Senator Name"
        detailLabel2.text = "Enter Senator State"
        detailLabel3.text = "Enter Senator Party"
        detailLabel4.text = "Enter Senator Website"
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
        // TODO send data to DB
        senatorPickerData.append(detailTextField1.text!)
        infoLabel1.isHidden = false
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
        infoLabel1.text = senatorBodyData[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return senatorPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return senatorPickerData[row]
    }
}
