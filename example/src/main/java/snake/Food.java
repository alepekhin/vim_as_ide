package snake;

import java.util.List;
import java.util.Random;

/**
 * Еда на игровом поле.
 */
public class Food {

    private final int colNum;
    private final int rowNum;
    private final Random random;
    private Point position;

    public Food(int colNum, int rowNum, List<Point> snakeBody) {
        this.colNum = colNum;
        this.rowNum = rowNum;
        this.random = new Random();
        respawn(snakeBody);
    }

    public Point getPosition() {
        return position;
    }

    /**
     * Создает еду в новой случайной свободной клетке.
     *
     * @param snakeBody текущее тело змейки
     */
    public void respawn(List<Point> snakeBody) {
        do {
            int x = random.nextInt(colNum);
            int y = random.nextInt(rowNum);
            position = new Point(x, y);
        } while (snakeBody.contains(position));
    }
}
