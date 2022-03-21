//
//  LoginViewController.swift
//  FilmBox
//
//  Created by Ahmet Enes Irmak on 3.01.2022.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet weak var labelEmail: UITextField!
    @IBOutlet weak var labelPassword: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        labelEmail.text = "BlackRiver12"
        labelPassword.text = "Enes20152000"
        // Do any additional setup after loading the view.
    }
    

    @IBAction func signButton(_ sender: Any) {
        
        
     AF.request("https://api.themoviedb.org/3/authentication/token/new?api_key=4e327d95ae9fe00905bdafe0f8287338").responseDecodable { (response:AFDataResponse<TokenResponse>) in
         switch response.result{
             case .success(let movieResponse):
                 BaseData.shared.token = movieResponse.requestToken
             self.sendRequest()
             case .failure(let error):
                 print(error)
             break
         }
     }

     
     NotificationCenter.default.addObserver(self, selector: #selector(addNotificationDetail), name: .notificationMovie, object: nil)
         
         var username = labelEmail.text ?? ""
         var password = labelPassword.text ?? ""
      
 }
 
 func sendRequest(){

     let headers: HTTPHeaders = [
         "Accept": "application/json"
     ]
     
     
     var login = AuthRequestBody.init(username: labelEmail.text, password: labelPassword.text, request_token: (BaseData.shared.token ?? ""))

     
     AF.request("https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=4e327d95ae9fe00905bdafe0f8287338", method: .post, parameters: login, encoder: .json, headers: headers).responseDecodable { (response:AFDataResponse<TokenResponse>) in
         switch response.result{
             case .success(let response):
             if(response.success ?? false){
                 self.performSegue(withIdentifier: "showMainViewController", sender: nil)
                 
                 /*
                 let vc = self.storyboard?.instantiateViewController(withIdentifier: "Main") as! MainViewController;
                 vc.modalPresentationStyle = .fullScreen
                 self.present(vc, animated: true, completion: nil)*/
             }
             case .failure(let error):
                 print(error)
             break
         }
     }
     
 }
 @objc func addNotificationDetail () {
     print("Notification received")
 }

    }
    


