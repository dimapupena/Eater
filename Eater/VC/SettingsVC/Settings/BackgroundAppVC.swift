//
//  BackgroundAppVC.swift
//  Eater
//
//  Created by Dmitriy Pupena on 18.05.2021.
//

import Foundation
import UIKit

class BackgroundAppVC: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Your new background"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textBackcolorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let settingsRedSlider: UISettingsSlider = {
        let customSlider = UISettingsSlider()
        customSlider.setStartValues(UIColor.backgroundColor.redPart)
        customSlider.translatesAutoresizingMaskIntoConstraints = false
        customSlider.customSlider.addTarget(self, action: #selector(redPartChanged), for: .valueChanged)
        return customSlider
    }()
    
    private let settingsGreenSlider: UISettingsSlider = {
        let customSlider = UISettingsSlider()
        customSlider.setStartValues(UIColor.backgroundColor.greenPart)
        customSlider.translatesAutoresizingMaskIntoConstraints = false
        customSlider.customSlider.addTarget(self, action: #selector(greenPartChanged), for: .valueChanged)
        return customSlider
    }()
    
    private let settingsBlueSlider: UISettingsSlider = {
        let customSlider = UISettingsSlider()
        customSlider.setStartValues(UIColor.backgroundColor.bluePart)
        customSlider.translatesAutoresizingMaskIntoConstraints = false
        customSlider.customSlider.addTarget(self, action: #selector(bluePartChanged), for: .valueChanged)
        return customSlider
    }()
    
    private let colorSettigsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let saveBackcolorButton: StandartActionButton = {
        let button = StandartActionButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setText("Update background color", font: .boldSystemFont(ofSize: 16))
        button.backgroundColor = UIColor(hexString: "#699CFC")
        button.addTarget(self, action: #selector(saveBackgroundColorClick), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(hexString: "#a89494")
        
        setupTitleLable()
        setupTestBackcolorView()
        setupStackView()
        setupSettingsSliders()
        setupSaveBackgroundColor()
    }
    
    private func setupTitleLable() {
        self.view.addSubview(titleLabel)
        
        titleLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 35).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    }
    
    private func setupTestBackcolorView() {
        self.view.addSubview(textBackcolorView)

        textBackcolorView.backgroundColor = UIColor.backgroundColor.color
        textBackcolorView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 35).isActive = true
        textBackcolorView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 35).isActive = true
        textBackcolorView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -35).isActive = true
        textBackcolorView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    private func setupStackView() {
        self.view.addSubview(colorSettigsStack)
        
        colorSettigsStack.addArrangedSubview(settingsRedSlider)
        colorSettigsStack.addArrangedSubview(settingsGreenSlider)
        colorSettigsStack.addArrangedSubview(settingsBlueSlider)
        
        colorSettigsStack.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 10).isActive = true
        colorSettigsStack.topAnchor.constraint(equalTo: textBackcolorView.bottomAnchor, constant: 10).isActive = true
        colorSettigsStack.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    }
    
    private func setupSettingsSliders() {
        settingsRedSlider.heightAnchor.constraint(equalToConstant: 50).isActive = true
        settingsGreenSlider.heightAnchor.constraint(equalToConstant: 50).isActive = true
        settingsBlueSlider.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupSaveBackgroundColor() {
        self.view.addSubview(saveBackcolorButton)
        
        saveBackcolorButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        saveBackcolorButton.topAnchor.constraint(equalTo: colorSettigsStack.bottomAnchor, constant: 30).isActive = true
        saveBackcolorButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        saveBackcolorButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
    }
    
    private func updateTextBackcolorView(red: Float = UIColor.backgroundColor.redPart, green: Float = UIColor.backgroundColor.greenPart, blue: Float = UIColor.backgroundColor.bluePart) {
        textBackcolorView.backgroundColor = UIColor(red: red, green: green, blue: blue)
    }
    
    @objc private func redPartChanged() {
        settingsRedSlider.customSlider.value = settingsRedSlider.customSlider.value
        updateTextBackcolorView(red: settingsRedSlider.customSlider.value)
        UIColor.backgroundColor.redPart = settingsRedSlider.customSlider.value
    }
    
    @objc private func greenPartChanged() {
        settingsGreenSlider.customSlider.value = settingsGreenSlider.customSlider.value
        updateTextBackcolorView(green: settingsGreenSlider.customSlider.value)
        UIColor.backgroundColor.greenPart = settingsGreenSlider.customSlider.value
    }
    
    @objc private func bluePartChanged() {
        settingsBlueSlider.customSlider.value = settingsBlueSlider.customSlider.value
        updateTextBackcolorView(blue: settingsBlueSlider.customSlider.value)
        UIColor.backgroundColor.bluePart = settingsBlueSlider.customSlider.value
    }
    
    @objc private func saveBackgroundColorClick() {
        UIColor.backgroundColor.color = textBackcolorView.backgroundColor!
    }
}

class UISettingsSlider: UIView {
    private let sliderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    internal let customSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 255
        slider.isContinuous = true
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setStartValues(_ value: Float) {
        sliderLabel.text = String(value)
        customSlider.value = value
    }
    
    private func setupViews() {
        setupSliderLabel()
        setupCustomSlider()
    }
    
    private func setupCustomSlider() {
        self.addSubview(customSlider)
        
        customSlider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        customSlider.topAnchor.constraint(equalTo: sliderLabel.bottomAnchor, constant: 5).isActive = true
        customSlider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        customSlider.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func setupSliderLabel() {
        self.addSubview(sliderLabel)
        
        sliderLabel.text = String(customSlider.value)
        
        sliderLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        sliderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        sliderLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
