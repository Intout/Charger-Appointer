//
//  AppointmentDateSelectionSlotButton.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 16.07.2022.
//

import UIKit

enum AppointmentDateSelectionSlotButtonState{
    case selected
    case disabled
    case idle
}

protocol AppointmentDateSelectionSlotButtonDelegate: AnyObject{
    func didSlotSelected(slotTitle: String, index: Int)
}

class AppointmentDateSelectionSlotButton: UIButton {

    weak var delegate: AppointmentDateSelectionSlotButtonDelegate?
    private var slotTitle: String!
    private var index: Int!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        var configuration = UIButton.Configuration.borderless()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30)
        
        self.configuration = configuration
        self.titleLabel?.font = UIFont(name: ApplicationFonts.regular.rawValue, size: 18)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateState(as state: ButtonState){
        switch state {
        case .selected:
            self.backgroundColor = .dark
            self.layer.borderColor = UIColor.primary.cgColor
            self.tintColor = .white
        case .disabled:
            self.layer.borderColor = UIColor.clear.cgColor
            self.backgroundColor = .charcoalGrey
            self.tintColor = UIColor.lightGrey
        case .idle:
            self.backgroundColor = .charcoalGrey
            self.layer.borderColor = UIColor.clear.cgColor
            self.tintColor = .white
        }
    }
    
    @objc private func buttonPressed(){
        delegate?.didSlotSelected(slotTitle: getSlotTitle(), index: getIndex())
    }

    func setSlotTitle(_ title: String){
        slotTitle = title
        self.setTitle(title, for: .normal)
    }
    
    func getSlotTitle() -> String{
        slotTitle
    }
    
    func setIndex(_ index: Int){
        self.index = index
    }
    
    func getIndex() -> Int{
        self.index
    }
    

}
