//  MainViewController.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import UIKit

protocol MainViewControllerProtocol: AnyObject {
    func setupView()
}

class MainViewController: UITabBarController {
    
    // MARK: - Properties
    
    var viewModel: MainViewModel!
    
    private lazy var chatListView: UINavigationController = {
        let chatListView = ChatListRouter.getViewController()
        let tab0 = UITabBarItem(
            title: "Chats",
            image: UIImage(systemName: "message"),
            tag: 0
        )
        chatListView.tabBarItem = tab0

        return chatListView
    }()
    
    private lazy var channelListView: UINavigationController = {
        let channelListView = ChannelListRouter.getViewController()
        let tab1 = UITabBarItem(
            title: "Channels",
            image: UIImage(systemName: "quote.bubble"),
            tag: 1
        )
        channelListView.tabBarItem = tab1

        return channelListView
    }()
    
    private lazy var userListView: UINavigationController = {
        let userListView = UserListRouter.getViewController()
        let tab2 = UITabBarItem(
            title: "Users",
            image: UIImage(systemName: "person.2"),
            tag: 2
        )
        userListView.tabBarItem = tab2

        return userListView
    }()
    
    private lazy var settingsView: UINavigationController = {
        let settingsView = SettingsRouter.getViewController()
        let tab3 = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gear"),
            tag: 3
        )
        settingsView.tabBarItem = tab3

        return settingsView
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemBackground
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
        
        viewModel.viewDidAppear()
    }
}

// MARK: - MainViewControllerProtocol

extension MainViewController: MainViewControllerProtocol {
    
    func setupView() {
        let controllers: [UIViewController] = [chatListView, channelListView, userListView, settingsView]
        viewControllers = controllers
    }
}
