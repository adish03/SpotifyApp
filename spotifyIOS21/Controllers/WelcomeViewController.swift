//
//  WelcomeViewController.swift
//  spotifyAnalogSwift
//
//  Created by Isa Melsov on 31/1/24.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let signInButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.setTitle("Sign In with Spotify", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spotify"
        view.backgroundColor = .systemGreen
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        signInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc private func didTapSignIn() {
        let vc = AuthViewController()
        vc.completionhandler = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func handleSignIn(success: Bool) {
        guard success else {
            let alert = UIAlertController(title: "Oй", message: "Что-то пошло не так", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        let mainTabBarVC = SearchViewController()
//        self.navigationController?.pushViewController(mainTabBarVC, animated: true)
        present(mainTabBarVC, animated: true)
    }
}
