//
//  String+Ex.swift
//  EventHub
//
//  Created by Даниил Сивожелезов on 22.11.2024.
//

import Foundation

extension String {
    var htmlToString: String {
        guard let data = data(using: .utf8) else { return self }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        if let attributed = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            return attributed.string
        }
        return self
    }
}
