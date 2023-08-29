//
//  NetworkModel.swift
//  GuideService
//
//  Created by Roman Vronsky on 29/08/23.
//

import Foundation

struct AnswerBrands: Codable {
    var brands: [Brands]?
}

class Brands: Codable {
    var brandId: String?
    var title: String?
    var thumbUrls: [String]?
    var tagIds: [String]?
    var slug: String?
    var type: String?
    var viewsCount: Int?
}
