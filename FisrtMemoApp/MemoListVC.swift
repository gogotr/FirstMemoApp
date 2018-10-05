//
//  MemoListVC.swift
//  FisrtMemoApp
//
//  Created by 이상묵 on 2018. 9. 25..
//  Copyright © 2018년 이상묵. All rights reserved.
//

import UIKit

class MemoListVC: UITableViewController {
    
    //appdelegate global vals
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //viewdidload가 아닌 viewwillapper를 사용하는 이유
    //viewdidload는 목록으로 다시 돌아올때 새로운 뷰가 아닌 이전 뷰를 사용하기때문에!!
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    //테이블 행 선택 이벤트
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = appDelegate.memoList[indexPath.row]
        //데이터를 보낼 스토리보드를 찾는다.
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoRead") as? MemoReadVC else { return }
        
        vc.param = row
        //해당 화면을 연다
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //테이블 뷰 이벤트
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.memoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.appDelegate.memoList[indexPath.row]
        let cellId = row.image == nil ? "memoCell" : "memoCellWithImage"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MemoCell
        
        cell.subject?.text = row.title
        cell.contents?.text = row.content
        cell.imgview?.image = row.image
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.regdate?.text = dateformatter.string(from: row.regdate!)
        
        return cell
    }
}
