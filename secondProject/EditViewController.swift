//
//  EditViewController.swift
//  secondProject
//
//  Created by YOSEPH NOH on 2018. 6. 12..
//  Copyright © 2018년 YOSEPH NOH. All rights reserved.
//

import UIKit

protocol EditViewDelegate {
    func changeCnt(cnt: String)
}

class EditViewController: UIViewController {
    
    var delegate: EditViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        alert()
    }
    
    func alert(){
        let alert = UIAlertController(title: "변경할 수량을 입력하세요.", message: "0을 입력시 품목은 제거됩니다.", preferredStyle: UIAlertControllerStyle.alert)
        
        let cancel = UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler: {(_) in
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        })
        
        let confirm = UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: {(_) in
            
            let cnt = alert.textFields![0].text
            
            if let delegate = self.delegate{
                delegate.changeCnt(cnt: cnt!)
            }

            self.presentingViewController?.dismiss(animated: true, completion: nil)
        })
        
        
        alert.addAction(cancel)
        alert.addAction(confirm)
        
        
        alert.addTextField(configurationHandler: { (tf) in
            tf.placeholder = "숫자를 입력하세요"
        })
        
        self.present(alert, animated: false, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
