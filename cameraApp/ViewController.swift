//
//  ViewController.swift
//  cameraApp
//
//  Created by 篠原立樹 on 2018/11/10.
//  Copyright © 2018 Ostrich. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var pictureImage: UIImageView!
    
    //カメラを起動するをタップしたら実行
    @IBAction func cameraButtonAction(_ sender: Any) {
        //カメラかフォトライブラリーどちらから画像を取得するか選択
        let alertController = UIAlertController(title: "確認", message: "選択してください", preferredStyle: .actionSheet)
        
        //カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            //カメラを起動するための選択肢を定義
            let cameraAction = UIAlertAction(title: "カメラ", style: .default, handler: {(action: UIAlertAction) in
                //カメラを起動
                let imagePickerController : UIImagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .camera
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        //フォトライブラリーが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            //フォトライブラリーを起動するための選択肢を定義
            let photoLibraryAction = UIAlertAction(title: "フォトライブラリー", style: .default, handler: {(action:UIAlertAction) in
                //フォトライブラリーを起動
                let imagePickerController : UIImagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .photoLibrary
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        
        
        //キャンセルの選択肢を定義
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        //ipadで落ちてしまう対策
        alertController.popoverPresentationController?.sourceView = view
        //選択肢を画面に表示
        present(alertController, animated: true, completion: nil)
        
    }
    
    //SNSに投稿するをタップしたら実行
    @IBAction func SNSButtonAction(_ sender: Any) {
        //表示画面をアンラップしてシェア画像として取り出す
        if let shareImage = pictureImage.image {
            //UIActivityViewControllerに渡す配列を作成
            let shareItems = [shareImage]
            //UIActivityViewControllerにシェア画像を渡す
            let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
            //ipadで落ちてしまう対策
            controller.popoverPresentationController?.sourceView = view
            //UIActivityViewControllerを表示
            present(controller, animated: true, completion: nil)
        }
    }
    
    //撮影が終わった時に呼ばれdelegateメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //撮影した写真を、UIImage型にキャストして、配置したpidtureImageに渡す
        pictureImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        //モーダルビューを閉じる
        dismiss(animated: true, completion: nil)
    }
    
}

