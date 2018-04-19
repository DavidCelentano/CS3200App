//
//  GuestViewController.swift
//  GovData
//
//  Created by David Celentano on 4/11/18.
//  Copyright © 2018 David Celentano. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class GuestViewController: UIViewController {
    
    var senatorPickerData: [String] = []
    var senatorBodyData: [String] = []
    
    private let logoutButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Logout", for: .normal)
        b.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
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
        
        view.addSubview(senatorPicker)
        senatorPicker.snp.makeConstraints { make in
            make.top.equalTo(logoutButton.snp.bottom).offset(10)
            make.centerX.equalTo(view)
            make.width.equalTo(250)
        }
        
        view.addSubview(infoLabel1)
        infoLabel1.snp.makeConstraints { make in
            make.top.equalTo(senatorPicker.snp.bottom).offset(15)
            make.centerX.equalTo(view)
        }
    }
    
    @objc private func logoutTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension GuestViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if row < senatorBodyData.count {
            infoLabel1.text = senatorBodyData[row]
        }
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
