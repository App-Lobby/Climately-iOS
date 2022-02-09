//
//  PopUp.swift
//  Climately
//
//  Created by Mohammad Yasir on 09/02/22.
//

import SwiftUI

public struct PopUp {
    public var showPopUp: Bool
    public var popUpType: PopUpType
    
    init(
        showPopUp: Bool = false,
        popUpType: PopUpType = .nothing
    ) {
        self.showPopUp = showPopUp
        self.popUpType = popUpType
    }
}
