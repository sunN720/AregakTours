//
//  TotalView.swift
//  AregakTours
//
//  Created by toxicsun on 5/19/18.
//  Copyright © 2018 Arevik Tunyan. All rights reserved.
//

import UIKit

class BookView: UIView {

	@IBOutlet weak var totalLabel: UILabel!

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		xibSetup()
	}

	func setup(with viewModel: BookViewModeling) {
		totalLabel.text = viewModel.outputs.totalAmount
	}
	
}
