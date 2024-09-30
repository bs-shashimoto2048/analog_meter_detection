/* ==============================================================================================
 ContentView.swift_2024/09/25
 - 必要スペック:iPhoneXs, iOS17.4
 ============================================================================================== */
/* Note:今回の修正内容
 - 画面の構成は今回ので一旦完了とする。
 - 処理部分はメモリに負担かけてないか再度確認する。(途中１回これでApp強制終了)
 - 表示内容や文字フォントも形・色など見やすい構成にする。
 - コード全体的にもう少し見やすくする。
 */

import SwiftUI
import UIKit
import AVFoundation
import Foundation
import opencv2 // (要)作成

/* ==============================================================================================
 SubFunctions:Capture
 ============================================================================================== */
// 点描画用関数を定義
func drawPointOnCircle(center: Point, radius: Int32, angle: Double, text: String, mat: Mat) {
    let angleInRadians = (90 + angle) * .pi / 180.0 // ラジアンに変換
    let pointOnCircleX = center.x + Int32(Double(radius) * cos(angleInRadians))
    let pointOnCircleY = center.y + Int32(Double(radius) * sin(angleInRadians))
    let pointOnCircle = Point(x: pointOnCircleX, y: pointOnCircleY)

    // メモリ色
    let memoryR = 0.0
    let memoryG = 210.0
    let memoryB = 110.0

    // 数値を整形
    let formattedText: String
    if let number = Double(text) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 2
        formattedText = formatter.string(from: NSNumber(value: number)) ?? text
    } else {
        formattedText = text
    }

    // 円を描画
    Imgproc.circle(img: mat, center: pointOnCircle, radius: 5, color: Scalar(memoryR, memoryG, memoryB, 255), thickness: 1)

    // テキストを描画
    Imgproc.putText(img: mat, // Mat:テキストを描画する対象の画像
                    text: formattedText, // 整形したテキスト
                    org: Point(x: pointOnCircleX - 15, y: pointOnCircleY - 10), // テキスト描画位置
                    fontFace: HersheyFonts.FONT_HERSHEY_SIMPLEX, // フォントスタイル
                    fontScale: 0.5, // フォントのサイズ
                    color: Scalar(memoryR, memoryG, memoryB, 255), // テキストカラー
                    thickness: 2) // テキスト太さ
}

// 関数を使用して複数の点を描画
func drawMultiplePointsOnCircle(center: Point, radius: Int32, angles: [Double], texts: [String], mat: Mat) {
    for (index, angle) in angles.enumerated() {
        let text = texts[index]
        drawPointOnCircle(center: center, radius: radius, angle: angle, text: text, mat: mat)
    }
}

// 検出エッジ角度に対し前後２つの角度を取得し、それに対応するメモリ値を計算
func calculateMemoryValue(for x: Double, angles: [Double], memorys: [Double]) -> Double? {
    // anglesのインデックスを取得
    guard let index = angles.firstIndex(where: { $0 >= x }) else {
        return nil // xより大きい角度がない場合はnilを返す
    }

    // 前後の角度を取得
    let lowerIndex = max(index - 1, 0) // 前のインデックス
    let upperIndex = index // 現在のインデックス

    // 最小値が必要な場合は、適切な条件でインデックスを取得
    if lowerIndex == upperIndex {
        return memorys[lowerIndex] // 値が一致する場合はその値を返す
    }

    let angle1 = angles[lowerIndex]
    let angle2 = angles[upperIndex]
    let value1 = memorys[lowerIndex]
    let value2 = memorys[upperIndex]

    // 線形補間を使用して検出角度に対応する値を計算
    let calculatedValue = value1 + ((value2 - value1) / (angle2 - angle1)) * (x - angle1)

    return calculatedValue
}

// テキスト描写:メーターメモリ
func drawTextOnImage(
    mat: Mat,
    text: String,
    xOffset: Int32, // X方向のオフセット
    yOffset: Int32, // Y方向のオフセット
    center: Point, // 中心位置
    fontScale: Double,
    color: Scalar,
    thickness: Int32
) {
    let position = Point(x: center.x + xOffset, y: center.y + yOffset)
    Imgproc.putText(img: mat,
                    text: text,
                    org: position,
                    fontFace: HersheyFonts.FONT_HERSHEY_SIMPLEX,
                    fontScale: fontScale,
                    color: color,
                    thickness: thickness)
}

