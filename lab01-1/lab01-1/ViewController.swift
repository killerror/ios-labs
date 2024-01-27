//
//  ViewController.swift
//  lab01-1
//
//  Created by Ринат Мурзалиев on 06.01.2024.
//

import UIKit
import WebKit
import Foundation


struct PhotosStruct: Decodable {
    let response: PhotoItems
}

struct PhotoItems: Decodable {
    let items: [PhotoSizes]
}

struct PhotoSizes: Decodable {
    let sizes: [Photo]
}

struct Photo: Decodable {
    let url: String
}

// ----------

struct GroupsStuct: Decodable {
    let response: GroupsItems
}

struct GroupsItems: Decodable {
    let items: [Group]
}

struct Group: Decodable {
    let desc: String?
    let name: String
    let photo: String
    enum CodingKeys: String, CodingKey{
        case desc = "description"
        case name = "name"
        case photo = "photo_50"
    }
}

// ----------

struct FriendsStuct: Decodable {
    let response: FriendsItems
}

struct FriendsItems: Decodable {
    let items: [Friend]
}

struct Friend: Decodable {
    let firstName: String
    let lastName: String
    let photo: String
    enum CodingKeys: String, CodingKey{
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_50"
    }
}


class NetworkService {
    static var token = ""

    static let session = URLSession.shared

    func getGroups() {
        guard let url = URL(string: "https://api.vk.com/method/groups.get?access_token=\(NetworkService.token)&v=5.199&extended=1&fields=description") else {return}
        NetworkService.session.dataTask(with: url) { (data, _, networkError) in
            guard let data = data else {return}
            do {
                let groups = try JSONDecoder().decode(GroupsStuct.self, from: data)
                print(groups)
            } catch {print(error)}
        }.resume()
    }

    func getFriends() {
        guard let url = URL(string: "https://api.vk.com/method/friends.get?access_token=\(NetworkService.token)&v=5.199&fields=photo_50") else {return}
        NetworkService.session.dataTask(with: url) { (data, _, networkError) in
            guard let data = data else {return}
            do {
                let friends = try JSONDecoder().decode(FriendsStuct.self, from: data)
                print(friends)
            } catch {print(error)}
        }.resume()
    }
    
    func getPhotos() {
        guard let url = URL(string: "https://api.vk.com/method/photos.get?access_token=\(NetworkService.token)&v=5.199&album_id=wall") else {return}
        NetworkService.session.dataTask(with: url) { (data, _, networkError) in
            guard let data = data else {return}
            do {
                let photos = try JSONDecoder().decode(PhotosStruct.self, from: data)
                print(photos)
            } catch {print(error)}
        }.resume()
    }
    
}

class ViewController: UIViewController, WKNavigationDelegate {

/*
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
        button.addTarget(self, action: #selector(btnSubmitTap), for: .touchUpInside)
        return button
    }()
*/
    
/*    private func setupUI() {
        view.addSubview(lblCaption)
        view.addSubview(imgLogin)
        view.addSubview(txtLogin)
        view.addSubview(txtPassword)
        view.addSubview(btnSubmit)
    } */

/*    private func setConstrs() {
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
    } */
    
/*    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(red: 0.8, green: 0.6, blue: 1.0, alpha: 1.0)
        setupUI()
        setConstrs()
    } */

    private lazy var webView: WKWebView = {
        let wv = WKWebView(frame: view.bounds)
        wv.navigationDelegate = self
        return wv
    }()
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping(WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let frag = url.fragment else {
            decisionHandler(.allow)
            return
        }
        let params = frag
                    .components(separatedBy: "§")
                    .map { $0.components(separatedBy: "=") }
                    .reduce([String: String]()) { result, param in
                        var dict = result
                        let key = param[0]
                        let value = param[1]
                        dict[key] = value
                        return dict
                    }
        NetworkService.token = params["access_token"] ?? ""
        print(NetworkService.token)
        decisionHandler(.cancel)
        webView.removeFromSuperview()
        btnSubmitTap()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "ViewController"
        setupUI()
        let infoScope = "262150"
        guard let url = URL(string: "https://oauth.vk.com/authorize?client_id=51843071&redirect_uri=https://oauth.vk.com/blank.html&response_type=token&display=mobile&scope=\(infoScope)") else {return}
        webView.load(URLRequest(url:url))
    }
    
    private func setupUI() {
        view.addSubview(webView)
    }

}

private extension ViewController {
   
    @objc func btnSubmitTap() {
        let tab1 = UINavigationController(rootViewController: FriendsTab())
        tab1.tabBarItem.title = "Friends"
        let tab2 = UINavigationController(rootViewController: GroupsTab())
        tab2.tabBarItem.title = "Groups"
        let tab3 = UINavigationController(rootViewController: PhotosTab(collectionViewLayout: UICollectionViewFlowLayout()))
        tab3.tabBarItem.title = "Photos"

        let tabs = [tab1, tab2, tab3]
        let tabBarCtrlr = UITabBarController()
        tabBarCtrlr.viewControllers = tabs
        navigationController?.pushViewController(tabBarCtrlr, animated: true)
        navigationController?.navigationBar.isHidden = true
        
    }
    
}
