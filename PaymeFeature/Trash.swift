//
//  Trash.swift
//  PaymeFeature
//
//  Created by Samandar on 10/04/25.
//


//@objc func hideTheBalance() {
//    var perspective = CATransform3DIdentity
//    perspective.m34 = -1.0 / 500.0 // Add perspective effect
//
//    if showerButton.isHidden {
//        // Animate going deep away
//        UIView.animate(withDuration: 0.2, animations: {
//            self.hidderStack.layer.transform = CATransform3DConcat(perspective,
//                CATransform3DMakeScale(0.1, 0.1, 0.1)) // Zoom out
//            self.hidderStack.alpha = 0
//        }, completion: { _ in
//            self.hidderStack.isHidden = true
//            self.visibleBalanceLabel.alpha = 0
//            self.visibleBalanceLabel.isHidden = false
//            self.hidderButton.isHidden = true
//            self.showerButton.isHidden = false
//            
//            // Animate visible label appearing
//            UIView.animate(withDuration: 0.2) {
//                self.visibleBalanceLabel.alpha = 1
//            }
//        })
//    } else {
//        // Animate visible label hiding
//        UIView.animate(withDuration: 0.2, animations: {
//            self.visibleBalanceLabel.alpha = 0
//        }, completion: { _ in
//            self.visibleBalanceLabel.isHidden = true
//            self.hidderStack.alpha = 0
//            self.hidderStack.isHidden = false
//            self.hidderStack.layer.transform = CATransform3DConcat(perspective,
//                CATransform3DMakeScale(0.1, 0.1, 0.1))
//            self.showerButton.isHidden = true
//            self.hidderButton.isHidden = false
//            
//            // Animate coming back from deep
//            UIView.animate(withDuration: 0.2) {
//                self.hidderStack.layer.transform = CATransform3DIdentity
//                self.hidderStack.alpha = 1
//            }
//        })
//    }
//}


//
//class QuickPayView2: UIView {
//
//    //MARK: -UI elements
//    let balanceBtn = CircleView(imageName: "creditcard", strLabel: "My cards")
//
//    let goBtn = CircleView(imageName: "circle.hexagongrid.circle.fill", strLabel: "Payme Go")
//
//    let qrBtn = CircleView(imageName: "qrcode.viewfinder", strLabel: "QR Payment")
//
//
//
//    let wholeQuickStack: UIStackView = {
//        let stackView = UIStackView()
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .horizontal
//        stackView.alignment = .center
//        stackView.distribution = .equalSpacing
//        return stackView
//    }()
//
//    weak var delegate: CardsButtonDelegate?
//
//    init() {
//        super.init(frame: .zero)
//
//        translatesAutoresizingMaskIntoConstraints = false
//
//        wholeQuickStack.addArrangedSubview(balanceBtn)
//        wholeQuickStack.addArrangedSubview(goBtn)
//        wholeQuickStack.addArrangedSubview(qrBtn)
//
//        addSubview(wholeQuickStack)
//
//        balanceBtn.isUserInteractionEnabled = true
//
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(balanceBtnTapped))
//        balanceBtn.addGestureRecognizer(tapGesture)
//        balanceBtn.isUserInteractionEnabled = true
//
//
//        balanceBtn.backgroundColor = .red.withAlphaComponent(0.3)
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//    @objc private func balanceBtnTapped() {
//        delegate?.tapForCards()
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        delegate?.tapForCards()
//
//        print("Hello")
//    }
//
//}




//final class NetCache {
//    
//    @Published var users: [UserModel] = []
//    @Published var families: [FamilyModel] = []
//    @Published var currentUser: UserModel?
//    @Published var currentFamily: FamilyModel?
//    
//    
//    static let shared = NetCache()
//    
//    let netserVice = UsersNtworkinDataService.shared
//    
//    init() {
//        setUsers()
//        setFamilies()
//    }
//    
//    func setUsers() {
//        netserVice.getData(link: "users/") { [weak self] (users: [UserModel]?) in
//            guard let users else {
//                print("Cant get users")
//                return
//            }
//            
//            self?.users = users
//        }
//    }
//    
//    func setFamilies() {
//        
//        netserVice.getData(link: "families/") { [weak self] (families: [FamilyModel]?) in
//            guard let families else {
//                print("Cant get families")
//                return
//            }
//            
//            self?.families = families
//        }
//    }
//    
//    func setCurrentUser(id: String) {
//        netserVice.getData(link: "users/" + id) { [weak self] (user: UserModel?) in
//            guard let user else {
//                print("Cant get user")
//                return
//            }
//            
//            self?.currentUser = user
//        }
//    }
//    
//    func setCurrentFamily(id: String) {
//        netserVice.getData(link: "families/" + id) { [weak self] (family: FamilyModel?) in
//            guard let family else {
//                print("Cant get user")
//                return
//            }
//            
//            self?.currentFamily = family
//        }
//    }
//    
//}




//import Foundation
//import Combine
//import SwiftUI
//
//class LoginManager: ObservableObject {
//    
//    static let shared = LoginManager()
//    
//    
//    @Published var users: [User] = []
//    
//    @Published var loggedNetUser: UserModel?
//    
//    @Published var netUsers: [UserModel] = []
//    @Published var families: [FamilyModel] = []
//    
//    private init() {
//        loadUsersFromJSON()
//    }
//    
//    
//
//    func loadUsersFromJSON() {
//        
//        
//        UsersNtworkinDataService.shared.fetchUsers { [weak self] users in
//            guard let users else { return }
//            
//            self?.netUsers = users
//            }
//        
//        UsersNtworkinDataService.shared.fetchFamilies { [weak self] families in
//            guard let families else { return }
//            
//            self?.families = families
//        }
//        
//        
//        guard let url = Bundle.main.url(forResource: "users", withExtension: "json") else {
//            return
//        }
//        do {
//            let data = try Data(contentsOf: url)
//            let decoder = JSONDecoder()
//            decoder.dateDecodingStrategy = .iso8601
//            let decodedUsers = try decoder.decode([User].self, from: data)
//            DispatchQueue.main.async {
//                self.users = decodedUsers
//            }
//        } catch {
//            print("Error decoding users: \(error)")
//        }
//    }
//
//}
