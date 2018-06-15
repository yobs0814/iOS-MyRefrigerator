//
//  SettingViewController.swift
//  secondProject
//
//  Created by YOSEPH NOH on 2018. 6. 6..
//  Copyright © 2018년 YOSEPH NOH. All rights reserved.
//

import UIKit
import UserNotifications

class SettingViewController: UIViewController {

    @IBOutlet weak var txtFieldNotiDate: UITextField!
    @IBOutlet weak var txtFieldNotiTime: UITextField!
    @IBOutlet weak var swtichStatus: UISwitch!
    @IBOutlet weak var stepperDate: UIStepper!
    @IBOutlet weak var stepperTime: UIStepper!
    @IBOutlet weak var txtFieldNotiMinute: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFieldNotiDate.keyboardType = .decimalPad
        txtFieldNotiTime.keyboardType = .decimalPad
        txtFieldNotiMinute.keyboardType = .decimalPad

        
        UserDefaults.standard.set(swtichStatus.isOn, forKey: "notiStatus")
        
        UserDefaults.standard.set(txtFieldNotiDate.text, forKey: "notiDate")
        
        UserDefaults.standard.set(txtFieldNotiTime.text, forKey: "notiHour")
        
        UserDefaults.standard.set(txtFieldNotiMinute.text, forKey: "notiMinute")
        
        stepperDate.wraps = true
        stepperDate.autorepeat = true
        stepperDate.minimumValue = 1
        stepperDate.maximumValue = 7
        
        stepperTime.wraps = true
        stepperTime.autorepeat = true
        stepperTime.maximumValue = 23
    
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func onValueChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "notiStatus")
        if sender.isOn == false{
            let center = UNUserNotificationCenter.current()
            center.removeAllPendingNotificationRequests()
        }
    }
    
    @IBAction func onDateChanged(_ sender: UIStepper) {
        txtFieldNotiDate.text = Int(sender.value).description
        UserDefaults.standard.set(txtFieldNotiDate.text, forKey: "notiDate")
    }
    
    @IBAction func onTimeChanged(_ sender: UIStepper) {
        txtFieldNotiTime.text =
        Int(sender.value).description
        
        let time = (Int)(txtFieldNotiTime.text!)
        print("time:\(time)")
        var notiTime: String?
        if time! < 10{
            notiTime = "0\(time!)"
            UserDefaults.standard.set(notiTime, forKey: "notiHour")
        print("notiTime:\(notiTime)")
            }else{
            UserDefaults.standard.set(txtFieldNotiTime.text, forKey: "notiHour")
        }
    }
    
    
    
    @IBAction func ontxtFieldDateChanged(_ sender: UITextField) {
        UserDefaults.standard.set(sender.text, forKey: "notiDate")
    }
    
    @IBAction func ontxtFieldHourChanged(_ sender: UITextField) {
        if sender.text != "" {
            print("time:\(sender.text)")
            var notiTime: String?
            let inttime = (Int)(sender.text!)
            let a = inttime! > 0
            let b = inttime! < 10
            let c = inttime! > 24
            if a && b {
                notiTime = "0\(sender.text!)"
                UserDefaults.standard.set(notiTime, forKey: "notiHour")
                print("notiTime:\(notiTime)")
            }else{
                UserDefaults.standard.set(txtFieldNotiTime.text, forKey: "notiHour")
            }
            
            /*
             else if c {
             let alert = UIAlertController(title: "알림", message: "시간은 0~23시까지 입력가능합니다.", preferredStyle: UIAlertControllerStyle.alert)
             
             let confirm = UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil)
             
             alert.addAction(confirm)
             self.present(alert, animated: false, completion: nil)
             txtFieldNotiTime.text = "0"
             UserDefaults.standard.set(txtFieldNotiTime.text, forKey: "notiHour")
             }
             
             */
        }
    }
    
    @IBAction func ontxtFieldMinuteChanged(_ sender: UITextField) {
        if sender.text != "" {
        var notiMinute: String?
        let inttime = (Int)(sender.text!)
        print("time:\(sender.text)")
        let a = inttime! > 0
        let b = inttime! < 10
        
        if a && b{
            notiMinute = "0\(sender.text!)"
            UserDefaults.standard.set(notiMinute, forKey: "notiMinute")
        }else{
         
            UserDefaults.standard.set(sender.text, forKey: "notiMinute")
            }
        }
    }
    

}


