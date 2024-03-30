import UIKit

class ViewController: UIViewController {
    
    // 隊伍名稱
    @IBOutlet weak var teamA: UILabel!
    @IBOutlet weak var teamB: UILabel!
    
    // 大比分
    @IBOutlet weak var gamepointA: UILabel!
    @IBOutlet weak var gamepointB: UILabel!
    
    // 小比分
    @IBOutlet weak var pointA: UIButton!
    @IBOutlet weak var pointB: UIButton!
    
    // 計算小比分分數
    var pointA1 = 0
    var pointB1 = 0
    
    // 計算大比分分數
    var gamescoreA = 0
    var gamescoreB = 0
    
    // 得分圖片
    @IBOutlet weak var scoreImageA: UIImageView!
    var imageModel: ImageModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageModel = ImageModel()
    }
    
    @IBAction func ScoreA(_ sender: Any) {
        updateScore(for: 1)
    }
    
    @IBAction func ScoreB(_ sender: Any) {
        updateScore(for: 2)
    }
    
    private func updateScore(for team: Int) {
        let randomImage: UIImage?
        
        if team == 1 {
            randomImage = imageModel.getRandomImage(group: 1)
            pointA1 += 1
            pointA.setTitle("\(pointA1)", for: .normal)
        } else {
            randomImage = imageModel.getRandomImage(group: 2)
            pointB1 += 1
            pointB.setTitle("\(pointB1)", for: .normal)
        }
        
        guard let image = randomImage else { return }
        scoreImageA.image = image
        scoreImageA.isHidden = false
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
            self.scoreImageA.isHidden = true
        }
        
        if team == 1 && pointA1 == 10 {
            gamescoreA += 1
            gamepointA.text = "\(gamescoreA)"
            pointA.isEnabled = false
            pointB.isEnabled = false
        } else if team == 2 && pointB1 == 10 {
            gamescoreB += 1
            gamepointB.text = "\(gamescoreB)"
            pointA.isEnabled = false
            pointB.isEnabled = false
        }
        
        checkForWinner()
    }
    
    private func checkForWinner() {
        if gamescoreA == 2 {
            showWinnerAlert(winner: teamA.text ?? "玩家 A")
        } else if gamescoreB == 2 {
            showWinnerAlert(winner: teamB.text ?? "玩家 B")
        }
    }
    
    private func showWinnerAlert(winner: String) {
        let alert = UIAlertController(title: "恭喜", message: winner, preferredStyle: .alert)
        
        let replayAction = UIAlertAction(title: "再玩一次", style: .default) { _ in
            self.resetGame()
        }
        
        alert.addAction(replayAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func resetGame() {
        pointA1 = 0
        pointB1 = 0
        gamescoreA = 0
        gamescoreB = 0
        
        pointA.setTitle("0", for: .normal)
        pointB.setTitle("0", for: .normal)
        gamepointA.text = "0"
        gamepointB.text = "0"
        
        pointA.isEnabled = true
        pointB.isEnabled = true
        scoreImageA.isHidden = true
        
        teamA.text = "烏野高中"
        teamB.text = "音駒高中"
        
        imageModel.restImage()
    }
    
    @IBAction func Change(_ sender: Any) {
        // 交換大比分
           let gamepoint = gamepointA.text
           gamepointA.text = gamepointB.text
           gamepointB.text = gamepoint

           // 交換隊伍名稱
           let teamname = teamA.text
           teamA.text = teamB.text
           teamB.text = teamname

           // 交換大比分
           let gamescore = gamescoreA
           gamescoreA = gamescoreB
           gamescoreB = gamescore

           // 重置小比分
           resetPoints()
           
           // 重新啟用按鈕
           pointA.isEnabled = true
           pointB.isEnabled = true

           // 隱藏得分圖片
           scoreImageA.isHidden = true
           
           // 交換圖片組
           imageModel.swapImageGroups()
    }
    
    @IBAction func Clear(_ sender: Any) {
        resetGame()
    }
    
    private func resetPoints() {
        pointA1 = 0
        pointB1 = 0
        pointA.setTitle("0", for: .normal)
        pointB.setTitle("0", for: .normal)
    }
}
