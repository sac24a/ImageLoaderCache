//
//  ImageModel.swift
//  ImageLoaderCache
//
//  Created by Sachin Kanojia on 11/05/24.
//

import Foundation

typealias ImageModel = [ApiModel]

struct ApiModel: Codable {
    let id, title, language: String
    let thumbnail: Thumbnail
    let mediaType: Int
    let coverageURL: String
    let publishedAt, publishedBy: String
    let backupDetails: BackupDetails?
}

// MARK: - BackupDetails
struct BackupDetails: Codable {
    let pdfLink: String
    let screenshotURL: String
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let id: String
    let version: Int
    let domain: String
    let basePath, key: String
    let qualities: [Int]
    let aspectRatio: Double
}

struct ApiError: Codable {
    let success: Bool
    let message: String
    var data: String?
}
