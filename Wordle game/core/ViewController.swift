//
//  ViewController.swift
//  Wordle game
//
//  Created by robusta on 26/04/2024.
//

import UIKit

class ViewController: UIViewController {
    
    var answer = "after"
    
    private var guesses: [[Character?]] = Array(repeating: Array(repeating: nil, count: 5), count: 6)

    let keyboardViewController = KeyboardViewController()
    let boardViewController = BoardViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .black
        addChildren()
    }
    
    func addChildren(){
        
        addChild(keyboardViewController)
        keyboardViewController.didMove(toParent: self)
        keyboardViewController.delegate = self
        keyboardViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardViewController.view)
        
        addChild(boardViewController)
        boardViewController.didMove(toParent: self)
        boardViewController.dataSource = self
        boardViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(boardViewController.view)
        
        addConstrains()
    }
    
    func addConstrains(){
        
        NSLayoutConstraint.activate([
            
            boardViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boardViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            boardViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            boardViewController.view.bottomAnchor.constraint(equalTo: keyboardViewController.view.topAnchor),
            boardViewController.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            
            keyboardViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            keyboardViewController.view.topAnchor.constraint(equalTo: boardViewController.view.bottomAnchor)
        ])
    }
}

extension ViewController: BoardViewControllerDatasource {
    var currentGuesses: [[Character?]] {
        return guesses
    }
    
    func boxColor(at index: IndexPath) -> UIColor? {
        let rowIndex = index.section
        
        let count = guesses[rowIndex].compactMap({$0}).count
        guard count == 5 else {
            return nil
        }
        
        let indexedAnswer = Array(answer)
        guard let letter = guesses[index.section][index.row],indexedAnswer.contains(letter) else {
            return nil
        }
        
        if indexedAnswer[index.row] == letter {
            return .green
        }
        
        return .orange
    }
}

extension ViewController: KeyboardViewControllerDelegate {
    func keyBoardViewController(_ vc: KeyboardViewController, keyYapped letter: Character) {
        var stop = false
        for i in 0..<guesses.count {
            for j in 0..<guesses[i].count {
                if guesses[i][j] == nil {
                    guesses[i][j] = letter
                    stop = true
                    break
                }
            }
            if stop {
                break
            }
        }
        boardViewController.reload()
    }
}

