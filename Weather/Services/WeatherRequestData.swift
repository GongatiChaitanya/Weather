//
//  WeatherRequestData.swift
//  Weather
//
//  Created by chaitanya gongati on 6/2/23.
//

import Foundation

struct WeatherRequestData  {
    var requestUrl : String
    let serviceType : HttpMethod = .GET
    var querryItems : [URLQueryItem]? = nil
    var httpBody    : [String:Any]?   = nil
    let param : [String:Any]? = nil
    var httpHeaderField : [String:String]? = nil
}

//MARK: -  Http Method
public enum HttpMethod: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}

//MARK: - Request Error
public enum ResponseError: Error {
    case domainError
    case unAuthorisedError
    case decodingError
    case noDataError
    case internetError
    case authorisationToken
    case noEnvironment
}
