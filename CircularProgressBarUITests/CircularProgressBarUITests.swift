

import XCTest
@testable import CircularProgressBar

class CircularProgressBarUITests: XCTestCase {
    //var sut: ProgressViewModel!
    //var mockAPIService: MockApiService!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // mockAPIService = MockApiService()
        //sut = ProgressViewModel(networkService: mockAPIService)
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_spinner_Exist() {
        
    }
    
    func test_existence_of_UI_elements() {
        
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()        
        let refreshBtn = app.navigationBars["CircularProgressBar.CircularProgressBarView"].buttons["refreshAccLbl"]
        refreshBtn.tap()
        XCTAssertTrue(refreshBtn.exists)
        
        
        let montlyTextLbl = app.staticTexts["monthlyAccLbl"]
        XCTAssertTrue(montlyTextLbl.exists)
        
        let milesDigitLbl  = app.staticTexts["milesDigitAccLbl"]
        XCTAssertEqual(app.staticTexts.element(matching:.any, identifier: "milesDigitAccLbl").label, "747.0")
        
        XCTAssertTrue(milesDigitLbl.exists)
        
        let milesLeftTextLbl = app.staticTexts["milesLeftAccLbl"]
        XCTAssertTrue(milesLeftTextLbl.exists)
        
        let batteryTxtLbl = app.staticTexts["batteryAccLbl"]
        XCTAssertTrue(batteryTxtLbl.exists)
        
        let chargeDigitLbl = app.staticTexts["chargeDigitAccLbl"]
        XCTAssertTrue(chargeDigitLbl.exists)
        
        let chargeTxtLbl = app.staticTexts["chargeAccLbl"]
        XCTAssertTrue(chargeTxtLbl.exists)        
    }
    
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}

