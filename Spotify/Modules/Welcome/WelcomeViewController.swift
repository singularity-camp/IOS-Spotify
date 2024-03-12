//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by rauan on 2/22/24.
//

import UIKit

class WelcomeViewController: UIViewController {

    var titleName: String?
    private lazy var singInButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign In with Spotify", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()   
    }
   
    
    private func setupViews() {
        
        if titleName != nil {
            navigationItem.title = titleName
        } else {
            navigationItem.title = "Spotify"
        }
        
        view.backgroundColor = .systemGreen
        view.addSubview(singInButton)
        singInButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
        }
    }
    
    @objc
    private func didTapSignIn() {
        let controller = AuthViewController()
        controller.completionHandler = { [weak self] success in
            self?.handleSignIn(success: success)
        }
        controller.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func handleSignIn(success: Bool) {
        guard success else {
            let alert = UIAlertController(title: "Ohh nooo...", message: "Something went wrong when signing", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            return
        }
        
        let tabbarViewController = TabBarViewController()
        tabbarViewController.modalPresentationStyle = .fullScreen
        present(tabbarViewController, animated: true)
    }
}
