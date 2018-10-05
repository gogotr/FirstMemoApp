//
//  MemoReadVC.swift
//  FisrtMemoApp
//
//  Created by 이상묵 on 2018. 9. 25..
//  Copyright © 2018년 이상묵. All rights reserved.
//

import UIKit

class MemoReadVC: UIViewController {

    var param: MemoData?
    
    @IBOutlet var readTitle: UILabel!
    @IBOutlet var readContents: UILabel!
    @IBOutlet var readImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.readTitle.text = param?.title
        self.readContents.text = param?.content
        self.readImgView.image = param?.image
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM월 dd일 HH시 mm분에 작성됨"
        let dateString = formatter.string(from: (param?.regdate)!)
        self.navigationItem.title = dateString
        // Do any additional setup after loading the view.
    }
}
