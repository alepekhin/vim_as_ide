package snake;

import javafx.scene.layout.GridPane;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;

import java.util.List;

/**
 * Игровое поле: сетка из прямоугольников.
 */
public class Board {

    public static final int COL_NUM = 22;
    public static final int ROW_NUM = 15;
    public static final int CELL_SIZE = 30;

    private final Rectangle[][] cells;
    private final GridPane grid;

    public Board() {
        grid = new GridPane();
        cells = new Rectangle[COL_NUM][ROW_NUM];

        for (int x = 0; x < COL_NUM; x++) {
            for (int y = 0; y < ROW_NUM; y++) {
                Rectangle rect = new Rectangle(CELL_SIZE, CELL_SIZE);
                rect.setFill(Color.BLACK);
                rect.setStroke(Color.DARKGRAY);
                cells[x][y] = rect;
                grid.add(rect, x, y);
            }
        }
    }

    public GridPane getGrid() {
        return grid;
    }

    /**
     * Очищает поле (устанавливает фоновый цвет).
     */
    public void clear() {
        for (int x = 0; x < COL_NUM; x++) {
            for (int y = 0; y < ROW_NUM; y++) {
                cells[x][y].setFill(Color.BLACK);
            }
        }
    }

    /**
     * Отрисовывает змейку.
     *
     * @param body тело змейки
     */
    public void drawSnake(List<Point> body) {
        for (Point p : body) {
            if (p.x >= 0 && p.x < COL_NUM && p.y >= 0 && p.y < ROW_NUM) {
                cells[p.x][p.y].setFill(Color.GREEN);
            }
        }
        if (!body.isEmpty()) {
            Point head = body.get(0);
            if (head.x >= 0 && head.x < COL_NUM && head.y >= 0 && head.y < ROW_NUM) {
                cells[head.x][head.y].setFill(Color.LIME);
            }
        }
    }

    /**
     * Отрисовывает еду.
     *
     * @param food позиция еды
     */
    public void drawFood(Point food) {
        if (food.x >= 0 && food.x < COL_NUM && food.y >= 0 && food.y < ROW_NUM) {
            cells[food.x][food.y].setFill(Color.RED);
        }
    }
}
