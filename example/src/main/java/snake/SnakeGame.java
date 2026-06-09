package snake;

import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.application.Application;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.StackPane;
import javafx.scene.paint.Color;
import javafx.scene.text.Font;
import javafx.stage.Stage;
import javafx.util.Duration;

/**
 * Основной класс приложения. Управляет игровым циклом и обработкой клавиш.
 */
public class SnakeGame extends Application {

    private static final int PAUSE_MS = 200;

    private Board board;
    private Snake snake;
    private Food food;
    private Direction direction = Direction.RIGHT;
    private Timeline timeline;
    private Label gameOverLabel;
    private boolean isGameOver = false;

    @Override
    public void start(Stage primaryStage) {
        StackPane root = new StackPane();

        board = new Board();
        GridPane grid = board.getGrid();
        root.getChildren().add(grid);

        gameOverLabel = new Label();
        gameOverLabel.setFont(new Font("Arial", 36));
        gameOverLabel.setTextFill(Color.WHITE);
        gameOverLabel.setVisible(false);
        root.getChildren().add(gameOverLabel);
        StackPane.setAlignment(gameOverLabel, Pos.CENTER);

        Scene scene = new Scene(root);
        scene.addEventHandler(KeyEvent.KEY_PRESSED, this::handleKey);

        primaryStage.setTitle("Змейка");
        primaryStage.setScene(scene);
        primaryStage.setResizable(false);
        primaryStage.show();

        initGame();
    }

    /**
     * Инициализирует новую игру.
     */
    private void initGame() {
        if (timeline != null) {
            timeline.stop();
        }

        isGameOver = false;
        direction = Direction.random();
        gameOverLabel.setVisible(false);

        board.clear();
        snake = new Snake(Board.COL_NUM, Board.ROW_NUM);
        food = new Food(Board.COL_NUM, Board.ROW_NUM, snake.getBody());

        board.drawSnake(snake.getBody());
        board.drawFood(food.getPosition());

        timeline = new Timeline(new KeyFrame(Duration.millis(PAUSE_MS), e -> tick()));
        timeline.setCycleCount(Timeline.INDEFINITE);
        timeline.play();
    }

    /**
     * Один такт игрового цикла.
     */
    private void tick() {
        if (isGameOver) {
            return;
        }

        try {
            boolean foodEaten = snake.move(direction, food.getPosition());
            if (foodEaten) {
                food.respawn(snake.getBody());
            }
        } catch (IllegalStateException e) {
            isGameOver = true;
            gameOverLabel.setText("Game over. Press space");
            gameOverLabel.setVisible(true);
            timeline.stop();
            return;
        }

        board.clear();
        board.drawSnake(snake.getBody());
        board.drawFood(food.getPosition());
    }

    /**
     * Обрабатывает нажатия клавиш.
     *
     * @param event событие клавиатуры
     */
    private void handleKey(KeyEvent event) {
        KeyCode code = event.getCode();

        if (isGameOver && code == KeyCode.SPACE) {
            initGame();
            return;
        }

        if (isGameOver) {
            return;
        }

        switch (code) {
            case UP:
                if (direction != Direction.DOWN) {
                    direction = Direction.UP;
                }
                break;
            case DOWN:
                if (direction != Direction.UP) {
                    direction = Direction.DOWN;
                }
                break;
            case LEFT:
                if (direction != Direction.RIGHT) {
                    direction = Direction.LEFT;
                }
                break;
            case RIGHT:
                if (direction != Direction.LEFT) {
                    direction = Direction.RIGHT;
                }
                break;
            default:
                break;
        }
    }
}
