//
//  SignInViewController.swift
//  OzinsheSnapkit18
//
//  Created by Aziza on 11.02.2024.
//

import UIKit
import SnapKit
import SVProgressHUD
import SwiftyJSON
import Alamofire
import Localize_Swift

class SignInViewController: UIViewController {
    
    let salemLabel = {
        let label = UILabel()
        label.text = "Сәлем"
        label.font =  UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "111827 - FFFFFF")
        
        return label
    }()
    
    let signInLabel = {
        let label = UILabel()
        label.text = "Аккаунтқа кіріңіз"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        label.textColor = UIColor(red: 0.42, green: 0.45, blue: 0.5, alpha: 1)
        
        return label
    }()
    
    let emailLabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        
        return label
    }()
    
    let youEmailTextfield = {
        let textField = TextFieldWithPadding()
        textField.placeholder = "Сіздің email"
        textField.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        textField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        textField.autocorrectionType = .no
        
        return textField
    }()
    
    let emailImage = {
        let image = UIImageView()
        image.image = UIImage(named: "email")
        
        return image
    }()
    
    let passwordLabel = {
        let label = UILabel()
        label.text = "Құпия сөз"
        label.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        
        return label
    }()
    
    let youPassowrdTextField = {
        let textField = TextFieldWithPadding()
        textField.placeholder = "Сіздің құпия сөзіңіз"
        textField.isSecureTextEntry = true
        textField.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        textField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        
        return textField
    }()
    
    let passwordImage = {
        let image = UIImageView()
        image.image = UIImage(named: "password")
        
        return image
    }()
    
    let showPasswordButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "showPassword"), for: .normal)
        button.addTarget(self, action: #selector(showPasswordTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var signInButton = {
        let button = UIButton()
        button.setTitle("Кіру", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        button.backgroundColor = UIColor(red: 0.49, green: 0.18, blue: 0.99, alpha: 1.00)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        
        return button
    }()
    
    let accountLabel = {
        let label = UILabel()
        label.text = " Құпия сөзді ұмыттыңыз ба??"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.textColor = UIColor(red: 0.7, green: 0.46, blue: 0.97, alpha: 1)
        label.textAlignment = .right
        
        return label
    }()
   
    var registerView: UIStackView = {
        let stackView = UIStackView()
    let accountLabel2 = {
        let label = UILabel()
        label.text = "Аккаунтыңыз жоқ па?"
        label.font = UIFont(name: "", size: 14)
        label.textColor = UIColor(red: 0.42, green: 0.45, blue: 0.50, alpha: 1.00)
        label.textAlignment = .right
        
        return label
    }()
    
    let signUpButton = {
        let button = UIButton()
        button.setTitle("Тіркелу", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        button.setTitleColor(UIColor(red: 0.7, green: 0.46, blue: 0.97, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
        return button
    }()
        
        stackView.addArrangedSubview(accountLabel2)
        stackView.addArrangedSubview(signUpButton)
        
        return stackView
    }()
    
    let errorLabel = {
        let label = UILabel()
        label.text = "Қате формат"
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        label.textColor = UIColor(red: 1, green: 0.25, blue: 0.17, alpha: 1)
        label.isHidden = true
        
        return label
    } ()
    
    var passwordLabelTopConstraint: Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        youEmailTextfield.delegate = self
        youPassowrdTextField.delegate = self
        
        setupUI()
        hideKeyboardWhenTappedAround()
       // localizedLanguage()
    }
    
    func hideKeyboardWhenTappedAround() {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            tapGesture.cancelsTouchesInView = false
            view.addGestureRecognizer(tapGesture)
        }

        @objc func hideKeyboard() {
            view.endEditing(false)
        }
    
    @objc func signIn() {
        let email = youEmailTextfield.text!
        let password = youPassowrdTextField.text!
        
        if email.isEmpty || password.isEmpty {
            
            youEmailTextfield.layer.borderColor = UIColor(red: 255/255, green: 64/255, blue: 43/255, alpha: 1.0).cgColor
            errorLabel.isHidden = false
            passwordLabelTopConstraint?.update(offset: 54)
                    } else {
            youEmailTextfield.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
            errorLabel.isHidden = true
        
        }
        UIView.animate(withDuration: 0.3) {
                        self.view.layoutIfNeeded()
        }
    
        SVProgressHUD.show()
        
        let parameters = ["email": email, "password": password]
        
        AF.request(Urls.SIGN_IN_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
            SVProgressHUD.dismiss()

            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print ("JSON: \(json)")
                
                if let token = json["accessToken"].string {
                    Storage.sharedInstance.accessToken = token
                    UserDefaults.standard.set(token, forKey: "accessToken")
                    UserDefaults.standard.set(email, forKey: "userEmail")
                    self.startApp()
                }
            } else {
                var ErrorString = "CONNECTION_ERROR".localized()
               SVProgressHUD.showError(withStatus: "\(ErrorString)")
            }
        }
        
    }
    @objc func signUp() {
        let signUpViewController = SignUpViewController()
        navigationController?.show(signUpViewController, sender: self)
        navigationItem.title = ""
    }

    func startApp() {
        let tabBarViewController = TabBarController()
        tabBarViewController.modalPresentationStyle = .fullScreen
        self.present(tabBarViewController, animated: true, completion: nil)
    }
    
    @objc func showPasswordTapped() {
        youPassowrdTextField.isSecureTextEntry = !youPassowrdTextField.isSecureTextEntry
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(named: "FFFFFF - 111827")
        
        view.addSubview(salemLabel)
        view.addSubview(signInLabel)
        view.addSubview(emailLabel)
        view.addSubview(youEmailTextfield)
        view.addSubview(emailImage)
        view.addSubview(passwordLabel)
        view.addSubview(youPassowrdTextField)
        view.addSubview(passwordImage)
        view.addSubview(showPasswordButton)
        view.addSubview(signInButton)
        view.addSubview(accountLabel)
        view.addSubview(registerView)
        view.addSubview(errorLabel)
        
        salemLabel.snp.makeConstraints { make in
            make.left.equalTo(24)
            make.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(16)
        }
        signInLabel.snp.makeConstraints { make in
            make.left.right.equalTo(24)
            make.top.equalTo(salemLabel.snp.bottom).inset(0)
        }
        emailLabel.snp.makeConstraints { make in
            make.left.right.equalTo(24)
            make.top.equalTo(signInLabel.snp.bottom).offset(29)
        }
        youEmailTextfield.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
            make.top.equalTo(emailLabel.snp.bottom).offset(4)
        }
        emailImage.snp.makeConstraints { make in
            make.centerY.equalTo(youEmailTextfield)
            make.leading.equalTo(youEmailTextfield.snp.leading).inset(16)
        }
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(youEmailTextfield.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(22)
        }
        passwordLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            self.passwordLabelTopConstraint = make.top.equalTo(youEmailTextfield.snp.bottom).offset(8).constraint
        }
        youPassowrdTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
            make.top.equalTo(passwordLabel.snp.bottom).offset(4)
        }
        passwordImage.snp.makeConstraints { make in
            make.centerY.equalTo(youPassowrdTextField)
            make.leading.equalTo(youPassowrdTextField.snp.leading).inset(16)
        }
        showPasswordButton.snp.makeConstraints { make in
            make.centerY.equalTo(youPassowrdTextField)
            make.right.equalTo(youPassowrdTextField.snp.right).inset(16)
        }
        accountLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(24)
            make.top.equalTo(youPassowrdTextField.snp.bottom).offset(24)
        }
        signInButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
            make.top.equalTo(youPassowrdTextField.snp.bottom).offset(79)
        }

        registerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signInButton.snp.bottom).offset(24)
        }
    }
        func localizedLanguage() {
            salemLabel.text = "HELLO_LABEL".localized()
            signInLabel.text = "DETAIL_SIGN_IN".localized()
            youEmailTextfield.placeholder = "SIGN_UP_EMAIL".localized()
            youPassowrdTextField.placeholder = "USER_PASSWORD_CHANGE".localized()
            signInButton.setTitle("SIGN_IN_BUTTON_UP".localized(), for: .normal)
            passwordLabel.text = "CHANGE_PASSWORD_LABEL".localized()
        }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == youEmailTextfield {
            youEmailTextfield.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
            } else if textField == youPassowrdTextField {
                youPassowrdTextField.layer.borderColor = UIColor(red: 0.59, green: 0.33, blue: 0.94, alpha: 1.00).cgColor
            }
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            if textField == youEmailTextfield {
                youEmailTextfield.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
            } else if textField == youPassowrdTextField {
                youPassowrdTextField.layer.borderColor = UIColor(red: 0.90, green: 0.92, blue: 0.94, alpha: 1.00).cgColor
            }
        }
    }
    