// テキスト描写:検出結果
func drawValueText(
    mat: Mat,
    drawText: String,        // テキスト内容
    detectTextPoint: Point,  // テキスト描画位置
    textColor: Scalar        // テキストの色
) {
    let shadowColor = Scalar(220, 220, 220, 255) // 影の色（灰色）
    let shadowThickness: Int32 = 3 // 影の太さ
    let textScale: Double = 0.7 // テキストのスケール
    let textThick: Int32 = 2 // テキストの太さ

    // 影描写
    Imgproc.putText(
        img: mat,
        text: drawText,
        org: detectTextPoint,
        fontFace: HersheyFonts.FONT_HERSHEY_SIMPLEX,
        fontScale: textScale,
        color: shadowColor,
        thickness: shadowThickness
    )

    // テキスト描写
    Imgproc.putText(
        img: mat,
        text: drawText,
        org: detectTextPoint,
        fontFace: HersheyFonts.FONT_HERSHEY_SIMPLEX,
        fontScale: textScale,
        color: textColor,  // 引数で指定されたテキストの色
        thickness: textThick
    )
}

// 画像保存処理の補助関数
extension UIImage {
    // MatをUIImageに変換するための関数
    convenience init?(mat: Mat) {
        let size = CGSize(width: CGFloat(mat.cols()), height: CGFloat(mat.rows()))
        let colorSpace = CGColorSpaceCreateDeviceRGB()

        let data = mat.dataPointer() // 修正: dataPtr()をdataPointer()に変更
        guard let provider = CGDataProvider(data: NSData(bytes: data, length: Int(mat.elemSize() * mat.total()))),
              let cgImage = CGImage(width: Int(size.width),
                                    height: Int(size.height),
                                    bitsPerComponent: 8,
                                    bitsPerPixel: 8 * 4,
                                    bytesPerRow: mat.step1(),
                                    space: colorSpace,
                                    // 修正: CGBitmapInfoの設定を適切に変更
                                    bitmapInfo: CGBitmapInfo(
                                        rawValue: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue),
                                    provider: provider,
                                    decode: nil,
                                    shouldInterpolate: false,
                                    intent: .defaultIntent)
        else {
            return nil
        }

        self.init(cgImage: cgImage)
    }
}


/* ==============================================================================================
 MaineFunctions:Capture
 ============================================================================================== */
