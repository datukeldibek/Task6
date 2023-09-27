//
//  Extension + UIView.swift
//  Task6
//
//  Created by Jarae on 27/9/23.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { view in
            self.addSubview(view)
        }
    }
}
