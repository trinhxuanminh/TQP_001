//
//  EntertainmentsResponseRoute.swift
//  Miramax Fillms
//
//  Created by Thanh Quang on 04/10/2022.
//

import Domain

enum EntertainmentsResponseRoute {
    case discover(genre: Genre)
    case recommendations(entertainmentId: Int, entertainmentType: EntertainmentType)
    case movieUpcoming
    case movieTopRating
    case movieNews
    case movieTrending
    case showUpcoming
    case showTopRating
    case showNews
    case showTrending
    case search(query: String, entertainmentType: EntertainmentType)
}
