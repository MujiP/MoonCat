
import UIKit
import CoreGraphics

class ImageUpload_VC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var myImageView : UIImageView!
    var button:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        button = UIButton(frame: CGRect(x: 100, y: 270, width: 200, height: 50))
        button.backgroundColor = .green
        button.setTitle("Upload profile pic", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.myImageView = UIImageView(frame: CGRect(x: 150, y:100 , width: 100, height: 100))
        myImageView.image = UIImage(named:"profile_blank")
        self.view.addSubview(myImageView)
        self.view.addSubview(button)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        let picker_controller = UIImagePickerController()
        picker_controller.delegate = self;
        picker_controller.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(picker_controller, animated: true, completion: nil)
        
    }
    
    //optional function in declration of UIImagePickerController
    @available(iOS 2.0, *)
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        myImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        myImageView.backgroundColor = UIColor.clear
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func uploadImage(){
        //check if image is not null
        let imageData = myImageView.image?.jpegData(compressionQuality: 1)
        if(imageData == nil ) { return }
        //disable button to stop user from tapping on it more than once
        self.button.isEnabled = false
        
        //start uploading
        
        //        let r = URLRequest(url: URL(string: "")!)
        //
        //        URLSession.shared.uploadTask(with: r, from: imageData) { (data, response, error) in
        
    }
    
}



