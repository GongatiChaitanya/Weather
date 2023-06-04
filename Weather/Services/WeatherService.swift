//
//  WeatherService.swift
//  Weather
//
//  Created by chaitanya gongati on 5/4/23.
//

import Foundation
import Alamofire

struct WeatherService {
        
        //MARK: - AF GET Method
        
        static func getAFMethod<T:Decodable>(_ requestModel: WeatherRequestData,
                                             _ modelType: T.Type,
                                             completion: @escaping (Result<T, ResponseError>)->Void) -> Void {
            
            AF.request(requestModel.requestUrl)
                .responseDecodable(of: modelType.self) { response in
                    switch response.result {
                    case let .success(value): // Do something.
                        completion(.success(value))
                    case .failure(_):
                        if response.response?.statusCode == 401 {
                            completion(.failure(.unAuthorisedError))
                        }else {
                            completion(.failure(.noDataError))
                        }
                        
                    }
                }
        }
    
}
    

