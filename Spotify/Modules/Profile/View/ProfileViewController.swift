//
//  ProfileViewController.swift
//  Spotify
//
//  Created by rauan on 3/1/24.
//

import UIKit
import SnapKit
import Kingfisher

class ProfileViewController: UIViewController {
    private var viewModel: ProfileViewModel?
    
    private lazy var profilePicture: UIImageView = {
        let profilePicture = UIImageView()
        profilePicture.contentMode = .scaleAspectFill
        profilePicture.clipsToBounds = true
        profilePicture.layer.cornerRadius = 10
        return profilePicture
    }()
    
    private lazy var infoDashboard: UIView = {
        let infoDashboard = UIView()
        infoDashboard.backgroundColor = .black
        infoDashboard.layer.cornerRadius = 10
        return infoDashboard
    }()
    
    private lazy var infoStack: UIStackView = {
        let infoStack = UIStackView()
        infoStack.axis = .horizontal
        infoStack.alignment = .center
        
        infoStack.distribution = .fillEqually
        return infoStack
    }()
    
    private lazy var nameStack: UIStackView = {
        let nameStack = UIStackView()
        nameStack.axis = .vertical
        nameStack.alignment = .center
        nameStack.spacing = 8
        nameStack.distribution = .fillEqually
        return nameStack
    }()
    
    private lazy var planStack: UIStackView = {
        let planStack = UIStackView()
        planStack.axis = .vertical
        planStack.alignment = .center
        planStack.spacing = 8
        planStack.distribution = .fillEqually
        return planStack
    }()
    
    private lazy var countryStack: UIStackView = {
        let countryStack = UIStackView()
        countryStack.axis = .vertical
        countryStack.alignment = .center
        countryStack.spacing = 8
        countryStack.distribution = .fillEqually
        return countryStack
    }()
    
    private lazy var displayNameTitle: UILabel = {
        let displayNameTitle = UILabel()
        displayNameTitle.textColor = .subtitle
        displayNameTitle.font = UIFont.systemFont(ofSize: 13)
        displayNameTitle.text = "Username"
        return displayNameTitle
    }()
    
    private lazy var countryTitle: UILabel = {
        let countryTitle = UILabel()
        countryTitle.text = "Country"
        countryTitle.font = UIFont.systemFont(ofSize: 13)
        countryTitle.textColor = .subtitle
        return countryTitle
    }()

    
    private lazy var planTitle: UILabel = {
        let planTitle = UILabel()
        planTitle.text = "Plan"
        planTitle.textColor = .subtitle
        planTitle.font = UIFont.systemFont(ofSize: 13)
        return planTitle
    }()
    private lazy var displayName: UILabel = {
        let displayName = UILabel()
        displayName.textColor = .white
        displayName.font = UIFont.systemFont(ofSize: 16)
        displayName.text = "displayName"
        return displayName
    }()
    
    private lazy var country: UILabel = {
        let country = UILabel()
        country.text = "country"
        country.font = UIFont.systemFont(ofSize: 16)
        country.textColor = .white
        return country
    }()
    
    private lazy var plan: UILabel = {
        let plan = UILabel()
        plan.text = "email"
        plan.textColor = .white
        plan.font = UIFont.systemFont(ofSize: 16)
        return plan
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViewModel()
        setupViews()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupViews() {
        navigationItem.title = "Profile"
        view.backgroundColor = .mainBackground
        
        [profilePicture, infoDashboard].forEach {
            view.addSubview($0)
        }
        
        infoDashboard.addSubview(infoStack)
        
        [nameStack, countryStack, planStack].forEach {
            infoStack.addArrangedSubview($0)
        }
        
        [displayNameTitle, displayName].forEach {
            nameStack.addArrangedSubview($0)
        }
        [planTitle, plan].forEach {
            planStack.addArrangedSubview($0)
        }
        [countryTitle, country].forEach {
            countryStack.addArrangedSubview($0)
        }
        
        profilePicture.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.height.equalTo(300)
        }
        
        infoDashboard.snp.makeConstraints { make in
            make.top.equalTo(profilePicture.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(90)
        }
        
        infoStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    private func setupViewModel() {
        viewModel = ProfileViewModel()
        viewModel?.getData(completion: { [weak self] data in
            DispatchQueue.main.async {
                self?.displayName.text = data.displayName
                self?.plan.text = data.product
                self?.country.text = data.country
                let urlString = data.images[0].url
                let urlImage = URL(string: urlString)
                self?.profilePicture.kf.setImage(with: urlImage)
                print("ImageURL: \(data.images[0].url)")
            }
        })
    }

}


