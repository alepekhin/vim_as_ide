package snake;

import javafx.scene.paint.Color;
import java.util.Deque;
import java.util.LinkedList;
import javafx.scene.input.KeyCode;
import java.awt.Point;

/**
 * Змейка
 * Знает про доску
 */
public class Snake {

    private Deque<Point> body = new LinkedList<>();

    public static final Color SNAKE_COLOR = Color.GREEN;

    public Snake() {
        body.addFirst(new Point(Board.COL_NUM / 2, Board.ROW_NUM / 2));
        body.addLast(new Point(Board.COL_NUM / 2, Board.ROW_NUM / 2 - 1));
    }

   /**
     * Перемещение змейки на одну клетку
     * Возвращает true если съедена еда
     */
    public void move(KeyCode direction) {
        Point head = body.getFirst();
        Point newPoint = null;
        switch (direction) {
            case UP -> newPoint = new Point(head.x, head.y - 1);
            case DOWN -> newPoint = new Point(head.x, head.y + 1);
            case LEFT -> newPoint = new Point(head.x - 1, head.y);
            case RIGHT -> newPoint = new Point(head.x + 1, head.y);
        }
        validate(newPoint);
        body.addFirst(newPoint);
        // что делать с хвостом будет решено в другом месте
    }

    public int getSize() {
        return body.size();
    }

    public boolean contains(Point point) {
        return body.contains(point);
    }

    public Point getHead() {
        return body.getFirst();
    }

    public Point getTail() {
        return body.getLast();
    }

    public void removeTail() {
        body.removeLast();
    }

    public void drawHead(Board board) {
        board.setCellFill(body.getFirst().x, body.getFirst().y, SNAKE_COLOR);
    }

    public void drawTail(Board board) {
        board.setCellFill(body.getLast().x, body.getLast().y, SNAKE_COLOR);
    }

    private void validate(Point newPoint) {
        if  (newPoint.x < 0 || newPoint.y < 0
                || newPoint.x >= Board.COL_NUM || newPoint.y >= Board.ROW_NUM
                || body.contains(newPoint)) {
            throw new IllegalStateException("Game over. Press space");
        }
    }

}
