//
//  ViewController.swift
//  Pinterest
//
//  Created by BLUE BLUE on 2/28/19.
//  Copyright © 2019 Luna Galilea. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController
{
    
    //variables heredan al ui
    
    
    let emailTextField : UITextField =
    {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Correo electrónico"
        tf.backgroundColor = .white
       
        return tf
    }()
    
    let passwordTextField : UITextField =
    {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Contraseña"
        tf.backgroundColor = .white
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let nameTextField : UITextField =
    {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Nombre"
        tf.backgroundColor = .white
        return tf
    }()
    
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor (r: 61, g: 91, b: 151)
        
        //añadir subview
        view.addSubview(inputContainerView)
        
        view.addSubview(firstButton)
        
        inputContainerView.addSubview(nameTextField)
        inputContainerView.addSubview(emailTextField)
        inputContainerView.addSubview(passwordTextField)
        
        //restricciones de entrada
        
        inputContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        inputContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30).isActive = true
        
        firstButton.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: 20).isActive = true
        firstButton.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor).isActive = true
        firstButton.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        firstButton.rightAnchor.constraint(equalTo: inputContainerView.rightAnchor).isActive = true
        
        
        
        
        nameTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    
        let inputContainerView : UIView =
        {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .white
            view.layer.cornerRadius = 5
            view.layer.masksToBounds = true
            return view
        }()
      lazy  var firstButton : UIButton =
          {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "profileImageView")
        
            let ub = UIButton()
            ub.backgroundColor = UIColor(red: 80/255, green: 101/255, blue: 161/255, alpha: 1)
            ub.setTitle("Register", for: .normal)
            ub.translatesAutoresizingMaskIntoConstraints = false
            ub.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
            return ub
          }()
        
    
            @objc func handleButton()
            {
                guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else
                {
                    print("No es válido")
                    return
                }
                                Auth.auth().createUser(withEmail: email, password: password) { (data:AuthDataResult?, error) in
                    let user = data?.user
                    if error != nil {
                        print(error.debugDescription)
                    }
     
                     guard let uid = user?.uid else
                     {
                     return
                     }

                    //sucessfully
                    var ref = Database.database().reference(fromURL: "https://login-ba801.firebaseio.com")
                    let values = ["name" :name, "email": email]
                    let usersRef = ref.child("users").child(uid)
                    usersRef.updateChildValues(values, withCompletionBlock: { (error, databaseRef:DatabaseReference?) in
                        if  error != nil {
                            print(error)
                        }
                    })
                    
                    // successfully included
                    print("Usuario guardado exitosamente en la base de datos")
                    
                }
    }
    
}


extension UIColor {
    
    convenience init(r:CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
}
