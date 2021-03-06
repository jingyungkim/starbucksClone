//
//  SirenOrderMainViewController.swift
//  StarbucksClone
//
//  Created by Mac mini on 2020/06/15.
//  Copyright © 2020 momo. All rights reserved.
//

import UIKit

class SirenOrderMainViewController: UIViewController {
  
  // MARK: Property
  let sectionTitles = ["안나님을 위한 추천 메뉴", "새로 나온 메뉴", "함께 하면 좋은 푸드 메뉴"]
  
  // MARK: View
  private var sirenOrderTableView = UITableView().then {
    $0.backgroundColor = #colorLiteral(red: 0.9161977768, green: 0.9009630084, blue: 0.8896496296, alpha: 1)
    $0.showsVerticalScrollIndicator = false
    $0.separatorStyle = .none
  }
  
  // MARK: Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  // MARK: Initialize
  private func setupUI() {
    setupAttributes()
    setupConstraints()
  }
  
  private func setupAttributes() {
    view.backgroundColor = #colorLiteral(red: 0.9161977768, green: 0.9009630084, blue: 0.8896496296, alpha: 1)
    setupTableView()
    setupNavigationBar()
  }
  
  private func setupNavigationBar() {
    title = "사이렌 오더"
    navigationController?.navigationBar.tintColor = .white
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: nil)
    
    let searchBarButton = UIButton().then {
      $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
      $0.imageView?.contentMode = .scaleToFill
      $0.frame = CGRect(x: 10, y: 0, width: 10, height: 10)
    }
    let orderListButton = UIButton().then {
      $0.setImage(UIImage(systemName: "bag"), for: .normal)
      $0.imageView?.contentMode = .scaleToFill
      $0.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
    }
    navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: orderListButton), UIBarButtonItem(customView: searchBarButton)]
  }
  
  private func setupConstraints() {
    let guide = view.safeAreaLayoutGuide
    let spacing: CGFloat = 10
    self.sirenOrderTableView.then { self.view.addSubview($0) }
      .snp.makeConstraints {
        $0.top.leading.trailing.equalTo(guide)
        $0.bottom.equalTo(guide).offset(-spacing)
    }
  }
  
  private func setupTableView() {
    self.sirenOrderTableView.delegate = self
    self.sirenOrderTableView.dataSource = self
    self.sirenOrderTableView.register(TopBannerTableViewCell.self, forCellReuseIdentifier: TopBannerTableViewCell.identifier)
    self.sirenOrderTableView.register(SirenOrderMenuTableViewCell.self, forCellReuseIdentifier: SirenOrderMenuTableViewCell.identifier)
    self.sirenOrderTableView.register(SirenOrderMenuStoryTableViewCell.self, forCellReuseIdentifier: SirenOrderMenuStoryTableViewCell.identifier)
  }
}

// MARK: - UITableViewDataSource
extension SirenOrderMainViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    3
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    switch section {
    case 1:
      return 80
    default:
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 1:
      return 3
    default:
      return 1
    }
  }
  
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    switch section {
    case 1:
      let menuView = MenuSectionHeaderView()
      menuView.delegate = self
      return menuView
    default:
      return nil
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: TopBannerTableViewCell.identifier, for: indexPath) as? TopBannerTableViewCell else { return UITableViewCell() }
      return cell
      case 1:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: SirenOrderMenuTableViewCell.identifier, for: indexPath) as? SirenOrderMenuTableViewCell else { return UITableViewCell() }
      cell.selectionStyle = .none
      cell.backgroundColor = #colorLiteral(red: 0.9161977768, green: 0.9009630084, blue: 0.8896496296, alpha: 1)
      cell.delegate = self
      return cell
      case 2:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: SirenOrderMenuStoryTableViewCell.identifier, for: indexPath) as? SirenOrderMenuStoryTableViewCell else { return UITableViewCell() }
      return cell
    default:
      return UITableViewCell()
    }
  }
}

// MARK: - UITableViewDelegate
extension SirenOrderMainViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.section {
    case 0:
      return 155
    default:
      return 220
    }
  }
}

// MARK:- SirenOrderTableViewProtocol
extension SirenOrderMainViewController: SirenOrderTableViewProtocol {
  func showDetailPage() {
    let menuDetailVC = MenuDetailViewController()
    navigationController?.pushViewController(menuDetailVC, animated: true)
  }
}

// MARK:- MenuSectionHeaderProtocol
extension SirenOrderMainViewController: MenuSectionHeaderProtocol {
  func pushAllMenu() {
    let allMenuVC = AllMenuViewController()
    navigationController?.pushViewController(allMenuVC, animated: true)
  }
}
