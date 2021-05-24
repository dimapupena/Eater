//
//  LoginViewModel.swift
//  Eater
//
//  Created by Dmytro Pupena on 21.05.2021.
//

import Foundation
import FirebaseAuth

protocol LoginViewModelDelegate: AnyObject {
    func userLoggedIn()
}

class LoginViewModel {
    
    var handle: AuthStateDidChangeListenerHandle?
    weak var delegate: LoginViewModelDelegate?
    
    init() {
        print("LoginViewModel")
    }
    
    func addUserListener() {
        handle = Auth.auth().addStateDidChangeListener({ auth, user in
                
        })
    }
    
    func removeUserListener() {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    func signInUser(email: String, password: String, completion: ((Bool) -> Void)? = nil) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if error == nil {
                strongSelf.delegate?.userLoggedIn()
                completion?(true)
            } else {
                print("error failed")
                completion?(false)
            }
        }
    }
    
    func signUpNewUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
        }
    }
    
    func getUserInformation() {
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let email = user.email
        }
    }
    
}
