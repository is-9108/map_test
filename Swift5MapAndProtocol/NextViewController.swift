//
//  NextViewController.swift
//  Swift5MapAndProtocol
//
//  Created by Shota Ishii on 2020/07/24.
//  Copyright © 2020 is. All rights reserved.
//

import UIKit

protocol SearchLocationDelegate {
    func serchLocation(idoValue:String,keidoValue:String)
    }

class NextViewController: UIViewController {
    
    
    @IBOutlet weak var idoTextField: UITextField!
    

    @IBOutlet weak var keidoTextField: UITextField!
    
    var delegate:SearchLocationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func okAction(_ sender: Any) {
        
        //入力された値を取得
        
        let idoValue = idoTextField.text!
        let keidoValue = keidoTextField.text!
        
        //両方のTFが空でなければ戻る
        if idoTextField.text != nil && keidoTextField.text != nil{
            //デリゲートメソッドの引数に入れす
            delegate?.serchLocation(idoValue: idoValue, keidoValue: keidoValue)
            dismiss(animated: true, completion: nil)
        }
    }
    

}
