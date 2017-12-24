import Foundation
import GameAnalytics

extension GameViewController: GameDelegate {

    func gameDidStart(_ game: Game) {
        gameAnalyticsStartEvent()
        tracker.trackGameStartEvent()
    }

    func game(_ game: Game, didInsertCircle circle: Circle, intoSlot slot: Slot) {
        slotView(forSlot: slot)?.circleView = CircleView(circle: circle)
    }

    func game(_ game: Game, didRemoveCircle circle: Circle, fromSlot slot: Slot) {
        slotView(forSlot: slot)?.circleView = nil
    }

    func gameOver(_ game: Game) {
        gameAnalyticsCompleteEventWithScore(game.scoreNumber)
        tracker.trackGameEndEvent(score: game.scoreNumber)
        synchronizeHighestScore()
        let viewController = GameOverViewController(score: game.scoreNumber, delegate: self, tracker: tracker)
        present(viewController, animated: true, completion: nil)
    }

    func gameDidUpdateScore(from: Int, to: Int) {
        guard let gameView = view as? GameView else { return }
        gameView.update(score: to)
        tracker.trackGameScoredEvent(scoredValue: to - from)
    }
    
    //跳转当score==100*level的时候
    func upLevel(number: Int) {
        gameAnalyticsCompleteEventWithScore(number)
        tracker.trackGameEndEvent(score: number)
        synchronizeHighestScore()
        let viewController = GameOverViewController(score: number, delegate: self, tracker: tracker)
        present(viewController, animated: true, completion: nil)
    }

    
    func gameDidPause() {
        guard presentedViewController == nil else { return }
        let menuViewController = MenuViewController(delegate: self, tracker: tracker)
        present(menuViewController, animated: true, completion: nil)
    }

    // MARK: Helpers

    private func slotView(forSlot slot: Slot) -> GameBoardSlotView? {
        guard let view = view as? GameView else { return nil }
        guard let boardView = view.boardView else { return nil }
        return boardView.slotViewAtLocation(column: slot.location.column, row: slot.location.row)
    }

}
