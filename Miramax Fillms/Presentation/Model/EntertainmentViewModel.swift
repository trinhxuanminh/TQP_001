//
//  EntertainmentViewModel.swift
//  Miramax Fillms
//
//  Created by Thanh Quang on 10/10/2022.
//

import Foundation
import Domain

struct EntertainmentViewModel {
  let id: Int
  let type: EntertainmentType
  let name: String
  let overview: String
  let rating: Double
  let releaseDate: String
  let runtime: Int?
  let backdropURL: URL?
  let posterURL: URL?
  let genres: [Genre]?
  let directors: [PersonViewModel]?
  let writers: [PersonViewModel]?
  let casts: [PersonViewModel]?
  let seasons: [Season]?
  let backdropImages: [Image]?
  let videos: [Video]?
  let recommendations: [EntertainmentViewModel]?
  let isBookmark: Bool
  let imdbID: String?
}

extension Movie: PresentationConvertibleType {
  func asPresentation() -> EntertainmentViewModel {
    return EntertainmentViewModel(
      id: id,
      type: .movie,
      name: title,
      overview: overview,
      rating: voteAverage,
      releaseDate: releaseDate,
      runtime: runtime,
      backdropURL: backdropURL,
      posterURL: posterURL,
      genres: genres,
      directors: directors?.map { $0.asPresentation() },
      writers: writers?.map { $0.asPresentation() },
      casts: casts?.map { $0.asPresentation() },
      seasons: nil,
      backdropImages: backdropImages,
      videos: videos,
      recommendations: recommendations?.results.map { $0.asPresentation() },
      isBookmark: isBookmark,
      imdbID: imdbId
    )
  }
}

extension TVShow: PresentationConvertibleType {
  func asPresentation() -> EntertainmentViewModel {
    return EntertainmentViewModel(
      id: id,
      type: .tvShow,
      name: name,
      overview: overview,
      rating: voteAverage,
      releaseDate: firstAirDate,
      runtime: numberOfEpisodes,
      backdropURL: backdropURL,
      posterURL: posterURL,
      genres: genres,
      directors: directors?.map { $0.asPresentation() },
      writers: writers?.map { $0.asPresentation() },
      casts: casts?.map { $0.asPresentation() },
      seasons: seasons,
      backdropImages: backdropImages,
      videos: videos,
      recommendations: recommendations?.results.map { $0.asPresentation() },
      isBookmark: isBookmark,
      imdbID: nil
    )
  }
}

extension BookmarkEntertainment: PresentationConvertibleType {
  func asPresentation() -> EntertainmentViewModel {
    return EntertainmentViewModel(
      id: id,
      type: type,
      name: name,
      overview: overview,
      rating: rating,
      releaseDate: releaseDate,
      runtime: nil,
      backdropURL: nil,
      posterURL: posterURL,
      genres: nil,
      directors: nil,
      writers: nil,
      casts: nil,
      seasons: nil,
      backdropImages: nil,
      videos: nil,
      recommendations: nil,
      isBookmark: true,
      imdbID: nil
    )
  }
}

extension RecentEntertainment {
  func asPresentation() -> EntertainmentViewModel {
    return EntertainmentViewModel(
      id: id,
      type: type,
      name: name,
      overview: "",
      rating: 0.0,
      releaseDate: "",
      runtime: nil,
      backdropURL: nil,
      posterURL: posterURL,
      genres: nil,
      directors: nil,
      writers: nil,
      casts: nil,
      seasons: nil,
      backdropImages: nil,
      videos: nil,
      recommendations: nil,
      isBookmark: false,
      imdbID: nil
    )
  }
}
