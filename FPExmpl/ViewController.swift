//
//  ViewController.swift
//  FPExmpl
//
//  Created by jose.galindo on 13/06/17.
//  Copyright © 2017 jose.galindo. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func accessToData(_ sender: Any) {
        let authContext = LAContext()
        var mError : NSError?
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &mError) {
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                       localizedReason: "Solo los elegidos pueden pasar", reply: { [unowned self](success : Bool, error : Error?) in
                                        if success {
                                            DispatchQueue.main.async() {
                                                self.performSegue(withIdentifier: "showData", sender: self)
                                            }
                                        } else {
                                            let mError = error as! LAError
                                            switch (mError.code) {
                                            case .appCancel:
                                                print("Auth was cancelled")
                                                break;
                                            case .authenticationFailed:
                                                print("Auth failed")
                                                break;
                                            case .invalidContext:
                                                print("Invalid context")
                                                break;
                                            case .passcodeNotSet:
                                                print("Passcode not Set")
                                                break;
                                            case .systemCancel:
                                                print("System cancelled")
                                                break;
                                            case .touchIDLockout:
                                                print("Touch lockout")
                                                break;
                                            case .touchIDNotAvailable:
                                                print("Touch not available")
                                                break;
                                            case .touchIDNotEnrolled:
                                                print("Touch not enroled")
                                                break;
                                            case .userCancel:
                                                print("user cancelled")
                                                break;
                                            case .userFallback:
                                                print("user fallback")
                                                break;
                                            }
                                        }
                
            })
        } else {
            print("No tiene lector de huella")
        }
        
    }

}

