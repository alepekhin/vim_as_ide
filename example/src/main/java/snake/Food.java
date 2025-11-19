package snake;

import javafx.scene.paint.Color;
import java.util.Random;
import java.awt.Point;

/**
 * Еда, появляющаяся в случайной точке
 * Знает про доску
 */
public class Food {

    private Point point;
    private Random random = new Random();

    public static final Color FOOD_COLOR = Color.RED;

    public Food() {
        point = new Point(random.nextInt(Board.COL_NUM), random.nextInt(Board.ROW_NUM));
    }

    /**
     * Точка, где находится еда
     */
    public Point getPoint() {
        return point;
    }

    public void drow(Board board) {
        board.getCell(point.x, point.y).setFill(FOOD_COLOR);
    }

    public void clean(Board board) {
        board.getCell(point.x, point.y).setFill(Board.BG_COLOR);
        point = null;
    }

}
