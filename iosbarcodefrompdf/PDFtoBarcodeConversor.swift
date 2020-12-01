//
//  PDFtoBarcodeConversor.swift
//  iosbarcodefrompdf
//
//  Created by Rafael Aquila on 01/12/20.
//

import Foundation

class PDFToBarcodeConversor {
    
    
    func tryDecodeBarcodeFromPDF(pdfUrl url: URL, tryOnlyOnce: Bool = true) -> ZXResult?{
        
        var attemptList = Array<((URL) ->ZXResult?)>()
        attemptList.append(decodeUnmodifiedPdf)
        if !tryOnlyOnce{
            attemptList.append(decodeScaledPdf)
            attemptList.append(decodeScaledAndCroppedPdf)
        }
        
        for attempFunction in attemptList{
            if let result = attempFunction(url){
                if(result.text.isEmpty){
                    return nil
                }
                return result
            }
        }
        return nil

    }
    
    private func decodeUnmodifiedPdf(url: URL) ->ZXResult{
        let uiImage = url.pdfToUIImage()
        return  ZXingEntry.decodeBarcode(from: uiImage!)
    }
    
    private func decodeScaledPdf(url: URL) ->ZXResult{
        let uiImage = url.pdfToUIImage(scaleFactor: 100/72)
        return  ZXingEntry.decodeBarcode(from: uiImage!)
    }
    
    private func decodeScaledAndCroppedPdf(url: URL) ->ZXResult{
        let uiImage = url.pdfToUIImage(scaleFactor: 100/72)?.cropHalf()
        return  ZXingEntry.decodeBarcode(from: uiImage!)
    }
}
