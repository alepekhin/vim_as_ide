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

    public void draw(Board board) {
        board.setCellFill(point.x, point.y, FOOD_COLOR);
    }

    public void clean(Board board) {
        board.clearCell(point.x, point.y);
        point = null;
    }

}
