//
//  GameViewController.swift
//  BombGame
//
//  Created by Александра Савчук on 07.08.2023.
//

import UIKit
import AVKit
import AVFoundation

class GameViewController: UIViewController, AVAudioPlayerDelegate {

  var playerBG: AVAudioPlayer?
  var playerTimer: AVAudioPlayer?
  var bombSoundPlayer: AVAudioPlayer?
  var bombShortImageView: UIImageView!
  var bombLongImageView: UIImageView!
  var gameState: GameState = .idle
  var gameTimer: DispatchSourceTimer?
  var timerPausedTime: TimeInterval?
  var gameDuration: TimeInterval = UserDefaultsManager.shared.gameDuration
  var remainingTime: TimeInterval = 0
  var gamePausedTime: Date?
  let normalImage = UIImage(systemName: "pause.circle")
  let pressedImage = UIImage(systemName: "play.circle")

  let questions = DataManager.shared.categories
    .filter { UserDefaultsManager.shared.selectedCategories.contains($0.name) }
    .flatMap { $0.questions }
  var shouldUpdateQuestion = true

  private lazy var playButton: CustomButton = {
    let playButton = CustomButton(customTitle: "Запустить")
    playButton.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
    playButton.translatesAutoresizingMaskIntoConstraints = false
    return playButton
  }()

  private lazy var gradientView: GradientView = {
    let gradientView = GradientView(frame: view.bounds)
    gradientView.translatesAutoresizingMaskIntoConstraints = false
    return gradientView
  }()

  let textLabel: UILabel = {
    let textLabel = UILabel()
    textLabel.text = "Нажмите “Запустить” чтобы начать игру"
    textLabel.frame = CGRect(x: 24, y: 127, width: 329, height: 200)
    textLabel.numberOfLines = 0
    textLabel.lineBreakMode = .byWordWrapping
    textLabel.textColor = .purpleLabel
    textLabel.textAlignment = .center
    textLabel.font = UIFont.boldSystemFont(ofSize: 35)
    return textLabel
  } ()

  let textLabelPause: UILabel = {
    let textLabelPause = UILabel()
    textLabelPause.text = "ПАУЗА"
    textLabelPause.frame = CGRect(x: 24, y: 127, width: 329, height: 200)
    textLabelPause.numberOfLines = 0
    textLabelPause.lineBreakMode = .byWordWrapping
    textLabelPause.textColor = .purpleLabel
    textLabelPause.textAlignment = .center
    textLabelPause.font = UIFont.boldSystemFont(ofSize: 35)
    return textLabelPause
  } ()

