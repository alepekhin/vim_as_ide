package snake;

import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.StackPane;
import javafx.scene.input.KeyEvent;
import javafx.scene.input.KeyCode;
import javafx.scene.text.Font;
import javafx.stage.Stage;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import java.awt.Point;

import javafx.application.Platform;

/**
 * Приложение JavaFX
 */
public class SnakeGame extends Application implements Runnable {

    private Snake snake;
    private Food food;
    private Board board;
    private KeyCode direction;

    private static final long PAUSE_MS = 200;

    @Override
    public void start(Stage stage) {
        stage.setTitle("Snake game");
        GridPane grid = new GridPane(); // грид для доски
        Label label = new Label(); // покажем в конце как Game over
        label.setFont(new Font(40));
        // root StackPane, see https://fxdocs.github.io/docs/html5/#_overview
        StackPane root = new StackPane(grid, label);
        Scene scene = new Scene(root);
        stage.setScene(scene);
        // создаем доску и больше ее не меняем
        board = new Board();
        board.addToGrid(grid);
        // создаем игру
        initGame(grid, label);
        // add key listener
        scene.addEventHandler(KeyEvent.KEY_RELEASED,  t -> {
            switch (t.getCode()) {
                case KeyCode.UP:
                case KeyCode.DOWN:
                case KeyCode.LEFT:
                case KeyCode.RIGHT:
                    direction = t.getCode();
                    break;
                case KeyCode.SPACE:
                    initGame(grid, label);
            }
        });
        // catch exception from another thread
        Thread.setDefaultUncaughtExceptionHandler((th, throwable) -> {
            System.out.println(throwable);
            label.setVisible(true);
            // Update label text on JavaFX Application Thread
            Platform.runLater(() -> {
                label.setText(throwable.getMessage());
                stage.setTitle("Snake size " + snake.getSize());
            });
        });
        // show game
        stage.show();
    }

    private void initGame(GridPane grid, Label label) {
        direction = null;
        label.setVisible(false);
        // start another thread в котором двигаем змейку
        Thread thread = new Thread(this);
        thread.setDaemon(true); // дочерний поток будет завершаться вместе с основным
        thread.start();
        // prepare game
        board.drow();
        snake = new Snake();
        snake.drowHead(board);
        snake.drowTail(board);
        if (food != null) {
            food.clean(board);
        }
        createAndDrowFood();
    }

    private void createAndDrowFood() {
        food = new Food();
        // еда не должна быть на змейке
        while ( snake.contains(food.getPoint())) {
            food = new Food();
        }
        food.drow(board);
    }

    public void run() {
        while (true) {
            if (direction != null) {
                Point tail = snake.getTail(); // tail before move
                snake.move(direction);
                if (snake.getHead().equals(food.getPoint())) {
                    // съели еду, надо новую
                    createAndDrowFood();
                    // хвост не стираем
                } else {
                    // тут стираем
                    snake.removeTail();
                    board.getCell(tail.x, tail.y).setFill(Board.BG_COLOR);
                }
                // drow new head
                snake.drowHead(board);
            }
            try {
                Thread.sleep(PAUSE_MS);
            } catch (Exception e)  {
                // ignore
            }
        }


    }

}
