//
//  NetworkLogger.swift
//  BugBlock
//
//  Created by Vadym Kozak on 16.08.2021.
//

import Foundation

class NetworkLogger: URLProtocol, URLSessionDataDelegate, URLSessionTaskDelegate {
    private var dataTask: URLSessionDataTask?
    private var urlResponse: URLResponse?
    private var receivedData: Data?
    
    // MARK: NSURLProtocol
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        let newRequest = self.request as! NSMutableURLRequest
        
        URLProtocol.setProperty("true", forKey: "NetworkLoggerKey", in: newRequest)
        
        let defaultConfigObj = URLSessionConfiguration.default
        let defaultSession = Foundation.URLSession(configuration: defaultConfigObj, delegate: self, delegateQueue: nil)
        
        self.dataTask = defaultSession.dataTask(with: self.request)
        self.dataTask!.resume()
        
    }
    
    override func stopLoading() {
        self.dataTask?.cancel()
        self.dataTask       = nil
        self.receivedData   = nil
        self.urlResponse    = nil
    }
    
    // MARK: NSURLSessionDataDelegate
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask,
                    didReceive response: URLResponse,
                    completionHandler: (URLSession.ResponseDisposition) -> Void) {
        
        self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        
        self.urlResponse = response
        self.receivedData = Data()
        
        completionHandler(.allow)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.client?.urlProtocol(self, didLoad: data)
        
        self.receivedData?.append(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil {
            self.client?.urlProtocol(self, didFailWithError: error!)
        } else {
            self.client?.urlProtocolDidFinishLoading(self)
        }
        store()
    }
    
    func store() {
        if let data = try? NetworkData(request: request, response: self.urlResponse, data: self.receivedData) {
            BBLog.logger?.log(data: data)
        }
    }
}

