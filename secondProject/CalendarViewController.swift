//
//  CalendarViewController.swift
//  secondProject
//
//  Created by YOSEPH NOH on 2018. 6. 6..
//  Copyright © 2018년 YOSEPH NOH. All rights reserved.
//

import UIKit
import FSCalendar


protocol CalendarViewDelegate {
    
    func didCalendarViewDone(_ controller:
        CalendarViewController, date: String)
}


class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource{
    
    var selectedDate: String?

    var delegate: CalendarViewDelegate?
    
    @IBOutlet weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.delegate = self
        calendar.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onCancelClicked(_ sender: Any) {
        // 현재 뷰를 화면에서 걷어내자.
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onDoneClicked(_ sender: Any) {
        
        
        if let delegate = delegate{
            delegate.didCalendarViewDone(self, date: selectedDate!)
        }
        

        
        // 현재 뷰를 화면에서 걷어내자.
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        selectedDate = formatter.string(from: date)

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