  private lazy var timerLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 20)
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  //MARK: Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "Игра"
    textLabelPause.isHidden = true
    addRightNavButton()
    subviews()
    setupConstraints()
    setupGIFs()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    gameState = .idle
    stopAllSoundsAndAnimations()
    endGame()
  }

  //MARK: Funcs
  private func subviews() {
    view.addSubview(gradientView)
    view.addSubview(textLabel)
    view.addSubview(playButton)
    view.addSubview(textLabelPause)
//    view.addSubview(timerLabel)
  }

  func setupConstraints() {
    NSLayoutConstraint.activate([
      gradientView.topAnchor.constraint(equalTo: view.topAnchor),
      gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

      playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      playButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -64),
      playButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 2 / 3),
      playButton.heightAnchor.constraint(equalToConstant: 80),

//      timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//      timerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
    ])
  }

  private func stopAllSoundsAndAnimations() {
    playerBG?.stop()
    playerTimer?.stop()
    bombSoundPlayer?.stop()
    bombShortImageView.layer.removeAllAnimations()
    bombLongImageView.layer.removeAllAnimations()
    gameTimer?.cancel()
    gameTimer = nil
  }

  private func addRightNavButton() {
    let rightBarButton = UIBarButtonItem(image: normalImage, style: .plain, target: self, action: #selector(pauseButtonPressed))
    navigationItem.rightBarButtonItem = rightBarButton
  }

  //MARK: State of game
  @objc func playButtonPressed() {
      if gameState == .idle || gameState == .paused {
          if shouldUpdateQuestion {
              let randomIndex = Int.random(in: 0..<questions.count)
              let currentQuestion = questions[randomIndex]
              UserDefaults.standard.set(currentQuestion, forKey: "currentQuestion")
              textLabel.text = currentQuestion
          }
          playButton.isHidden = true
          gameState = .playing
          startGameTimer()
          playBGSound()
          playTimerSound()
          startGIFLoop()
      }
  }

  @objc private func pauseButtonPressed() {
    if gameState == .playing {
      pauseGame()
    } else if gameState == .paused {
      resumeGame()
    }
  }

  private func pauseGame() {
    gameState = .paused
    playerBG?.pause()
    playerTimer?.pause()
    bombSoundPlayer?.pause()
    gameTimer?.suspend()
    gamePausedTime = Date()
    timerPausedTime = playerTimer?.currentTime ?? 0
    remainingTime -= Date().timeIntervalSince(gamePausedTime ?? Date())

    bombShortImageView.layer.pauseAnimation()
    bombLongImageView.layer.pauseAnimation()
    textLabel.isHidden = true
    playButton.isHidden = true
    bombShortImageView.isHidden = true
    bombLongImageView.isHidden = true
    textLabelPause.isHidden = false
    navigationItem.rightBarButtonItem?.image = pressedImage
  }

  private func resumeGame() {
    gameState = .playing
    playerBG?.play()
    playerTimer?.play()
    gameTimer?.resume()

    let timeElapsed = Date().timeIntervalSince(gamePausedTime ?? Date())
    if let pausedTime = timerPausedTime {
      playerTimer?.currentTime = pausedTime + timeElapsed
      timerPausedTime = nil
    }
    if let bombSoundPlayer = bombSoundPlayer, !bombSoundPlayer.isPlaying {
      bombSoundPlayer.play()
    }

    bombShortImageView.layer.resumeAnimation()
    bombLongImageView.layer.resumeAnimation()
    textLabel.isHidden = false
    playButton.isHidden = true
    bombShortImageView.isHidden = false
    bombLongImageView.isHidden = false
    textLabelPause.isHidden = true
    navigationItem.rightBarButtonItem?.image = normalImage
  }

  //MARK: Play video

   func setupGIFs() {

    guard let bombShortGIF = UIImageView.gifImageWithName(frame: CGRect(x: 0, y: 0, width: 70, height: 70) , resourceName: "bombShort") else {
      fatalError("Failed to load bombShort.gif")
    }

    guard let bombLongGIF = UIImageView.gifImageWithName(frame: CGRect(x: 0, y: 0, width: 70, height: 70), resourceName: "bombLong") else {
      fatalError("Failed to load bombLong.gif")
    }

    bombShortImageView = bombShortGIF
    bombShortImageView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(bombShortImageView)
    NSLayoutConstraint.activate([
      bombShortImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      bombShortImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50)
    ])

    bombLongImageView = bombLongGIF
    bombLongImageView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(bombLongImageView)
    NSLayoutConstraint.activate([
      bombLongImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      bombLongImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50)
    ])
    bombLongImageView.isHidden = true
  }

  private func startGIFLoop() {
    bombShortImageView.startAnimating()
    let timeUntilLongGIF: TimeInterval = remainingTime - 0.9
    let deadline = DispatchTime.now() + timeUntilLongGIF
    DispatchQueue.global().asyncAfter(deadline: deadline) { [weak self] in
      DispatchQueue.main.async {
        self?.switchToLongGIF()
      }
    }
  }

  @objc private func switchToLongGIF() {
    guard gameState == .playing else {
      return
    }
    bombShortImageView.isHidden = true
    bombLongImageView.isHidden = false
    bombLongImageView.startAnimating()
    let longGIFDuration: TimeInterval = 0.9
    let deadline = DispatchTime.now() + longGIFDuration
    self.playBombSound()
    DispatchQueue.global().asyncAfter(deadline: deadline) { [weak self] in
      DispatchQueue.main.async {
        self?.stopGIFLoop()
        let gameVC = GameEndViewController()
        self?.navigationController?.pushViewController(gameVC, animated: true)
      }
    }
  }

  @objc private func stopGIFLoop() {
    bombLongImageView.isHidden = true
    bombShortImageView.isHidden = true
    playButton.isEnabled = true
  }

  private func startGameTimer() {
    remainingTime = gameDuration
    gameTimer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
    gameTimer?.schedule(deadline: .now(), repeating: .seconds(1))
    gameTimer?.setEventHandler { [weak self] in
      DispatchQueue.main.async {
        self?.gameDuration -= 1
        self?.timerLabel.text = "\(self?.gameDuration ?? 0) сек"
        if self?.gameDuration == 0 {
          self?.endGame()
        }
      }
    }
    gameTimer?.resume()
  }

  //MARK: Play sound

  private func playBGSound() {
      if UserDefaultsManager.shared.musicSwitchState {
          let audioFileName = UserDefaultsManager.shared.fonMusic
          if let soundPath = Bundle.main.url(forResource: audioFileName, withExtension: "mp3") {
              do {
                  playerBG = try AVAudioPlayer(contentsOf: soundPath)
                  playerBG?.numberOfLoops = -1
                  playerBG?.volume = 0.5
                  playerBG?.prepareToPlay()
              } catch {
                  print("Ошибка создания цикла \(error)")
              }
          }
          playerBG!.play()
          DispatchQueue.main.asyncAfter(deadline: .now() + gameDuration) {
              self.playerBG!.stop()
          }
      }
  }

  private func playTimerSound() {
    DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
           let audioFileName = UserDefaultsManager.shared.timerMusic
           if let soundPath = Bundle.main.url(forResource: audioFileName, withExtension: "mp3"),
              let remainingTime = self?.remainingTime {
               do {
          self?.playerTimer = try AVAudioPlayer(contentsOf: soundPath)
          self?.playerTimer?.numberOfLoops = -1
          self?.playerTimer?.prepareToPlay()

          self?.playerTimer?.play()
          DispatchQueue.main.asyncAfter(deadline: .now() + remainingTime) { [weak self] in
            self?.playerTimer?.stop()
          }
        } catch {
          print("Ошибка создания цикла \(error)")
        }
      }
    }
  }

  private func playBombSound() {
    let audioFileName = UserDefaultsManager.shared.explosionMusic
    if let additionalSoundPath = Bundle.main.url(forResource: audioFileName, withExtension: "mp3") {
      do {
        bombSoundPlayer = try AVAudioPlayer(contentsOf: additionalSoundPath)
        bombSoundPlayer?.delegate = self
        bombSoundPlayer?.prepareToPlay()
        bombSoundPlayer?.play()
      } catch {
        print("Ошибка создания дополнительного звука \(error)")
      }
    }
  }

  private func endGame() {
    gameTimer?.cancel()
    gameTimer = nil
    playerTimer = nil
  }
}
