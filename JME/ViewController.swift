//
//  ViewController.swift
//  JME
//
//  Created by xuzhongwei on 2018/12/02.
//  Copyright © 2018 xuzhongwei. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate{
    
    
    var delegate:SideMenuProtocol?


    @IBOutlet weak var tableView: UITableView!
    var chatSentence:[Sentence] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupUI()
        initData()
        
    }
    
    @IBAction func flip(_ sender: UIButton) {
        
        
        if(delegate != nil){
            delegate?.slide()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    func setupUI(){
        self.view.backgroundColor = UIColor(red: 113/255, green: 148/255, blue: 194/255, alpha: 1)
        tableView.backgroundColor = UIColor(red: 113/255, green: 148/255, blue: 194/255, alpha: 1)
        tableView.separatorColor = UIColor.clear // セルを区切る線を見えなくする
        
        tableView.register(UINib(nibName: "MyChatCell", bundle: nil), forCellReuseIdentifier: "MyChatItem")
        tableView.register(UINib(nibName: "PartnerCell", bundle: nil), forCellReuseIdentifier: "PartnerItem")
        
        
        tableView.estimatedRowHeight = 5 // セルが高さ以上になった場合バインバインという動きをするが、それを防ぐために大きな値を設定
        tableView.rowHeight = UITableView.automaticDimension
        
        
        tableView.allowsSelection = false // 選択を不可にする
        tableView.keyboardDismissMode = .interactive // テーブルビューをキーボードをまたぐように下にスワイプした時にキーボードを閉じる
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func initData(){
        let sentence1 = Sentence.init("Yo", convertStringToNSDate("2015/03/04 12:34:56 +09:00","yyyy/MM/dd HH:mm:ss Z"), Identity.YOU)
        let sentence2 = Sentence.init("Sup?", convertStringToNSDate("2015/03/04 12:35:13 +09:00","yyyy/MM/dd HH:mm:ss Z"), Identity.ME)
        let sentence3 = Sentence.init("You workin today?", convertStringToNSDate("2015/03/04 12:36:27 +09:00","yyyy/MM/dd HH:mm:ss Z"), Identity.YOU)
        sentence3.setEnglishExplanation("Sometimes native speakers drop the \"g\" at the end of a word.So \"working\" becomes \"workin\".")
        sentence3.setJapaneseExplanation("時々、ネイティブは単語の最後の\"g\"を省略するよ！だからworkingはworkinになるんだ。")
        
        let sentence4 = Sentence.init("Yah,but I'm off early", convertStringToNSDate("2015/03/04 12:37:16 +09:00","yyyy/MM/dd HH:mm:ss Z"), Identity.ME)
        let sentence5 = Sentence.init("What time?", convertStringToNSDate("2015/03/04 12:38:12 +09:00","yyyy/MM/dd HH:mm:ss Z"), .YOU)
        let sentence6 = Sentence.init("5", convertStringToNSDate("2015/03/04 12:39:07 +09:00","yyyy/MM/dd HH:mm:ss Z"), .ME)
        let sentence7 = Sentence.init("Maybe 5:30", convertStringToNSDate("2015/03/04 12:40:16 +09:00","yyyy/MM/dd HH:mm:ss Z"), .ME)
        let sentence8 = Sentence.init("Sick. Wanna come over?", convertStringToNSDate("2015/03/04 12:41:12 +09:00","yyyy/MM/dd HH:mm:ss Z"), .YOU)
        let sentence9 = Sentence.init("Sure thang", convertStringToNSDate("2015/03/04 12:42:12 +09:00","yyyy/MM/dd HH:mm:ss Z"), .ME)
        let sentence10 = Sentence.init("I got somethin to do until 7 tho", convertStringToNSDate("2015/03/04 12:43:16 +09:00","yyyy/MM/dd HH:mm:ss Z"), .ME)
        let sentence11 = Sentence.init("np", convertStringToNSDate("2015/03/04 12:44:56 +09:00","yyyy/MM/dd HH:mm:ss Z"), .YOU)
        
        chatSentence.append(sentence1)
        chatSentence.append(sentence2)
        chatSentence.append(sentence3)
        chatSentence.append(sentence4)
        chatSentence.append(sentence5)
        chatSentence.append(sentence6)
        chatSentence.append(sentence7)
        chatSentence.append(sentence8)
        chatSentence.append(sentence9)
        chatSentence.append(sentence10)
        chatSentence.append(sentence11)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if chatSentence[indexPath.row].identiry == Identity.ME {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyChatItem") as!  MyChatCell
            cell.chatContent.text = chatSentence[indexPath.row].content
            cell.timeLabel.text = convertNSDateToString(chatSentence[indexPath.row].time)
            
            cell.ChatView.layer.cornerRadius = 15
            cell.delegate = self
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PartnerItem") as! PartnerCell
            cell.chatContent.text = chatSentence[indexPath.row].content
            cell.chatView.layer.cornerRadius = 15
            cell.timeLabel.text = convertNSDateToString(chatSentence[indexPath.row].time)
            cell.delegate = self
            return cell
        }
        
    }

    //http://grandbig.github.io/blog/2016/02/19/swift-date/
    func convertNSDateToString(_ dateShouldBeConverted:NSDate)->String{
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: dateShouldBeConverted as Date)
    }
    
    //https://qiita.com/k-yamada-github/items/8b6411959579fd6cd995
    func convertStringToNSDate(_ stringShouldBeConverted:String,_ format: String)->NSDate{
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar.current
        formatter.dateFormat = format
        return formatter.date(from: stringShouldBeConverted)! as NSDate
    }
    
    
}

extension ViewController: CellDelegate {
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gogogo" {
            let explainController = segue.destination as! ExplainViewController
            explainController.parameter = sender as? Sentence
        }
    }
    
    func CellContentClick(_ index: Int) {
        print("dream\(index)")
        
        if let english = chatSentence[index].englishExplanation {
            if let japanese = chatSentence[index].japaneseExplanation{
                print(english)
                print(japanese)
                performSegue(withIdentifier: "gogogo", sender: chatSentence[index])
            }
        }
    
    }
    
}