// エッジ検出処理
struct ImageProcessor {
    // 一時的に保持する画像データの配列
    static var capturedImageFileNames: [(UIImage, String)] = []
    static var capturedImages: [UIImage] = []
    // 測定最大値:プロパティとして宣言
    static var maxVal: Double = 0.0
    // タイマー用のプロパティ
    static var captureTimer: Timer?
    // 画像が保存される準備が整ったかどうかのフラグ
    static var isCapturingImage = false
    // キャプチャキープ用
    static var capturedMat: Mat?
    // 検出値が最大の時、キャプチャ映像を保存する関数:キャプチャ１回につき画像１枚を写真フォルダへ保存する
    static func captureAndSaveImage(mat: Mat, selectedMode: String, selectedAmpere: Double) {
        DispatchQueue.global(qos: .background).async {
            // 日付フォーマットの設定
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            let formattedDate = dateFormatter.string(from: Date())

            // selectedAmpereのフォーマット
            let formattedAmpere: String
            if selectedAmpere < 1.0 {
                formattedAmpere = String(format: "%03d", Int(selectedAmpere * 100))
            } else {
                formattedAmpere = "\(Int(selectedAmpere))"
            }

            // OpenCVのMatをUIImageに変換
            if let uiImage = UIImage(mat: mat) {
                // 画像データを一時的に保持
                capturedImages.append(uiImage)

                // ファイル名を保持するためのタプルを追加
                capturedImageFileNames.append((uiImage, "\(selectedMode)_\(formattedAmpere)A_\(formattedDate).jpg"))
                print("キャプチャ映像を保持しました: \(formattedAmpere)A")
            } else {
                print("MatからUIImageへの変換に失敗しました。")
            }
        }
    }
    // 指定フォーマットで現在時刻を取得
    static func getCurrentTimeString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return formatter.string(from: Date())
    }


    static func detectEdgesAndDrawLines(image: UIImage?, threshold1: Double, threshold2: Double, minLineLength: Double, maxLineLength: Double, maxLineGap: Double, startAngle: Double, endAngle: Double, selectedMode: String, selectedAmpere: Double) -> UIImage? {

        // 画像が存在しない場合は nil を返す
        guard let image = image else {
            return nil
        }

        // 開始角の調整角度を定義(+90度)
        let adjustmentAngle: Double = 90
        // 角度の調整
        let adjustedStartAngle = startAngle + adjustmentAngle
        let adjustedEndAngle = endAngle + adjustmentAngle

        // UIImage を Mat に変換
        let mat = Mat(uiImage: image)
        let grayMat = Mat() // グレースケール画像用の Mat
        let edges = Mat() // エッジ検出結果用の Mat

        // 入力画像をグレースケールに変換
        Imgproc.cvtColor(src: mat, dst: grayMat, code: ColorConversionCodes.COLOR_RGB2GRAY)
        // Canny エッジ検出を実行
        Imgproc.Canny(image: grayMat, edges: edges, threshold1: threshold1, threshold2: threshold2)

        // 画像の中心を計算
        let center = Point(x: Int32(mat.cols() / 2), y: Int32(mat.rows() / 2) - 60) // 中心点
        let radius: Int32 = (mat.cols() / 2) - 20 // 扇形マスクの半径（固定値）

        // 扇形マスクを作成し、エッジ検出結果に適用
        let mask = Mat.zeros(edges.size(), type: CvType.CV_8UC1)
        Imgproc.ellipse(
            img: mask,                                  // 描画対象の画像 (mask や mat など)
            center: center,                             // 楕円の中心点。Point 型で指定。
            axes: Size(width: radius, height: radius),  // 楕円の長軸と短軸のサイズ。Size 型で指定。
            angle: 0,                                   // 楕円の回転角度。Double 型で指定。
            startAngle: adjustedStartAngle,             // 楕円の開始角度。Double 型で指定。
            endAngle: adjustedEndAngle,                 // 楕円の終了角度。Double 型で指定。
            color: Scalar(255),                         // 楕円の色。Scalar 型で指定。
            thickness: -1                               // 楕円の線の太さ。Int 型で指定。-1 の場合は塗りつぶし。
        )

        /* 以下(***)のメモリ配置処理はリストデータ読み込むか設定画面に項目追加し簡単にセットできるようにする */
        /* ************************************************************************************************************* */
        // マスク円周上の指定角度へメモリ点を描写(listで処理),また以下は処理的にDoubleで扱うので注意。
        let angles = [135, 144, 153, 162, 171, 180, 189, 198, 207, 216, 225].map { Double($0) } // List(Double):検出メモリ角度
        let memorys = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0].map { Double($0) } // List(Double): 読取メモリ値

        // memorysの各値に係数を掛けた新しいリストを作成
        let adjustedMemorys = memorys.map { $0 * selectedAmpere } // 選択レンジはそのまま係数として使用
        // adjustedMemorysを文字列に変換
        let texts = adjustedMemorys.map { String($0) } // List(String): 表示テキスト
        /* ************************************************************************************************************* */

        // メモリ点を入力画像に描写
        drawMultiplePointsOnCircle(center: center, radius: radius, angles: angles, texts: texts, mat: mat)

        // 扇形マスクを入力画像に描画（目視確認用）
        Imgproc.ellipse(img: mat, center: center, axes: Size(width: radius, height: radius), angle: 0, startAngle: adjustedStartAngle, endAngle: adjustedEndAngle, color: Scalar(0, 220, 120, 255), thickness: 1)

        // 開始角度と終了角度をラジアンに変換
        let startAngleRadians = adjustedStartAngle * .pi / 180.0
        let endAngleRadians = adjustedEndAngle * .pi / 180.0

        // 扇形の開始点と終了点を計算
        let startX = center.x + Int32(Double(radius) * cos(startAngleRadians))
        let startY = center.y + Int32(Double(radius) * sin(startAngleRadians))
        let endX = center.x + Int32(Double(radius) * cos(endAngleRadians))
        let endY = center.y + Int32(Double(radius) * sin(endAngleRadians))

        // 開始点と終了点を Point オブジェクトとして定義
        let startPoint = Point(x: startX, y: startY)
        let endPoint = Point(x: endX, y: endY)

        // 中心点を示す円を描画
        Imgproc.circle(img: mat, center: center, radius: 5, color: Scalar(255, 0, 0, 255), thickness: -1)
        // 扇形の中心から開始点と終了点に直線を描画
        Imgproc.line(img: mat, pt1: center, pt2: startPoint, color: Scalar(0, 100, 255, 255), thickness: 1)
        Imgproc.line(img: mat, pt1: center, pt2: endPoint, color: Scalar(255, 0, 100, 255), thickness: 1)

        // 画面用テキストを描画
        drawTextOnImage(mat: mat, text: "Start", xOffset: -50, yOffset: 20, center: startPoint, fontScale: 0.7, color: Scalar(0, 150, 255, 255), thickness: 2)
        drawTextOnImage(mat: mat, text: "End", xOffset: 10, yOffset: 20, center: endPoint, fontScale: 0.7, color: Scalar(255, 0, 150, 255), thickness: 2)
        drawTextOnImage(mat: mat, text: "A", xOffset: -15, yOffset: -80, center: center, fontScale: 2.0, color: Scalar(0, 220, 120, 255), thickness: 3)

        // 扇形マスクを使ってエッジ検出結果をマスク
        let maskedEdges = Mat()
        Core.bitwise_and(src1: edges, src2: mask, dst: maskedEdges)

        // Hough 変換で直線を検出
        let lines = Mat()
        Imgproc.HoughLinesP(image: maskedEdges, lines: lines, rho: 1, theta: .pi / 180, threshold: 50, minLineLength: minLineLength, maxLineGap: maxLineGap)

        var longestLine: (Point, Point)? = nil // 最も長い直線
        var maxLength: Double = 0.0 // 現在の最大長さ
        var lineAngle: Double = 0.0 // 最長直線の角度

        // 検出した直線ごとにループ
        for i in 0..<lines.rows() {
            let line = lines.row(i)
            let x1 = line.get(row: 0, col: 0)[0] as! Double
            let y1 = line.get(row: 0, col: 0)[1] as! Double
            let x2 = line.get(row: 0, col: 0)[2] as! Double
            let y2 = line.get(row: 0, col: 0)[3] as! Double

            // 直線の長さを計算
            let length = hypot(x2 - x1, y2 - y1)

            // 最小長さと最大長さの範囲に収まるか確認
            if length >= minLineLength && length <= maxLineLength && length > maxLength {
                // 中心から直線の両端点までの距離を計算
                let distanceToStart = hypot(Double(center.x) - x1, Double(center.y) - y1)
                let distanceToEnd = hypot(Double(center.x) - x2, Double(center.y) - y2)

                // 中心から最も遠い点を選択
                let (lineStartPoint, lineEndPoint) = distanceToStart > distanceToEnd ? (Point(x: Int32(x1), y: Int32(y1)), Point(x: Int32(x2), y: Int32(y2))) : (Point(x: Int32(x2), y: Int32(y2)), Point(x: Int32(x1), y: Int32(y1)))

                // 指定された線が中心点からの放射状にあるかどうかを判定する
                let isValidLine = isLineValidForCenter(x1: Double(lineStartPoint.x), y1: Double(lineStartPoint.y), x2: Double(lineEndPoint.x), y2: Double(lineEndPoint.y), center: center, radius: radius)
                if isValidLine {
                    maxLength = length
                    longestLine = (lineStartPoint, lineEndPoint)

                    // エッジの角度を計算
                    let deltaX = Double(lineEndPoint.x - center.x)
                    let deltaY = Double(lineEndPoint.y - center.y)
                    lineAngle = atan2(deltaY, deltaX) * 180.0 / .pi
                }
            }
        }

        // 最も長い直線が見つかった場合
        if let (startPoint, endPoint) = longestLine {

            // 2点間のベクトルを計算
            let vector = (x: Double(endPoint.x - startPoint.x), y: Double(endPoint.y - startPoint.y))

            // 始点と中心点の距離を計算
            let deltaX = Double(startPoint.x - center.x)
            let deltaY = Double(startPoint.y - center.y)
            let length = hypot(deltaX, deltaY)

            // atan2関数を使用して角度をラジアンから度に変換
            let angleXY = atan2(vector.x, vector.y) * 180 / .pi

            // 角度を -180 度分調整し、360 度に修正
            let detectDegree = (angleXY - 180).truncatingRemainder(dividingBy: 360)

            // 絶対値を取って角度を反転
            let absDegree = -detectDegree // Swiftは画面左上が0,0なので+-を逆転して絶対値を使用する

            /* 検出結果テキストの作成 */
            let ampereText: String

            // メモリ値の計算
            if let value = calculateMemoryValue(for: absDegree, angles: angles, memorys: adjustedMemorys) {
                // 最大値更新時
                if value > maxVal {
                    maxVal = value
                    // Debug:検出値及び最大値
                    print(String(format: "Max Value: %.2f[A], Detect Value: %.2f[A]", maxVal, value))

                    // タイマーを開始し、値を一定時間(withTimeInterval[s])キープ後に次の条件を満たしたら保存する
                    if captureTimer == nil {
                        captureTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
                            self.isCapturingImage = true
                            capturedMat = mat // 画面のキャプチャを保持
                            print(String(format: "キャプチャ画像保存の準備ができました: %.2f[A]", maxVal))
                        }
                    }
                }

                // 一定時間後、指定の条件を満たした時に画像を保存する
                if isCapturingImage && value < maxVal * 0.8 { // (仮)maxVal の80%以下になった場合
                    print("キャプチャ映像条件:True, value ->", value)

                    // capturedMat が nil でないことを確認してから画像を保存
                    if let capturedImage = capturedMat {
                        captureAndSaveImage(mat: capturedImage, selectedMode: selectedMode, selectedAmpere: selectedAmpere)
                    }

                    // タイマーとフラグをリセット
                    captureTimer?.invalidate()
                    captureTimer = nil
                    isCapturingImage = false
                }

                // テキスト: 検出最大値, 検出メモリ値
                ampereText = String(format: "Max : %.2f[A], Detect: %.2f[A]", maxVal, value)
            } else {
                ampereText = "ERR: 未検出です"
            }

            // 検出エッジ描写
            Imgproc.line(img: mat, pt1: center, pt2: startPoint, color: Scalar(255, 0, 0, 255), thickness: 2)

            /* テキスト描画算出メモリ値表 */
            let ampereTextPosition = Point(x: 10, y: Int32(mat.rows() - 10))
            let ampereTextColor = Scalar(255, 0, 0, 255) // テキスト色:Red
            drawValueText(mat: mat, drawText: ampereText, detectTextPoint: ampereTextPosition, textColor: ampereTextColor)
        }

        // ※キャプチャ画像でもわかるように　画面内に現在時刻とテスト時の条件を追加で表示する
        /* テキスト描画:時刻表示 */
        let timeText: String = getCurrentTimeString() // 現在時刻を取得
        let timeTextPosition = Point(x: 10, y: Int32(mat.rows() - 70)) // テキスト位置を設定
        let timeTextColor = Scalar(100, 100, 100, 255) // テキスト色: グレー
        drawValueText(mat: mat, drawText: timeText, detectTextPoint: timeTextPosition, textColor: timeTextColor)

        /* テキスト描画:試験デバイス, 使用アンペアレンジ設定 */
        let testmodeText = String(format:"Devuce: %@, Range: %.2f[A]", selectedMode, selectedAmpere)
        let testmodePosition = Point(x: 10, y: Int32(mat.rows() - 40)) // テキスト位置
        let testmodeTextColor = Scalar(0, 0, 255, 255)                     // テキスト色:Blue
        drawValueText(mat: mat, drawText: testmodeText, detectTextPoint: testmodePosition, textColor: testmodeTextColor)

        // 最終的な画像を UIImage に変換して返す
        return mat.toUIImage()
    }

    // 指定された線が中心点からの放射状にあるかどうかを判定する関数
    private static func isLineValidForCenter(x1: Double, y1: Double, x2: Double, y2: Double, center: Point, radius: Int32) -> Bool {
        let lineVector = (x2 - x1, y2 - y1)
        let centerVector = (Double(center.x) - x1, Double(center.y) - y1)

        let dotProduct = lineVector.0 * centerVector.0 + lineVector.1 * centerVector.1
        let lineLength = hypot(lineVector.0, lineVector.1)
        let centerDistance = hypot(centerVector.0, centerVector.1)
        let angle = acos(dotProduct / (lineLength * centerDistance))
        return angle < .pi / 180 // 1度以内であれば放射状とみなす
    }

}

