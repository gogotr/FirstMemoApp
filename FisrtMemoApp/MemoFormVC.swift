//
//  MemoFormVC.swift
//  FisrtMemoApp
//
//  Created by 이상묵 on 2018. 9. 25..
//  Copyright © 2018년 이상묵. All rights reserved.
//

import UIKit

class MemoFormVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    var subject : String!
    @IBOutlet var memoContent: UITextView!
    @IBOutlet var imagePreview: UIImageView!
    
    @IBAction func saveBtn(_ sender: Any) {
        //입력창에 아무것도 없을 경우
        guard self.memoContent.text?.isEmpty == false else{
            //경고창 띄우기
            let alert = UIAlertController(title:nil, message:"내용을 입력해주세요",preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"OK", style:.default, handler:nil))
            self.present(alert, animated: true)
            return
        }
        //appDelegate에서 변수 가져오기
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //memodata 객체 생성
        let tempMemoData = MemoData()
        tempMemoData.content = self.memoContent.text
        tempMemoData.title = self.subject
        tempMemoData.image = self.imagePreview.image
        tempMemoData.regdate = Date()
        
        //데이터 전달
        appDelegate.memoList.append(tempMemoData)
        
        // 작성폼 화면을 종료하고 이전화면으로 돌아간다
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func cameraBtn(_ sender: Any) {
        
        let picker = UIImagePickerController()
        //delegate 설정
        picker.delegate = self
        
        //이미지 허용 권한
        picker.allowsEditing = true
        
        //이미지 피커 표시
        self.present(picker, animated: true)
    }
    
    //imagePicker, delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
    self.imagePreview.image = info[UIImagePickerControllerEditedImage] as? UIImage
        
        picker.dismiss(animated: true)
    }
    
    //text edit, delegate
    //글자가 입력될때마다 호출됨
    func textViewDidChange(_ textView: UITextView) {
        let contents = memoContent.text as NSString
        let length = ((contents.length > 15) ? 15 : contents.length)
        
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        //입력된 글자가 하나도 없을 경우 설정
        if self.subject == ""
        {
            self.subject = "No Title"
        }
        
        self.navigationItem.title = subject
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //text area의 delegate 설정
        self.memoContent.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
