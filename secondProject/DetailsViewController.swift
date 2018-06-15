//
//  DetailsViewController.swift
//  secondProject
//
//  Created by YOSEPH NOH on 2018. 6. 6..
//  Copyright © 2018년 YOSEPH NOH. All rights reserved.
//

import UIKit

protocol DetailViewUpdateDelegate {
    func addItem(item:Item, section: Int)
    func saveItem()
}


class DetailsViewController: UIViewController , CalendarViewDelegate{

    
    func didCalendarViewDone(_ controller: CalendarViewController, date: String) {
        selectedDate = date

    }
    

    @IBOutlet weak var txtFieldName: UITextField!
    @IBOutlet weak var lblExpiredDate: UILabel!
    @IBOutlet weak var txtFieldCnt: UITextField!
    @IBOutlet weak var segStorage: UISegmentedControl!
    
    var selectedDate: String?
    var item: Item?
    
    var detailViewUpdateDelegate: DetailViewUpdateDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDetail()
        
        txtFieldCnt.placeholder = "수량을 적어주세요."
        txtFieldCnt.keyboardType = UIKeyboardType.decimalPad
        lblExpiredDate.textAlignment = .center
        lblExpiredDate.text = "달력을 클릭하세요."
    }


    
    @IBAction func onCancelClicked(_ sender: Any) {
        // 현재 뷰를 화면에서 걷어내기.
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func onDoneClicked(_ sender: Any) {
        
        
        if txtFieldCnt.text?.count == 0{
            let alert = UIAlertController(title: "알림", message: "수량을 입력하세요.", preferredStyle: UIAlertControllerStyle.alert)
            
            let confirm = UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil)
            
            alert.addAction(confirm)
            self.present(alert, animated: false, completion: nil)
            return
        }
        
        if selectedDate != nil{
            let tmpname = txtFieldName.text
            let tmpcnt = txtFieldCnt.text
            let tmpstorageIndex = segStorage.selectedSegmentIndex
            
            item = Item(name: tmpname!, expiredDate: selectedDate, cnt: tmpcnt!, storage: tmpstorageIndex)

            
            
            if let delegate = detailViewUpdateDelegate {
                delegate.addItem(item: item!, section: tmpstorageIndex)
            }
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }else{
            
            let alert = UIAlertController(title: "알림", message: "유통기한을 설정하십시요.", preferredStyle: UIAlertControllerStyle.alert)
            
            let confirm = UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil)
            
            alert.addAction(confirm)
            
            self.present(alert, animated: false, completion: nil)
        
        // 현재 뷰를 화면에서 걷어내기.
        }
        

        
    }
    
    //세그웨이로 데이터전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let ViewController = segue.destination as! CalendarViewController

        ViewController.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let date = selectedDate{
            lblExpiredDate.text = date
        }
    }
    
    // 뷰 컨트롤러 직접 호출에 의한 화면 전환
//    @IBAction func onCalendarClicked(_ sender: Any) {
//        // 이동할 뷰 컨트롤러 객체를 StoryBoardID 정보를 이용하여 참조
//
//        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "calendarView") else{
//            return
//        }
//
//
//        // 화면 전환할 때의 애니메이션 타입
//        uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical
//
//        // 인자 값으로 뷰 컨트롤러 인스턴스를 넣고 프레젠트 메서드 호출
//        self.present(uvc, animated: true, completion: nil)
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func initDetail(){
        txtFieldName.text = ""
        txtFieldCnt.text = ""
        lblExpiredDate.text = ""
        
    }
}
