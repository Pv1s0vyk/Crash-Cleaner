//The some codes are Chinese,please run with translators to translate
import UIKit

class CacheCleaner {
    
    static func cleanCache() {
        // 1. 清除图片缓存
        clearImageCache()
        
        // 2. 清除WebKit缓存
        clearWebKitCache()
        
        // 3. 清除日志文件
        clearLogFiles()
        
        // 4. 清除临时文件
        clearTemporaryFiles()
        
        // 5. 提醒清理已完成
        let alert = UIAlertController(title: "已完成清理", message: "缓存和垃圾文件已清理完成。", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "好的", style: .default, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    private static func clearImageCache() {
        // 清除图片缓存
        guard let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else { return }
        
        let imageCachePath = cachePath + "/com.apple.UIKit/UIImageDiskCache"
        clearDirectory(path: imageCachePath)
    }
    
    private static func clearWebKitCache() {
        // 清除WebKit缓存
        guard let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else { return }
        
        let webKitCachePath = cachePath + "/com.apple.WebKit.WebContent"
        clearDirectory(path: webKitCachePath)
    }
    
    private static func clearLogFiles() {
        // 清除日志文件
        guard let logPath = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first else { return }
        
        let logFilePath = logPath + "/logs"
        clearDirectory(path: logFilePath)
    }
    
    private static func clearTemporaryFiles() {
        // 清除临时文件
        let tempPath = NSTemporaryDirectory()
        clearDirectory(path: tempPath)
    }
    
    private static func clearDirectory(path: String) {
        let fileManager = FileManager.default
        do {
            let subFilePaths = try fileManager.contentsOfDirectory(atPath: path)
            for subFilePath in subFilePaths {
                let fullPath = path + "/" + subFilePath
                try fileManager.removeItem(atPath: fullPath)
            }
        } catch {
            print("清除 \(path) 中的文件失败：" + error.localizedDescription)
        }
    }
}

// 使用方式：
CacheCleaner.cleanCache()
