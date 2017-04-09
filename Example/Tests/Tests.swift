import UIKit
import XCTest
import SuperSimpleMapper

class Tests: XCTestCase {
    
    private func loadData() -> Dictionary<String, Any> {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "dummyData", ofType: "json")!
        let contents = try! String(contentsOfFile: path)
        let data = contents.data(using: .utf8)!
        let json = try! JSONSerialization.jsonObject(with: data)
        return json as! Dictionary<String, Any>
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMapPost() {
        // This is an example of a functional test case.
        let mapper = Mapper()
        mapper.createMap { (post: Post) -> String in
            "title: \(post.title), comments count: \(post.comments.count)"
        }
        if let result = try? mapper.map(source: Post()) as String {
            XCTAssertTrue(true, "mapping succeded - \(result)")
        }else {
            XCTAssertFalse(true, "mapping failed")
        }
    }
    
    func testMapPostComments() {
        // This is an example of a functional test case.
        let mapper = Mapper()
        mapper.createMap { (jsonComment: Dictionary<String, Any>) -> Comment in
            let comment = Comment()
            comment.author = jsonComment["comment_author"] as! String
            comment.text = jsonComment["comment_text"] as! String
            return comment
        }
        
        mapper.createMap { (jsonPost: Dictionary<String, Any>) -> Post in
            let post = Post()
            post.title = jsonPost["post_title"] as! String
            post.like = jsonPost["like_count"] as! Int
            guard let comments = jsonPost["post_comments"] as? Array<Dictionary<String, Any>> else {
                return post
            }
            
            post.comments = comments.flatMap({ (commentDict) -> Comment? in
                try? mapper.map(source: commentDict)
            })
            
            return post
        }
        
        let jsonDict = loadData()
        
        if let result = try? mapper.map(source: jsonDict) as Post {
            XCTAssertTrue(true, "mapping succeded - \(result)")
        }else {
            XCTAssertFalse(true, "mapping failed")
        }
    }
    
    func testMapComplexCommentToComment() {
        let mapper = Mapper()
        mapper.createMap { (complexComment: ComplextComment) -> Comment in
            let comment = Comment()
            comment.author = complexComment.author
            comment.text = complexComment.text
            return comment
        }
        mapper.createMap { (post: Post) -> Comment in
            let comment = Comment()
            comment.author = "Test"
            comment.text = post.title
            return comment
        }
        
        if let result = try? mapper.map(source: ComplextComment()) as Comment {
            XCTAssertTrue(true, "mapping succeded - \(result)")
        }else {
            XCTAssertFalse(true, "mapping failed")
        }
    }
}
