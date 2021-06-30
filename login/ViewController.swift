//
//  ViewController.swift
//  login
//
//  Created by 홍태희 on 2021/06/30.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    
    //바깥에 전역으로 선언
    var emailErrorHeight : NSLayoutConstraint!
    var passwordErrorHeight : NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //TextField 값이 변경되는 것을 캐치하는게 없다 (세팅해줘야 함)
        emailTextField.addTarget(self, action: #selector(textFieldEdited), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldEdited), for: .editingChanged)
        
        //높이의 변화 ( 조건에 맞게 들어갔다가 나왔다하는 부분.. heightAnchor )
        emailErrorHeight = emailError.heightAnchor.constraint(equalToConstant: 0)
        passwordErrorHeight = passwordError.heightAnchor.constraint(equalToConstant: 0)
    }

    @objc func textFieldEdited(textField : UITextField) {
        
        if textField == emailTextField {
            //값이 변경되는 걸 실시간으로 콘솔에 노출
            print("이메일 \(textField.text!)")
            
            if isValidEmail(email: textField.text) == true {
                //정규식이 맞을 경우 에러표시 X
                emailErrorHeight.isActive = true
                
            } else {
                //활성화를 비활성화로!!
                emailErrorHeight.isActive = false
            }
            
        } else if textField == passwordTextField {
            print("비밀번호 \(textField.text!)")
            if isValidPassword(pw: textField.text) == true {
                passwordErrorHeight.isActive = true
            } else {
                passwordErrorHeight.isActive = false
            }
        }
        
        //액션을 주어 자연스럽도록 한다.
        UIView.animate(withDuration: 0.1) {
            //withDuration에 맞춰서 계속 화면 갱신
            self.view.layoutIfNeeded()
        }
        
    }
    
    //정규식 - regular expression
    //이메일 형식을 검사하려면 정규표현식에 대한 기본지식이 필요하다
    func isValidEmail(email:String?) -> Bool {
        
        guard email != nil else { return false }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        //이 정규식이 정확하게 맞는지 여부
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        //true, false 값
        return pred.evaluate(with: email)
    }
    
    func isValidPassword(pw:String?) -> Bool {
        
        //조금 더 깔끔한 "if let" 구문
        if let hasPassword = pw {
            if hasPassword.count < 8 {
                return false
            }
        }
        
//        if (pw?.count)! < 8 {
//            return false
//        }
        
        return true
    }
}

