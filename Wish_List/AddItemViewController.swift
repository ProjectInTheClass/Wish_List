//
//  AddItemViewController.swift
//  Wish_List
//
//  Created by ljh on 2018. 6. 7..
//  Copyright © 2018년 test. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var goal: UITextField!
    @IBOutlet weak var deadline: UIDatePicker!
    @IBOutlet weak var memo: UITextView!
    @IBOutlet weak var image: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    //var destVC = WishItemsViewController()
    
    @IBAction func selectImage(_ sender: Any) {
        //imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let pickedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //image.contentMode = .scaleAspectFit
        image.image = pickedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirm(_ sender: Any) {
        //print("pppp")
        let temp = Wish_Item(name: name.text!, favorite: false)
        if let tmpPrice = goal.text {
            temp.price = Int(tmpPrice)
        } else {
            temp.price = nil
        }
        temp.d_day = deadline.date as Date
        temp.favorite = false
        temp.memo = memo.text!
        temp.img = image.image!
        
        Items.append(temp)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = UIImage(named: "noimg")
        ImgDesign(Imgview: image)
        imagePicker.delegate = self
        name.delegate = self
        goal.delegate = self
        memo.delegate = self

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*print("ppap")
        let destVC = segue.destination as! WishItemsViewController
        if let tmp = temp {
            destVC.tempItem = tmp
            print("aaa")
        } else {
            destVC.tempItem = nil
            print("bbb")
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func ImgDesign(Imgview : UIImageView){
        Imgview.layer.borderWidth = 1
        Imgview.layer.masksToBounds = false
        Imgview.layer.borderColor = UIColor.black.cgColor
        Imgview.layer.cornerRadius = (Imgview.frame.height) / 2
        Imgview.clipsToBounds = true
    }
}
