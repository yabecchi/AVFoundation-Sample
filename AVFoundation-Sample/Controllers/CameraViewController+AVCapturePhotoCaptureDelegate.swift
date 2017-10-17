//
//  CameraViewController+.swift
//  AVFoundation-Sample
//
//  Created by ExtYabecchi on 2017/05/16.
//  Copyright © 2017年 ExtYabecchi. All rights reserved.
//

import UIKit
import AVFoundation

extension CameraViewController: AVCapturePhotoCaptureDelegate {

    func capture(_ captureOutput: AVCapturePhotoOutput,
                 didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?,
                 previewPhotoSampleBuffer: CMSampleBuffer?,
                 resolvedSettings: AVCaptureResolvedPhotoSettings,
                 bracketSettings: AVCaptureBracketedStillImageSettings?,
                 error: Error?) {
        
        guard let buffer = photoSampleBuffer,
            let photoData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: buffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer),
            let image = UIImage(data: photoData) else { return }
        
        let orientedImage = activeVideoInput.device.position == .back ?
            image :  UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: .leftMirrored)
        
        previewImage = orientedImage
        
        let identifier = Identifier.getString(status: .toPreviewViewController)
        performSegue(withIdentifier: identifier, sender: nil)
    }
}
