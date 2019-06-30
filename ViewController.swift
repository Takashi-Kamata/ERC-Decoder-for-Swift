//
//  ViewController.swift
//  erc-swift
//
//  Created by Takashi Kamata on 30/06/19.
//  Copyright © 2019 Takashi Kamata. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var input: UITextField!
    @IBAction func `return`(_ sender: Any) {
        out.text = startDecode(input: input.text!)
    }
    
    @IBOutlet weak var out: UILabel!
    
    
    func GetReverse(x: Int32) -> Int32{
        var reverseSecondPart : Int32 = 0
        for index in 0...31 {

            var temp =  x >> (31-index)
            temp &= 1;
            temp = temp << index

            reverseSecondPart |= temp

        }
        return reverseSecondPart
    }
    
    
    func charSeparation(str: String, location: Int, length: Int) -> String{
        
        var split = str as NSString
        split = split.substring(with: NSRange(location: location, length: length)) as NSString
        return split as String
    }
    
    func GetFullBinary(str:String, count: Int32) -> String{
        var str2 = str
        while (str.count < count) {
            str2 = "0" + str
        }
        return str2
    }
    
    func startDecode(input: String) -> String{
        let inputERC = input
        if (inputERC.count != 16) {
            return "char num not sufficient"
        } else if (inputERC.count == 16) {
            let firstPart = charSeparation(str: inputERC, location: 0, length: 8)

            let fPint = Int32(bitPattern: UInt32(firstPart, radix: 16)!)

            let secondPart = charSeparation(str: inputERC, location: 8, length: 8)

            let sPint = Int32(bitPattern: UInt32(secondPart, radix: 16)!)

            let reverseSecondPart = GetReverse(x: sPint)

            let xor = fPint ^ reverseSecondPart
            
            let ret = ( xor &- 0xE010A11)

            
            let xd = String(format:"%X", ret)
            let last = GetFullBinary(str: xd, count: 8)
            
            return last
        } else {
            return "error"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.input.delegate = self;
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    


}

