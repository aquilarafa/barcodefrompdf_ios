//
//  ViewController.swift
//  iosbarcodefrompdf
//
//  Created by Rafael Aquila on 30/11/20.
//

import UIKit
import FileBrowser


class ViewController: UIViewController {

    @IBOutlet weak var boletoImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!

    @IBAction func onPressedSelectPDFButton(_ sender: Any) {
        let fileBrowser = FileBrowser(initialPath: getDocumentsDirectory(), allowEditing: false, showCancelButton: true)
        fileBrowser.didSelectFile = { (file: FBFile) -> Void in
            let url = file.filePath
            let uiImage = url.pdfToUIImage()
            self.boletoImageView.image = uiImage
            
            let conversor = PDFToBarcodeConversor()
            let resultOrNil = conversor.tryDecodeBarcodeFromPDF(pdfUrl: url, tryOnlyOnce: false)
            if let result =  resultOrNil{
                if !result.text.isEmpty{
                    print(result.text!)
                    print(result.barcodeFormat.rawValue)
                    self.contentLabel.text = result.text
                }else{
                    self.contentLabel.text = "Barcode not found";
                }
                
            }else{
                self.contentLabel.text = "Barcode not found";
            }
        }
        present(fileBrowser, animated: true, completion: nil)
    }
    
    func getDocumentsDirectory() -> URL {
            let paths =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
    }
    
    
    
   
    
  
    
    
    
}

