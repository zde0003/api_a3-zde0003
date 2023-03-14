//
//  YuGiOhCardImagesModel.swift
//  Assignment3
//
//  Created by Zach Evetts on 3/16/23.
//

import Foundation

struct CardImagesModel : Codable, Identifiable {
    let id = UUID()
    let image_url : String
}
