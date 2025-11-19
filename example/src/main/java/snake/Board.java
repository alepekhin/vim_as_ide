package snake;

import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import javafx.scene.layout.GridPane;

/**
 * Доска состоящая из квадратиков на которой идет игра
 * Доска не знает, что на ней поставлено
 */
public class Board {

    private Rectangle[][] board;

    public static final int ROW_NUM = 15;
    public static final int COL_NUM = 22;
    public static final Color BG_COLOR = Color.LIGHTBLUE;

    private static final int CELL_SIZE = 30;
    private static final int BORDER_WIFTH = 1;
    private static final Color BORDER_COLOR = Color.BLACK;

    public Board() {
        board = new Rectangle[COL_NUM][ROW_NUM];
        for (int x = 0; x < COL_NUM; x++) {
            for (int y = 0; y < ROW_NUM; y++) {
                var rectangle = new Rectangle(CELL_SIZE, CELL_SIZE);
                rectangle.setFill(BG_COLOR);
                rectangle.setStroke(BORDER_COLOR);
                rectangle.setStrokeWidth(BORDER_WIFTH);
                board[x][y] = rectangle;
            }
        }
    }

    public Rectangle getCell(int x, int y) {
        return board[x][y];
    }

    public void drow() {
        for (int x = 0; x < COL_NUM; x++) {
            for (int y = 0; y < ROW_NUM; y++) {
                board[x][y].setFill(BG_COLOR);
            }
        }
    }

    public void addToGrid(GridPane grid) {
        for (int y = 0; y < Board.ROW_NUM; y++) {
            for (int x = 0; x < Board.COL_NUM; x++) {
                grid.add(board[x][y], x, y);
            }
        }
    }


}
