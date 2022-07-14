//
//  FilterSliderStackView.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 14.07.2022.
//

import UIKit

protocol SliderDelegate: AnyObject{
    func didSliderValueChanged(_ value: Float)
}

class FilterSliderStackView: UIStackView {

    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .init(name: ApplicationFonts.bold.rawValue, size: 20)
        return label
    }()
    
    fileprivate lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 15
        slider.setValue(slider.maximumValue, animated: false)
        slider.isContinuous = true
        slider.tintColor = UIColor.primary
        slider.addTarget(self, action: #selector(sliderEvent), for: .valueChanged)
        return slider
    }()
    
    fileprivate lazy var horizontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    weak var delegate: SliderDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.spacing = 15
        self.addArrangedSubview(titleLabel)
        self.addArrangedSubview(slider)
        generateStepLabels()
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateSlider(_ value: Double){
        DispatchQueue.main.async { [unowned self] in
            self.slider.setValue(Float(value), animated: true)
        }
    }
    
    private func generateStepLabels(){
        self.addArrangedSubview(horizontalStack)
        for number in Int(slider.minimumValue)...Int(slider.maximumValue){
            if number % 3 == 0{
                let label = UILabel()
                label.textColor = .white
                label.font = .init(name: ApplicationFonts.regular.rawValue, size: 14)
                label.text = number == Int(slider.maximumValue) ? "\(number)+" : "\(number)"
                horizontalStack.addArrangedSubview(label)
            }
        }
        horizontalStack.spacing = (self.bounds.width / ( CGFloat(slider.maximumValue) / 3))
    }
    
    @objc func sliderEvent(){
        delegate?.didSliderValueChanged(slider.value)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
