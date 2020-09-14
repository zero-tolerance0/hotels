//
//  ApiError.swift
//  hotelsapp
//
//  Created by zerohero on 6/25/20.
//  Copyright © 2020 indev. All rights reserved.
//

import Foundation

public enum ApiError: Error {

  case unknown
  case notConnectedToInternet
  case internationalRoamingOff
  case notReachedServer
  case connectionLost
  case incorrectDataReturned
  case paymentFailed

  init(error: NSError) {
    if error.domain == NSURLErrorDomain {
      switch error.code {
      case NSURLErrorUnknown,
           NSURLErrorCancelled,
           NSURLErrorHTTPTooManyRedirects,
           NSURLErrorUserCancelledAuthentication,
           NSURLErrorUserAuthenticationRequired,
           NSURLErrorCallIsActive,
           NSURLErrorDataNotAllowed,
           NSURLErrorRequestBodyStreamExhausted,
           NSURLErrorNoPermissionsToReadFile,
           NSURLErrorSecureConnectionFailed,
           NSURLErrorServerCertificateHasBadDate,
           NSURLErrorServerCertificateUntrusted,
           NSURLErrorServerCertificateHasUnknownRoot,
           NSURLErrorServerCertificateNotYetValid,
           NSURLErrorClientCertificateRejected,
           NSURLErrorClientCertificateRequired,
           NSURLErrorCannotLoadFromNetwork,
           NSURLErrorCannotCreateFile,
           NSURLErrorCannotOpenFile,
           NSURLErrorCannotCloseFile,
           NSURLErrorCannotWriteToFile,
           NSURLErrorCannotRemoveFile,
           NSURLErrorCannotMoveFile,
           NSURLErrorDownloadDecodingFailedMidStream,
           NSURLErrorDownloadDecodingFailedToComplete:
        self = .unknown

      case NSURLErrorBadURL,
           NSURLErrorUnsupportedURL,
           NSURLErrorDataLengthExceedsMaximum,
           NSURLErrorResourceUnavailable,
           NSURLErrorRedirectToNonExistentLocation,
           NSURLErrorBadServerResponse,
           NSURLErrorZeroByteResource,
           NSURLErrorCannotDecodeRawData,
           NSURLErrorCannotDecodeContentData,
           NSURLErrorCannotParseResponse,
           NSURLErrorFileDoesNotExist,
           NSURLErrorFileIsDirectory:
        self = .incorrectDataReturned

      case NSURLErrorTimedOut,
           NSURLErrorCannotFindHost,
           NSURLErrorCannotConnectToHost,
           NSURLErrorDNSLookupFailed:
        self = .notReachedServer
      case NSURLErrorNetworkConnectionLost:
        self = .connectionLost
      case NSURLErrorNotConnectedToInternet:
        self = .notConnectedToInternet
      case NSURLErrorInternationalRoamingOff:
        self = .internationalRoamingOff
      default:
        self = .unknown
      }
    } else {
      self = .unknown
    }
  }

  init (error: Error) {
    self.init(error: error as NSError)
  }

  public var message: String {
    switch self {
    case .connectionLost: return NSLocalizedString("Потеряно соединение с сервисом.", comment: "")
    case .incorrectDataReturned: return NSLocalizedString("Получен неожиданный ответ от сервиса.", comment: "")
    case .notConnectedToInternet: return NSLocalizedString("Отсутствует интернет-соединение.", comment: "")
    case .notReachedServer: return NSLocalizedString("Сервис временно недоступен.", comment: "")
    case .paymentFailed: return NSLocalizedString("Заказ не оплачен. Повторите попытку.", comment: "")
    default: return NSLocalizedString("Не удалось обработать ошибку.", comment: "")
    }
  }
}
