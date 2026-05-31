package snake;

import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;
import javafx.scene.layout.GridPane;

/**
 * Доска, состоящая из квадратиков, на которой идет игра.
 * Доска не знает, что на ней поставлено.
 */
public class Board {

    private final Rectangle[][] board;

    public static final int ROW_NUM = 15;
    public static final int COL_NUM = 22;
    public static final Color BG_COLOR = Color.LIGHTBLUE;

    private static final int CELL_SIZE = 30;
    private static final int BORDER_WIDTH = 1;
    private static final Color BORDER_COLOR = Color.BLACK;

    public Board() {
        board = new Rectangle[COL_NUM][ROW_NUM];
        for (int x = 0; x < COL_NUM; x++) {
            for (int y = 0; y < ROW_NUM; y++) {
                var rectangle = new Rectangle(CELL_SIZE, CELL_SIZE);
                rectangle.setFill(BG_COLOR);
                rectangle.setStroke(BORDER_COLOR);
                rectangle.setStrokeWidth(BORDER_WIDTH);
                board[x][y] = rectangle;
            }
        }
    }

    /**
     * Возвращает ячейку по координатам.
     *
     * @param x координата по горизонтали
     * @param y координата по вертикали
     * @return {@link Rectangle}, расположенный в указанной ячейке
     * @throws IllegalArgumentException если координаты выходят за границы доски
     */
    public Rectangle getCell(int x, int y) {
        if (x < 0 || x >= COL_NUM || y < 0 || y >= ROW_NUM) {
            throw new IllegalArgumentException(
                    "Cell (" + x + "," + y + ") is outside the board (" + COL_NUM + "x" + ROW_NUM + ")");
        }
        return board[x][y];
    }

    /**
     * Устанавливает цвет заливки указанной ячейки.
     *
     * @param x     координата по горизонтали
     * @param y     координата по вертикали
     * @param color цвет заливки
     */
    public void setCellFill(int x, int y, Color color) {
        if (x < 0 || x >= COL_NUM || y < 0 || y >= ROW_NUM) {
            throw new IllegalArgumentException(
                    "Cell (" + x + "," + y + ") is outside the board (" + COL_NUM + "x" + ROW_NUM + ")");
        }
        board[x][y].setFill(color);
    }

    /**
     * Сбрасывает цвет заливки указанной ячейки на фоновый.
     *
     * @param x координата по горизонтали
     * @param y координата по вертикали
     */
    public void clearCell(int x, int y) {
        setCellFill(x, y, BG_COLOR);
    }

    /**
     * Очищает всю доску, устанавливая фоновый цвет во все ячейки.
     */
    public void clear() {
        for (int x = 0; x < COL_NUM; x++) {
            for (int y = 0; y < ROW_NUM; y++) {
                board[x][y].setFill(BG_COLOR);
            }
        }
    }

    /**
     * Добавляет все ячейки доски в указанный {@link GridPane}.
     *
     * @param grid панель, в которую будут добавлены ячейки
     */
    public void addToGrid(GridPane grid) {
        for (int x = 0; x < COL_NUM; x++) {
            for (int y = 0; y < ROW_NUM; y++) {
                grid.add(board[x][y], x, y);
            }
        }
    }

}
