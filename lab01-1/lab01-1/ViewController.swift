//
//  ViewController.swift
//  lab01-1
//
//  Created by Ринат Мурзалиев on 06.01.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private var imgLogin: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "login")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private var lblCaption: UILabel = {
        let lbl = UILabel()
        lbl.text = "authorization"
        lbl.textAlignment = .center
        return lbl
    }()

    private var txtLogin: UITextField = {
        let login = UITextField()
        login.placeholder = "enter login"
        login.autocapitalizationType = .none
        login.borderStyle = .roundedRect
        return login
    }()
    
    private var txtPassword: UITextField = {
        let password = UITextField()
        password.placeholder = "enter password"
        password.isSecureTextEntry = true
        password.borderStyle = .roundedRect
        return password
    }()
    
    private var btnSubmit: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("enter", for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    private func setupUI() {
        view.addSubview(lblCaption)
        view.addSubview(imgLogin)
        view.addSubview(txtLogin)
        view.addSubview(txtPassword)
        view.addSubview(btnSubmit)
    }

    private func setConstrs() {
        lblCaption.translatesAutoresizingMaskIntoConstraints = false
        imgLogin.translatesAutoresizingMaskIntoConstraints = false
        txtLogin.translatesAutoresizingMaskIntoConstraints = false
        txtPassword.translatesAutoresizingMaskIntoConstraints = false
        btnSubmit.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imgLogin.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imgLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imgLogin.heightAnchor.constraint(equalToConstant: 50),
            
            lblCaption.topAnchor.constraint(equalTo: imgLogin.bottomAnchor, constant: 20),
            lblCaption.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lblCaption.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.5),
            lblCaption.heightAnchor.constraint(equalToConstant: 50),
            
            txtLogin.topAnchor.constraint(equalTo: lblCaption.bottomAnchor, constant: 10),
            txtLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            txtLogin.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.5),
            
            txtPassword.topAnchor.constraint(equalTo: txtLogin.bottomAnchor, constant: 5),
            txtPassword.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            txtPassword.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.5),
            
            btnSubmit.topAnchor.constraint(equalTo: txtPassword.bottomAnchor, constant: 20),
            btnSubmit.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnSubmit.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.5)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(red: 0.8, green: 0.6, blue: 1.0, alpha: 1.0)
        setupUI()
        setConstrs()
    }


}

