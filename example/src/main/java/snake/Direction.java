package snake;

/**
 * Направления движения змейки.
 */
public enum Direction {
    UP, DOWN, LEFT, RIGHT;

    public static Direction random() {
        double val = Math.random();
        if (val < 0.25) return UP;
        else if (val < 0.5) return DOWN;
        else if (val < 0.75) return LEFT;
        else return RIGHT;
    }
}
