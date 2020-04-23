//
//  InfosysAssignmentTests.swift
//  InfosysAssignmentTests
//
//  Created by Balaji S on 21/04/20.
//  Copyright © 2020 balaji. All rights reserved.
//

import XCTest
@testable import InfosysAssignment

class InfosysAssignmentTests: XCTestCase {

    var interactor: POCInteractor?

    override func setUp() {
        interactor = POCInteractor()
        super.setUp()
    }

    override func tearDown() {
        interactor = nil
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func getMockJson() -> Data {
        let jsonString = """
        {
        "title":"About Canada",
        "rows":[
            {
            "title":"Beavers",
            "description":"Beavers are second only to humans in their ability to manipulate and change their environment.",
            "imageHref":"http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
            },
            {
            "title":"Flag",
            "description":null,
            "imageHref":"http://images.findicons.com/files/icons/662/world_flag/128/flag_of_canada.png"
            },
            {
            "title":"Transportation",
            "description":"It is a well known fact that polar bears are the main mode of transportation in Canada. They consume far less gas and have the added benefit of being difficult to steal.",
            "imageHref":"http://1.bp.blogspot.com/_VZVOmYVm68Q/SMkzZzkGXKI/AAAAAAAAADQ/U89miaCkcyo/s400/the_golden_compass_still.jpg"
            },
            {
            "title":"Hockey Night in Canada",
            "description":"These Saturday night CBC broadcasts originally aired on radio in 1931. In 1952 they debuted on television and continue to unite (and divide) the nation each week.",
            "imageHref":"http://fyimusic.ca/wp-content/uploads/2008/06/hockey-night-in-canada.thumbnail.jpg"
            },
            {
            "title":"Eh",
            "description":"A chiefly Canadian interrogative utterance, usually expressing surprise or doubt or seeking confirmation.",
            "imageHref":null
            },
            {
            "title":"Housing",
            "description":"Warmer than you might think.",
            "imageHref":"http://icons.iconarchive.com/icons/iconshock/alaska/256/Igloo-icon.png"
            },
            {
            "title":"Public Shame",
            "description":" Sadly it's true.",
            "imageHref":"http://static.guim.co.uk/sys-images/Music/Pix/site_furniture/2007/04/19/avril_lavigne.jpg"
            },
            {
            "title":null,
            "description":null,
            "imageHref":null
            },
            {
            "title":"Space Program",
            "description":"Canada hopes to soon launch a man to the moon.",
            "imageHref":"http://files.turbosquid.com/Preview/Content_2009_07_14__10_25_15/trebucheta.jpgdf3f3bf4-935d-40ff-84b2-6ce718a327a9Larger.jpg"
            },
            {
            "title":"Meese",
            "description":"A moose is a common sight in Canada.",
            "imageHref":"http://caroldeckerwildlifeartstudio.net/wp-content/uploads/2011/04/IMG_2418%20majestic%20moose%201%20copy%20(Small)-96x96.jpg"
            },
            {
            "title":"Geography",
            "description":"It's really big.",
            "imageHref":null
            },
            {
            "title":"Kittens...",
            "description":"Éare illegal. Cats are fine.",
            "imageHref":"http://www.donegalhimalayans.com/images/That%20fish%20was%20this%20big.jpg"
            },
            {
            "title":"Mounties",
            "description":"They are the law. They are also Canada's foreign espionage service. Subtle.",
            "imageHref":"http://3.bp.blogspot.com/__mokxbTmuJM/RnWuJ6cE9cI/AAAAAAAAATw/6z3m3w9JDiU/s400/019843_31.jpg"
            },
            {
            "title":"Language",
            "description":"Nous parlons tous les langues importants.",
            "imageHref":null
            }
        ]
        }
        """

        let jsonData = jsonString.data(using: .utf8)!

        return jsonData
    }

    func testMockData() {
        guard let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") else { return }
        let expectation = XCTestExpectation(description: "infosys assignment data")
        URLProtocolMock.testURLs = [url: getMockJson()]
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)

        let resource = Resource<POCModel>(url: url)

        POCDataManager.fetchDataFromServer(using: session, resource: resource) { (result) in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "Data was downloaded.")
                expectation.fulfill()
            case .failure(let error):
                XCTAssertNil(error, "No data was downloaded.")
            }
        }
    }

    func testActualData() {
        let expectation = XCTestExpectation(description: "infosys assignment data")
        let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
        let resource = Resource<POCModel>(url: url)
         POCDataManager.fetchDataFromServer(resource: resource) { (result) in
             switch result {
             case .success(let data):
                XCTAssertNotNil(data, "Data was downloaded.")
                expectation.fulfill()
             case .failure(let error):
                XCTAssertNil(error, "No data was downloaded.")
             }
         }

        wait(for: [expectation], timeout: 10.0)
    }

}

class URLProtocolMock: URLProtocol {
    static var testURLs = [URL?: Data]()

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let url = request.url {
            if let data = URLProtocolMock.testURLs[url] {
                self.client?.urlProtocol(self, didLoad: data)
            }
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {
    }

}
