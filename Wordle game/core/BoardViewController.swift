//
//  BoardViewController.swift
//  Wordle game
//
//  Created by robusta on 26/04/2024.
//

import UIKit

protocol BoardViewControllerDatasource {
    var currentGuesses: [[Character?]] {get}
    func boxColor(at index: IndexPath) -> UIColor?
}

class BoardViewController: UIViewController, UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    var dataSource: BoardViewControllerDatasource?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 4
        let collectionView = UICollectionView(frame: .zero , collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(KeyCell.self, forCellWithReuseIdentifier: KeyCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 35),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -35),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor , constant: 30),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    public func reload() {
        collectionView.reloadData()
    }
}

extension BoardViewController {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        dataSource?.currentGuesses.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dataSource?.currentGuesses[section].count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyCell.identifier, for: indexPath) as? KeyCell
        cell?.contentView.backgroundColor = dataSource?.boxColor(at: indexPath)
        cell?.layer.borderWidth = 1
        cell?.layer.borderColor = UIColor.white.cgColor
        let guesses = dataSource?.currentGuesses ?? []
        if let letter = guesses[indexPath.section][indexPath.row] {
            cell?.configure(with: letter)
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let margin: CGFloat = 20
        let size: CGFloat = (collectionView.frame.size.width-margin) / 5
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(
           top: 2, left: 2, bottom: 2, right: 2
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
}
