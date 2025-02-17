//
//  FizzBuzzViewController.swift
//  FizzBuzzXCTest
//
//  Created by ditthales on 04/02/25.
//

import UIKit

class FizzBuzzViewController: UIViewController {
    
    private var livesLabel: UILabel!
    private var numberButton: UIButton!
    private var buttonStack: UIStackView!
    
    private var viewModel: FizzBuzzViewModel
    
    init(viewModel: FizzBuzzViewModel = FizzBuzzViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: viewModel.colorBackground)
        
        clearUI()
        
        switch viewModel.state {
        case .playing:
            setupGameUI()
        case .gameOver:
            setupGameOverUI()
        }
    }
    
    private func setupGameUI() {
        livesLabel = UILabel()
        livesLabel.text = "Lives: \(viewModel.remainingLives)"
        livesLabel.textColor = .white
        livesLabel.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        livesLabel.textAlignment = .center
        livesLabel.translatesAutoresizingMaskIntoConstraints = false
        livesLabel.accessibilityIdentifier = "livesLabel"
        view.addSubview(livesLabel)
        
        numberButton = createButton(.number)
        let champagneButton = createButton(.champagne)
        let lightningButton = createButton(.lightning)
        let spaceButton = createButton(.space)
        
        let firstRowStack = UIStackView(arrangedSubviews: [numberButton, champagneButton])
        firstRowStack.axis = .horizontal
        firstRowStack.spacing = 25
        
        let secondRowStack = UIStackView(arrangedSubviews: [lightningButton, spaceButton])
        secondRowStack.axis = .horizontal
        secondRowStack.spacing = 25
        
        buttonStack = UIStackView(arrangedSubviews: [firstRowStack, secondRowStack])
        buttonStack.axis = .vertical
        buttonStack.spacing = 25
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = UIColor(named: viewModel.colorBackground)
        
        view.addSubview(buttonStack)
        
        NSLayoutConstraint.activate([
            livesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            livesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func updateGameUI() {
        view.backgroundColor = UIColor(named: viewModel.colorBackground)
        livesLabel.text = "Lives: \(viewModel.remainingLives)"
        numberButton.setTitle("\(viewModel.gameScore)", for: .normal)
    }
    
    private func updateView() {
        switch viewModel.state {
        case .playing:
            if (buttonStack.superview == nil) {
                clearUI()
                setupGameUI()
                return
            }
            updateGameUI()
        case .gameOver:
            clearUI()
            setupGameOverUI()
        }
    }
    
    private func clearUI() {
        // Remove todos os subviews da view principal
        view.subviews.forEach { $0.removeFromSuperview() }
    }
    
    private func setupGameOverUI() {
        let gameOverLabel = UILabel()
        gameOverLabel.text = "GAME OVER"
        gameOverLabel.textColor = .white
        gameOverLabel.font = UIFont.boldSystemFont(ofSize: 24)
        gameOverLabel.textAlignment = .center
        gameOverLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let scoreLabel = UILabel()
        scoreLabel.text = "Your Score: \(viewModel.gameScore)"
        scoreLabel.textColor = .white
        scoreLabel.textAlignment = .center
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let playAgainButton = createButton(.playAgain)
        
        let stackView = UIStackView(arrangedSubviews: [gameOverLabel, scoreLabel, playAgainButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = UIColor(named: viewModel.colorBackground)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func createButton(_ type: GameButtonType) -> UIButton {
        let button = UIButton(type: .system)
        var imageName = ""
        switch type {
        case .number:
            button.setTitle("\(viewModel.gameScore)", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .semibold)
        case .champagne:
            imageName = "divide3"
        case .lightning:
            imageName = "divide5"
        case .space:
            imageName = "divide15"
        case .playAgain:
            button.setTitle("PLAY AGAIN", for: .normal)
        }
        
        if let image = UIImage(named: imageName) {
            button.setImage(image, for: .normal)
            
            // Ajusta a posição da imagem em relação ao texto
            var config = UIButton.Configuration.plain()
            config.imagePlacement = .top
            button.configuration = config
        }
        
        button.tintColor = .white
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
        button.tag = type.rawValue
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }
    
    @objc private func buttonPressed(_ sender: UIButton) {
        // Identifica o tipo de botão com base na tag
        guard let buttonType = GameButtonType(rawValue: sender.tag) else { return }
        
        switch buttonType {
        case .number:
            viewModel.numberPressed()
        case .champagne:
            viewModel.champagnePressed()
        case .lightning:
            viewModel.lightningPressed()
        case .space:
            viewModel.spacePressed()
        case .playAgain:
            viewModel.playAgainPressed()
        }
        
        // Atualiza a UI após a ação
        updateView()
    }
}
