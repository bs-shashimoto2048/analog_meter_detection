import Foundation
import AVFoundation
import opencv2

class VideoCapture: NSObject {
    let captureSession = AVCaptureSession()
    var handler: ((CMSampleBuffer) -> Void)?

    override init() {
        super.init()
        setup()
    }

    func setup() {
        captureSession.beginConfiguration()
        captureSession.sessionPreset = .vga640x480
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("Error: No video devices available")
            return
        }
        do {
            try device.lockForConfiguration()
            device.focusPointOfInterest = CGPoint(x: 0.5, y: 0.5)
            device.focusMode = .continuousAutoFocus
            device.exposurePointOfInterest = CGPoint(x: 0.5, y: 0.5)
            device.exposureMode = .continuousAutoExposure
            device.whiteBalanceMode = .continuousAutoWhiteBalance
            device.unlockForConfiguration()
        } catch {
            print("Error locking configuration: \(error)")
        }

        guard let deviceInput = try? AVCaptureDeviceInput(device: device), captureSession.canAddInput(deviceInput) else {
            print("Error: Cannot add video input")
            return
        }
        captureSession.addInput(deviceInput)

        let videoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "mydispatchqueue"))
        videoDataOutput.alwaysDiscardsLateVideoFrames = true

        guard captureSession.canAddOutput(videoDataOutput) else {
            print("Error: Cannot add video output")
            return
        }
        captureSession.addOutput(videoDataOutput)

        for connection in videoDataOutput.connections {
            if connection.isVideoOrientationSupported {
                connection.videoOrientation = .portrait
            }
        }

        captureSession.commitConfiguration()
    }

    func run(_ handler: @escaping (CMSampleBuffer) -> Void) {
        if !captureSession.isRunning {
            self.handler = handler
            DispatchQueue.main.async {
                if !self.captureSession.isRunning {
                    self.captureSession.startRunning()
                }
            }
        }
    }

    func stop() {
        if captureSession.isRunning {
            DispatchQueue.main.async {
                if self.captureSession.isRunning {
                    self.captureSession.stopRunning()
                }
            }
        }
    }
}

extension VideoCapture: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        DispatchQueue.main.async {
            self.handler?(sampleBuffer)
        }
    }
}