/* ==============================================================================================
 SubFunctions:Screen
 ============================================================================================== */
// 初期値管理構造体
struct InitSettings {
    // エッジ検出の設定を管理するState変数
    static let initialthreshold1: Double = 30.0    // エッジ検出閾値:低
    static let initialthreshold2: Double = 80.0    // エッジ検出閾値:高
    static let initialminLineLength: Double = 50.0 // 最小検出線分の長さ:px
    static let initialmaxLineLength: Double = 300.0 // 最大検出線分の長さ:px
    static let initialmaxLineGap: Double = 80.0     // 最大検出線間のギャップ:px
    // 扇形マスク(円形セクター)範囲
    static let initialStartAngle: Double = 125.0 // 開始角度
    static let initialEndAngle: Double = 235.0  // 終了角度
}


/* ==============================================================================================
 MaineFunctions:Screen
 ============================================================================================== */
// 画面構成
struct ContentView: View {
    // 映像キャプチャ用のオブジェクトを作成
    let videoCapture = VideoCapture()

    // 画像とキャプチャ状態を保持するためのState変数
    @State private var image: UIImage? = UIImage(named: "placeholder")
    @State private var isCapturing: Bool = false

    // 設定画面の表示/非表示を管理するState変数
    @State private var showSettings1 = false
    @State private var showEdgeDetectSensitiveSettings = false
    @State private var showFanSettings = false

