//
//  ViewController.swift
//  secondProject
//
//  Created by YOSEPH NOH on 2018. 6. 6..
//  Copyright © 2018년 YOSEPH NOH. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    let section : [String] = ["냉장고","냉동고","실온"]
    
    var itemStore: ItemStore?

    
    var editIdx: Int?
    var editSection: Int?

    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        myTableView.delegate = self
        myTableView.dataSource = self
    
        // Do any additional setup after loading the view, typically from a nib.
    

    }
    
    override func viewWillAppear(_ animated: Bool) {
        myTableView.reloadData()
    }
    
    // 세그웨이로 화면전환
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        if segue.identifier == "segueAdd"{
            let detailViewController = segue.destination as! DetailsViewController
            detailViewController.item = nil
        
            detailViewController.detailViewUpdateDelegate = self
        }
    }
    
    // 알림 기능
    func notificate(item: Item){
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            
            let content = UNMutableNotificationContent()
            
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko_KR")
            formatter.dateFormat = "yyyy-MM-dd"
            
            let registeredDate = item.expiredDate
            let date = UserDefaults.standard.object(forKey: "notiDate") as! String
            
            /* 며칠후 */
            var daytoalarm = formatter.date(from: registeredDate!)
            // 하루는 초로 86400이다. (60*60*24 = 86400)
            let selecteddate = -(Int)(date)! * 60 * 60 * 24
            
            /*
             유통기한이 06-13이고 푸시알림 설정에서 1일전 으로 했다면
             06-13에서 1일을 뺀 06-12에 발송하게끔하기 위한 작업.
             */
            daytoalarm?.addTimeInterval(TimeInterval(selecteddate))
            
            
            var tday = formatter.string(from: daytoalarm as! Date)

            /* 유통기한이 며칠남았는지를 보여주기 위한 메서드 */
            let days = datedifference(startdate: tday, enddate: registeredDate!)
        
            
            content.title = "나의냉장고"
            content.body = item.name + " 유통기한이 \(days)일 남았습니다"
            content.sound = UNNotificationSound.default()
        

            var calendar = NSCalendar.current
            
            formatter.dateFormat = "yyyy-MM-dd:HH:mm"
            let hour = UserDefaults.standard.object(forKey: "notiHour") as! String
            tday = tday + ":" + hour
            let minute = UserDefaults.standard.object(forKey: "notiMinute") as! String
            tday = tday + ":" + minute
            print("tday:",tday)
            let newdate = formatter.date(from: tday)
            formatter.isLenient = true
            
            let components =  calendar.dateComponents([.year, .month, .day, .hour, .minute], from: newdate as! Date)
            print("components:\(components)")
            
            /* 특정한 날짜에 알림하기 위해 UNCalendarNotificationTrigger 사용*/
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            
            let request = UNNotificationRequest(identifier: item.name+item.expiredDate!, content: content, trigger: trigger)
            
            center.add(request){ (_) in
                let message = "알림이 등록되었습니다. 등록된 알림은 유통기한이 \(date)일 남은 품목들에 대한 알림입니다. "
                
                let alert = UIAlertController(title: "알림등록", message: message, preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default)
                
                alert.addAction(ok)
                
                OperationQueue.main.addOperation {
                    self.present(alert, animated: false)
                }
                
            }
            

        }
    }
    
    func datedifference(startdate: String, enddate: String) -> Int {

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier:"ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
        let startDate = formatter.date(from:startdate)!
        let endDate = formatter.date(from:enddate)!
        
        let interval = endDate.timeIntervalSince(startDate)
        let days = Int(interval / 86400)
        print("\(days)일만큼 차이납니다.")
        return days
    }

    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableViewCell
        
       
        let item = itemStore?.items[indexPath.section][indexPath.row]
        cell.lblName.text = item?.name
            cell.lblName?.textAlignment = .left
            cell.lblExpiredDate?.textAlignment = .left
        cell.lblExpiredDate?.text = "유통기한:"+(item?.expiredDate!)!
        cell.lblCnt?.text = "수량:"+(item?.cnt)!
        
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //return self.section.count
        return (itemStore?.section.count)!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //return self.section[section]
        return itemStore?.section[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return sectionData[section].count
        return (itemStore?.items[section].count)!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath:
        IndexPath) {
        
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "editView") as? EditViewController else{
            return
        }
        
        uvc.delegate = self
        
        
        let tmpsection = indexPath.section
        let row = indexPath.row
        //print("section:",tmpsection,", row:",row)
        editIdx = row
        editSection = tmpsection
        isEditing = true
        
        self.present(uvc, animated: false, completion: nil)
    }

}

extension ViewController: DetailViewUpdateDelegate {
    
    func addItem(item: Item, section: Int) {
        print("addItem~~~~~~~~~~~~~~")
        itemStore!.items[section].append(item)
        
        let status = UserDefaults.standard.object(forKey: "notiStatus") as! Bool
        
        if status{
            print("before calling notificate")
            notificate(item: item)
        }else{
            print("notication is off")
        }
        
        myTableView.reloadData()
        let indexPath = IndexPath(row: (itemStore?.items[section].count)!-1, section: section)
        myTableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
        
        
    }
    
    
    func saveItem() {
        myTableView.reloadData()
    }
    
    
}

extension ViewController: EditViewDelegate{
    func changeCnt(cnt: String) {
        
        if cnt == "0" {
            itemStore?.removeItem(editIdx!, editSection!)
        }else{
        let item = itemStore?.items[editSection!][editIdx!]
        item?.cnt = cnt
        itemStore?.moveItemAtIndex(from: editIdx!, to: editIdx!, section: editSection!)
        }
            
        myTableView.reloadData()
    }

}
