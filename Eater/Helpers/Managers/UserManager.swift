//
//  UserManager.swift
//  Eater
//
//  Created by Dmytro Pupena on 21.05.2021.
//

import Foundation
import Firebase

class UserManager {

    static let sharedInstance = UserManager()
    
    private var handle: AuthStateDidChangeListenerHandle?
    
    func isUserLoggedIn() -> Bool {
        return (Auth.auth().currentUser != nil)
    }
    
    func AddUserListener() {
        handle = Auth.auth().addStateDidChangeListener({ auth, user in
            if user != nil {
                print("added user listener \(String(describing: user?.email))")
            } else {
                print("could't add user")
            }
        })
    }
    
    func removeUserListener() {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    func signInUser(email: String, password: String, completion: ((Bool) -> Void)? = nil) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if error == nil {
                completion?(true)
            } else {
                print("error failed")
                completion?(false)
            }
        }
    }
    
    func signUpNewUser(email: String, password: String, completion: ((Bool) -> Void)? = nil) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
        }
    }
    
    func signOutUser(_ completion: ((Bool) -> Void)? = nil) {
        do {
            try Auth.auth().signOut()
            completion?(true)
        } catch {
            print("some problems with perform log out")
            completion?(false)
        }
    }
    
    func getUserInformation() -> User? {
        return Auth.auth().currentUser
    }
    
    
}
