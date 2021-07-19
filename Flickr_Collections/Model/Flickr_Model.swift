//
//  Flickr_Model.swift
//  Flickr_Collections
//
//  Created by Sivakumar on 19/07/21.
//

import Foundation

// MARK: - Welcome
class Models: Codable {
    let photos: Photos
    let stat: String

    init(photos: Photos, stat: String) {
        self.photos = photos
        self.stat = stat
    }
}

// MARK: - Photos
class Photos: Codable {
    let page, pages, perpage, total: Int
    let photo: [Photo]

    init(page: Int, pages: Int, perpage: Int, total: Int, photo: [Photo]) {
        self.page = page
        self.pages = pages
        self.perpage = perpage
        self.total = total
        self.photo = photo
    }
}

// MARK: - Photo
class Photo: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily, isPrimary: Int
    let hasComment: Int

    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, farm, title, ispublic, isfriend, isfamily
        case isPrimary = "is_primary"
        case hasComment = "has_comment"
    }

    init(id: String, owner: String, secret: String, server: String, farm: Int, title: String, ispublic: Int, isfriend: Int, isfamily: Int, isPrimary: Int, hasComment: Int) {
        self.id = id
        self.owner = owner
        self.secret = secret
        self.server = server
        self.farm = farm
        self.title = title
        self.ispublic = ispublic
        self.isfriend = isfriend
        self.isfamily = isfamily
        self.isPrimary = isPrimary
        self.hasComment = hasComment
    }
}
