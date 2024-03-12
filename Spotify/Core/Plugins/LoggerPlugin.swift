//
//  LoggerPlugin.swift
//  Spotify
//
//  Created by rauan on 2/28/24.
//

import Foundation
import Moya

final class LoggerPlugin: PluginType {
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            guard let request = response.request else { return }
            let logSuccessMessage = "\n✅ Request send successfully \n🚀 Request: \(request) \n"
            print(logSuccessMessage)
        case .failure(let error):
            let logFailureMessage = "\n⛔️ Error: \(error.localizedDescription) \n"
            print(logFailureMessage)
        }
    }
}
