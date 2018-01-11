import UIKit
import Spring

class CircleView: SpringView {

    init(topColor: UIColor, bottomColor: UIColor) {
        self.topColor = topColor
        self.bottomColor = bottomColor
        super.init(frame: .zero)
        clipsToBounds = true
        backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
//        self.drawRect(layerF:layer)
//        self.drawFiveRect(layerF: layer)
        gradientLayer = createGradientLayer(withColors: [topColor, bottomColor])
    }
    
    func createLayer(layer :CALayer) {
        let path = UIBezierPath.init(roundedRect: layer.bounds, byRoundingCorners: [.topRight,.bottomRight] , cornerRadii: layer.bounds.size)
        let layerC = CAShapeLayer.init()
        layerC.path = path.cgPath
        layerC.lineWidth = 5
        layerC.lineCap = kCALineCapSquare
        layerC.strokeColor = UIColor.red.cgColor
        //  注意直接填充layer的颜色，不需要设置控件view的backgroundColor
        layerC.fillColor = UIColor.yellow.cgColor
        layer.addSublayer(layerC)
    }
    
    func drawRect(layerF:CALayer){
        let imageWH = (layerF.frame.width ) * 1.0
        let path = UIBezierPath.init()
        path.lineWidth = 2
        let single = CGFloat.init(sin(M_1_PI / 180*60))
        let point1 = CGPoint.init(x: single * (imageWH/2), y: imageWH / 4)
        let point2 = CGPoint.init(x: imageWH/2, y: 0)
        let point3 = CGPoint.init(x: imageWH - single * (imageWH/2), y: imageWH / 4)
        let point4 = CGPoint.init(x: imageWH - single * (imageWH/2), y: imageWH / 4 + imageWH / 2)
        let point5 = CGPoint.init(x: imageWH / 2, y: imageWH)
//        let point6 = CGPoint.init(x: single * (imageWH/2), y: imageWH / 4 + imageWH/2)
    
        path.move(to: point1)
        path.addLine(to: point2)
        path.addLine(to: point3)
        path.addLine(to: point4)
        path.addLine(to: point5)
//        path.addLine(to: point6)
        path.close()
        
        let laryS = CAShapeLayer.init()
        laryS.lineWidth = 2
        laryS.path = path.cgPath
        layerF.mask = laryS
    }
    
    func drawFiveRect(layerF:CALayer) { // 五边形
        let imageWH = (layerF.frame.width ) * 1.0
        let path = UIBezierPath.init()
        path.lineWidth = 2
        let color = UIColor.red
        color.set() // 设置线条颜色
        
        let aPath = UIBezierPath()
        
        aPath.lineWidth = 5.0 // 线条宽度
        aPath.lineCapStyle = CGLineCap.round // 线条拐角
        aPath.lineJoinStyle = CGLineJoin.round // 终点处理
        let single = CGFloat.init(sin(M_1_PI / 180*60))

        // Set the starting point of the shape.
        aPath.move(to: CGPoint.init(x: 100.0, y: 10.0))//(100, 10))
        aPath.addLine(to: CGPoint.init(x: 200, y: 140))
        aPath.addLine(to: CGPoint.init(x: 160, y: 10.0))
        aPath.addLine(to: CGPoint.init(x: 40, y: 140))
        aPath.addLine(to: CGPoint.init(x: 10, y: 40))
        aPath.close()
        
        // 最后一条线通过调用closePath方法得到
        let laryS = CAShapeLayer.init()
        laryS.lineWidth = 2
        laryS.path = path.cgPath
        layerF.mask = laryS
        
    }
    
    
    func creatSix(mlayer:CALayer) {
        let path = UIBezierPath.init()
        path.lineWidth = 2
        let width = (mlayer.frame.width ) * 1.0
        
//        path.move(to: CGPoint.init(x: (sin(M_1_PI/(180*60.0))*(width*0.5), y: width*0.25))
        path.move(to: CGPoint.init(x: 0.2*(width*0.5), y: width*0.25))

        path.addLine(to: CGPoint.init(x: width * 0.5, y: 0))
            
        path.addLine(to: CGPoint.init(x: width - 0.2*(width*0.5), y: width/2 + width/4))
            
        path.addLine(to: CGPoint.init(x: width, y: width))
        path.addLine(to: CGPoint.init(x: 0.5 * width/2, y: width/2 + width/4))
        path.close()
        
        let laryS = CAShapeLayer.init()
        laryS.lineWidth = 2
        laryS.path = path.cgPath
        mlayer.mask = laryS
//        mlayer.addSublayer(laryS)
     
    }

    // MARK: Gradient backgorund

    private var gradientLayer: CAGradientLayer? {
        didSet {
            if let oldValue = oldValue {
                oldValue.removeFromSuperlayer()
            }
            if let newValue = gradientLayer {
                layer.insertSublayer(newValue, at: 0)
            }
        }
    }

    private func createGradientLayer(withColors colors: [UIColor]) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = bounds
        layer.colors = colors.map { $0.cgColor }
        return layer
    }

    // MARK: Private

    private let topColor: UIColor
    private let bottomColor: UIColor

}
