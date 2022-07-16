//
//  AppointerDateSelectionSocketHourStackView.swift
//  Charger Appointer
//
//  Created by Mert Tecimen on 16.07.2022.
//

import UIKit

protocol AppointerDateSelectionSocketHourStackViewDelegate: AnyObject{
    func didCellSelected(id: String, slot: String)
}

enum ButtonState{
    case idle
    case disabled
    case selected
}

class AppointerDateSelectionSocketHourStackView: UIStackView {

    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .init(name: ApplicationFonts.bold.rawValue, size: 18)
        label.textColor = .white
        return label
    }()
    
    private(set) lazy var chargerInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .init(name: ApplicationFonts.regular.rawValue, size: 14)
        label.textColor = .lightGrey
        return label
    }()

    private var socketID: String!
    weak var delegate: AppointerDateSelectionSocketHourStackViewDelegate?
    private var data: [TimeSlot] = []
    private var selectedCell: SelectedSocket?
    private var buttons: [AppointmentDateSelectionSlotButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.spacing = 10
        self.distribution = .equalSpacing
        self.alignment = .center
        self.addArrangedSubview(titleLabel)
        self.addArrangedSubview(chargerInfoLabel)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func setData(_ data: [TimeSlot]){
        self.data = data
        DispatchQueue.main.async { [unowned self] in
            generateHourSlots()
        }
    }
    
    func setSelectedCellData(_ data: SelectedSocket?){
        self.selectedCell = data
        DispatchQueue.main.async { [unowned self] in
            generateHourSlots()
        }
    }
    
    func setID(id: String){
        socketID = id
    }
}

private extension AppointerDateSelectionSocketHourStackView{
    func generateHourSlots(){
        
        if !buttons.isEmpty{
            for button in buttons{
                button.removeFromSuperview()
            }
            buttons = []
        }
        
        for (index, slot) in data.enumerated(){
            let button = AppointmentDateSelectionSlotButton()
            button.setSlotTitle(slot.slot)
            button.delegate = self
            button.setIndex(index)
            if slot.isOccupied{
                print("Slot Disabled")
                button.updateState(as: .disabled)
            } else {
                if let selectedCell = selectedCell{
                    if selectedCell.id == socketID && selectedCell.slot == button.getSlotTitle(){
                        button.updateState(as: .selected)
                    } else {
                        button.updateState(as: .idle)
                    }
                } else {
                    button.updateState(as: .idle)
                }
            }
            buttons.append(button)
            self.addArrangedSubview(button)
        }
    }
}

extension AppointerDateSelectionSocketHourStackView: AppointmentDateSelectionSlotButtonDelegate{
    func didSlotSelected(slotTitle: String, index: Int) {
        if !data[index].isOccupied{
            delegate?.didCellSelected(id: socketID, slot: slotTitle)
        }
    }
}
