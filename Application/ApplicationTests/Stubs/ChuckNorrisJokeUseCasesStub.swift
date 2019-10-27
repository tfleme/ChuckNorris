//
//  ChuckNorrisJokeUseCasesStub.swift
//  ApplicationTests
//
//  Created by Tiago Leme on 24/10/19.
//  Copyright © 2019 Tiago Leme. All rights reserved.
//

import UIKit

@testable import Domain

struct ChuckNorrisJokeUseCasesStub: ChuckNorrisJokeUseCasesType {

    enum ResultType {
        case success
        case failure
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - Public properties
    //-----------------------------------------------------------------------------
    
    var mockedJoke: Joke {
        
        let data = """
            {
                "icon_url": "https://mockurl.com",
                "value": "This is a mock chuck norris joke with a big text so you can have a big big laugh"
            }
        """.data(using: .utf8)!
        
        return DecodableHelper.decode(data)!
    }
    
    var mockedImageData: Data {
        
        let image = UIImage(named: "chucknorris_logo")!
        
        return image.pngData()!
    }
    //-----------------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------------
    
    private let resultType: ResultType

    
    //-----------------------------------------------------------------------------
    // MARK: - Initialization
    //-----------------------------------------------------------------------------
    
    init(resultType: ResultType) {
        self.resultType = resultType
    }
    
    //-----------------------------------------------------------------------------
    // MARK: - Public methods
    //-----------------------------------------------------------------------------
    
    func joke(from category: JokeCategory, completion: @escaping (Result<Joke, ViewModelError>) -> Void) {
        
        switch resultType {
        case .success:
            completion(.success(mockedJoke))
        case .failure:
            completion(.failure(ViewModelError(.generic)))
        }
        
    }
    
    func imageData(
        withURLString urlString: String,
        completion: @escaping (Result<Data, ViewModelError>) -> Void) {
        
        switch resultType {
        case .success:
            completion(.success(mockedImageData))
        case .failure:
            completion(.failure(ViewModelError(.generic)))
        }
    }
}