    // エッジ検出の設定を管理するState変数
    @State private var threshold1: Double = InitSettings.initialthreshold1
    @State private var threshold2: Double = InitSettings.initialthreshold2
    @State private var minLineLength: Double = InitSettings.initialminLineLength
    @State private var maxLineLength: Double = InitSettings.initialmaxLineLength
    @State private var maxLineGap: Double = InitSettings.initialmaxLineGap

    // 扇形マスク(円形セクター)範囲を管理する変数
    @State private var startAngle: Double = InitSettings.initialStartAngle
    @State private var endAngle: Double = InitSettings.initialEndAngle

    // 検査時使用アンペアメモリ設定
    @State private var selectedMode: String = "OCR"  // 初期選択値
    @State private var selectedAmpere: Double = 1.0 // 初期値

    var body: some View {
        // 画面サイズ設定:
        let captureWidth: CGFloat = 360   // キャプチャ画面:幅 <- 320(min)
        let captureHeight: CGFloat = 540  // キャプチャ画面:高 <- 480(min)
        let menuWidth = captureWidth - 60 // 設定画面:幅
        // セレクトボックス選択肢
        let modeSettings: [String] = ["OCR","GCR","PUN","OVR/UVR","DRG"] // テストモード
        let ampereSettings: [Double] = [0.25, 0.5, 1.0, 2.5, 5.0, 10.0, 25.0, 50.0] // アンペアレンジ

        NavigationView {
            ZStack {
                VStack { // <- 画面動かす必要なくなったのでこっちに戻す // _ScrollView {
                    VStack {
                        // ヘッダーセクション
                        Text("Real-Time Analysis")
                            .navigationBarTitle("Analog Meter Detection", displayMode: .inline)
                            .navigationBarItems(
                                leading: Button(action: {
                                    showEdgeDetectSensitiveSettings.toggle()
                                }) {
                                    // アイコンタップアクション:左
                                    HStack {
                                        // 左側アイコン:システム変数は SF Symbols で確認
                                        Image(systemName: "sparkle.magnifyingglass") // システム定数で指定
                                            .imageScale(.large) // サイズ
                                        Text("Edge") // ラベル
                                    }
                                },
                                // アイコンタップアクション:右
                                trailing: Button(action: {
                                    showFanSettings.toggle()
                                }) {
                                    HStack {
                                        Image(systemName: "circle.dotted")
                                            .imageScale(.large)
                                        Text("Area")
                                    }
                                }
                            )
                    }

                    // キャプチャされた画像を表示
                    if let image = image {
                        Image(uiImage: image)
                            .resizable() // 画像サイズを変更可能に
                            .scaledToFit() // アスペクト比を保ってサイズ変更
                            .frame(width: captureWidth, height: captureHeight) // 画像サイズ
                    }

                    HStack{

                        VStack{
                            // ラベルを追加
                            Text("TEST MODE")
                                .font(.system(size: 12))
                            //                                .font(.headline)  // フォントサイズやスタイルを調整できます

                            Picker(selection: $selectedMode, label: Text("Mode")) {
                                ForEach(modeSettings, id: \.self) { mode in
                                    Text(mode)
                                        .font(.system(size: 14))  // フォントサイズを指定
                                }
                            }
                            .pickerStyle(InlinePickerStyle())
                            .frame(width: 100, height: 100)
                            .disabled(isCapturing)  // キャプチャ中は操作不可
                            .overlay(
                                isCapturing ? Color.black.opacity(0.4) : Color.clear  // キャプチャ中は曇りを追加
                            )
                        }

                        // トグルボタン:スタート/ストップ
                        Button(action: {
                            if isCapturing {
                                videoCapture.stop() // キャプチャ停止
                                // キャプチャ停止時に保持した画像を保存
                                if let lastCapturedImage = ImageProcessor.capturedImages.last,
                                   let lastFileName = ImageProcessor.capturedImageFileNames.last?.1 { // ここでファイル名を取得
                                    UIImageWriteToSavedPhotosAlbum(lastCapturedImage, nil, nil, nil)
                                    print("キャプチャ映像が写真ライブラリに保存されました: \(lastFileName)")
                                }

                            } else {
                                // キャプチャ開始時に最大値リセット
                                ImageProcessor.maxVal = 0.0
                                // 画像データをリセット
                                ImageProcessor.capturedImages.removeAll()
                                ImageProcessor.capturedImageFileNames.removeAll()

                                // キャプチャ開始
                                startCapturing()
                            }
                            isCapturing.toggle() // 状態切替
                        }) {
                            Text(isCapturing ? "Stop" : "Start")
                                .font(.title)
                                .frame(width: 120, height: 50)
                                .background(isCapturing ? Color.red : Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }

                        // 使用アンペアレンジ
                        VStack{
                            // タイトル
                            Text("AM METER")
                                .font(.system(size: 12))
                            // .font(.headline) // フォントサイズやスタイルを調整可能
                            // セレクトボックス:キャプチャ中は無効化して曇らせる
                            Picker(selection: $selectedAmpere, label: Text("Ampere")) {
                                ForEach(ampereSettings, id: \.self) { setting in
                                    // アンペアの値を表示(正数,浮動小数点どちらでも適切に表示する)
                                    Text(setting == Double(Int(setting)) ? "\(Int(setting)) A" : "\(setting, specifier: "%.2f") A")
                                        .font(.system(size: 14)) // フォントサイズを指定
                                }
                            }
                            .pickerStyle(InlinePickerStyle())
                            .frame(width: 100, height: 100)
                            .disabled(isCapturing) // キャプチャ中は操作不可
                            .overlay(
                                isCapturing ? Color.black.opacity(0.4) : Color.clear // キャプチャ中は曇りを追加
                            )
                        }
                    }
                } // ScrollView の End

                // 設定画面の表示
                VStack {
                    // エッジ検出設定用のスライダーを表示
                    if showEdgeDetectSensitiveSettings {
                        VStack {
                            HStack{
                                // 説明テキスト
                                Text("検出設定")
                                    .font(.system(size: 12, weight: .bold)) // 太さ指定:light → regular → semibold → bold → heavy
                                    .frame(maxWidth: .infinity, alignment: .leading) // 幅を最大にして左寄せにする

                                // リセットボタン
                                Button(action: {
                                    resetMaskArea()
                                }) {
                                    Text("Reset")
                                        .frame(width: 60, height: 30)
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                            // パラメータ
                            HStack {
                                Text("エッジ感度/低: \(Int(threshold1))")
                                    .font(.system(size: 11))
                                Slider(value: $threshold1, in: 0...255)
                            }
                            HStack {
                                Text("エッジ感度/高: \(Int(threshold2))")
                                    .font(.system(size: 11))
                                Slider(value: $threshold2, in: 0...255)
                            }
                            HStack {
                                Text("検出エッジ/最小: \(Int(minLineLength))")
                                    .font(.system(size: 11))
                                Slider(value: $minLineLength, in: 10...captureHeight)
                            }
                            HStack {
                                Text("検出エッジ/最大: \(Int(maxLineLength))")
                                    .font(.system(size: 11))
                                Slider(value: $maxLineLength, in: 10...captureHeight)
                            }
                            HStack {
                                Text("エッジ間隔: \(Int(maxLineGap))")
                                    .font(.system(size: 11))
                                Slider(value: $maxLineGap, in: 10...captureHeight)
                            }
                        }
                        .frame(width: menuWidth) // 設定画面の幅を指定
                        .padding()
                        .background(Color.black.opacity(0.4)) // 背景に透過色を設定
                        .cornerRadius(10)
                        .transition(.slide) // アニメーションでスライド表示
                    }

                    // 扇形設定用のスライダーを表示
                    if showFanSettings {
                        VStack {
                            HStack{// 説明テキスト
                                Text("マスク範囲設定")
                                    .font(.system(size: 12, weight: .bold))
                                    .frame(maxWidth: .infinity, alignment: .leading) // 幅を最大にして左寄せにする

                                // リセットボタン
                                Button(action: {
                                    resetAngles()
                                }) {
                                    Text("Reset")
                                        .frame(width: 60, height: 30)
                                        .background(Color.red)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                }
                            }
                            // パラメータ
                            HStack {
                                Text("開始: \(Int(startAngle))度")
                                    .font(.system(size: 11))
                                Slider(value: $startAngle, in: 0...360)
                            }
                            HStack {
                                Text("終了: \(Int(endAngle))度")
                                    .font(.system(size: 11))
                                Slider(value: $endAngle, in: 0...360)
                            }
                        }
                        .frame(width: menuWidth) // 設定画面の幅を指定
                        .padding()
                        .background(Color.black.opacity(0.4)) // 背景に透過色を設定
                        .cornerRadius(10)
                        .transition(.slide) // アニメーションでスライド表示
                    }
                }
                .padding()

            }
        }
        /* スライダー挙動のために起動時の立ち上げを廃止_2024/09/19
                 .onAppear {
         startCapturing() // アプリ開始時にキャプチャを開始
         } */
    }

    // 映像キャプチャを開始する関数
    func startCapturing() {
        videoCapture.run { sampleBuffer in
            guard let uiImage = self.convertSampleBufferToUIImage(sampleBuffer) else {
                return
            }
            DispatchQueue.main.async {
                // キャプチャした画像にエッジ検出と直線描画を行う
                self.image = ImageProcessor.detectEdgesAndDrawLines(image: uiImage, threshold1: self.threshold1, threshold2: self.threshold2, minLineLength: self.minLineLength, maxLineLength: self.maxLineLength, maxLineGap: self.maxLineGap, startAngle: self.startAngle, endAngle: self.endAngle, selectedMode: self.selectedMode, selectedAmpere: self.selectedAmpere)
            }
        }
    }

    // CMSampleBufferからUIImageに変換する関数
    private func convertSampleBufferToUIImage(_ sampleBuffer: CMSampleBuffer) -> UIImage? {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return nil
        }
        let ciImage = CIImage(cvImageBuffer: pixelBuffer)
        let context = CIContext()
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
            return nil
        }
        return UIImage(cgImage: cgImage)
    }
    // エッジ検出設定を初期値にリセットする関数
    private func resetMaskArea() {
        threshold1 = InitSettings.initialthreshold1
        threshold2 = InitSettings.initialthreshold2
        minLineLength = InitSettings.initialminLineLength
        maxLineLength = InitSettings.initialmaxLineLength
        maxLineGap = InitSettings.initialmaxLineGap
    }
    // 角度を初期値にリセットする関数
    private func resetAngles() {
        startAngle = InitSettings.initialStartAngle
        endAngle = InitSettings.initialEndAngle
    }
}
