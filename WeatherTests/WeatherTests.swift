//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by chaitanya gongati on 5/4/23.
//

import XCTest
@testable import Weather

final class WeatherTests: XCTestCase {

    private let service = WeatherViewModel()

    func testParseNonJsonString() {
        let data = "Just a plain error".data(using: String.Encoding.utf8)!
        guard case .Error = service.weather(forCity: "Dallas", fromJsonData: data) else {
            XCTFail("Couldn't recognize malformed JSON response")
            return
        }
    }
    
    func testParseJsonWithoutExpectedValues() {
        let data = "{ \"foo\": 42.0, \"main\": \"hello\" }".data(using: String.Encoding.utf8)!
        guard case .Error = service.weather(forCity: "Dallas", fromJsonData: data) else {
            XCTFail("Couldn't recognize malformed JSON response")
            return
        }
    }
    
    func testParseValidJson() {
        let data = "{\"weather\":[{\"description\":\"mist\"}],\"main\":{\"temp\":268.83,\"humidity\":92}}".data(using: String.Encoding.utf8)!
        guard case let .Success(conditions) = service.weather(forCity: "Dallas", fromJsonData: data) else {
            XCTFail("Valid JSON was not parsed successfully")
            return
        }
        XCTAssertEqual(92, conditions.humidityPercent)
        XCTAssertEqual(268.83-273.15, conditions.temperatureCelsius, accuracy: 0.01)
        XCTAssertEqual("mist", conditions.generalDescription)
        XCTAssertEqual("Dallas", conditions.city)
    }
    
    

}

    
    
    
    

