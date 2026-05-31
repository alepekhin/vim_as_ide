package snake;

import java.util.LinkedList;
import java.util.List;

/**
 * Логика змейки: движение, столкновения, тело.
 */
public class Snake {

    private final LinkedList<Point> body;
    private final int width;
    private final int height;

    public Snake(int width, int height) {
        this.width = width;
        this.height = height;
        this.body = new LinkedList<>();

        int startX = width / 2;
        int startY = height / 2;

        for (int i = 0; i < 3; i++) {
            body.add(new Point(startX - i, startY));
        }
    }

    public List<Point> getBody() {
        return body;
    }

    public Point getHead() {
        return body.getFirst();
    }

    /**
     * Перемещает змейку в указанном направлении.
     *
     * @param direction    направление движения
     * @param foodPosition позиция еды
     * @return true, если еда была съедена
     * @throws IllegalStateException при столкновении со стеной или самой собой
     */
    public boolean move(Direction direction, Point foodPosition) {
        Point head = body.getFirst();
        Point newHead = new Point(head);

        switch (direction) {
            case UP:
                newHead.y--;
                break;
            case DOWN:
                newHead.y++;
                break;
            case LEFT:
                newHead.x--;
                break;
            case RIGHT:
                newHead.x++;
                break;
        }

        // Проверка столкновения со стеной
        if (newHead.x < 0 || newHead.x >= width || newHead.y < 0 || newHead.y >= height) {
            throw new IllegalStateException("Game over. Press space");
        }

        body.addFirst(newHead);

        boolean foodEaten = newHead.equals(foodPosition);
        if (!foodEaten) {
            body.removeLast();
        }

        // Проверка столкновения с собственным телом
        for (int i = 1; i < body.size(); i++) {
            if (body.get(i).equals(newHead)) {
                throw new IllegalStateException("Game over. Press space");
            }
        }

        return foodEaten;
    }
}
