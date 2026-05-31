package snake;

import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.StackPane;
import javafx.scene.text.Font;
import javafx.stage.Stage;
import javafx.util.Duration;

import java.awt.Point;

/**
 * Главный класс JavaFX-приложения с игрой "Змейка".
 * <p>
 * Игра реализована с использованием стандартного паттерна {@link Application}.
 * Игровой цикл выполняется через {@link Timeline} ({@code javafx.animation}),
 * который строго работает на JavaFX Application Thread. Это исключает
 * классические проблемы многопоточности:
 * <ul>
 *   <li>гонки данных при чтении/записи направления движения;</li>
 *   <li>попытки изменять UI со стороны фонового потока;</li>
 *   <li>утечку старых потоков при перезапуске игры.</li>
 * </ul>
 *
 * <p><b>Управление:</b>
 * <table border="1">
 *   <tr><th>Клавиша</th><th>Действие</th></tr>
 *   <tr><td>↑ ↓ ← →</td><td>Смена направления движения</td></tr>
 *   <tr><td>Пробел</td><td>Перезапуск после Game Over</td></tr>
 * </table>
 *
 * @see Snake
 * @see Board
 * @see Food
 */
public class SnakeGame extends Application {

    /**
     * Длительность одного игрового такта в миллисекундах.
     * Чем меньше значение, тем быстрее двигается змейка.
     */
    private static final long PAUSE_MS = 200;

    /**
     * Размер шрифта надписи "Game over", отображаемой поверх доски.
     */
    private static final double GAME_OVER_FONT_SIZE = 40.0;

    /**
     * Максимальное количество попыток случайного размещения еды,
     * чтобы избежать бесконечного цикла в крайнем случае
     * (например, когда змейка заняла почти всё поле).
     */
    private static final int MAX_FOOD_ATTEMPTS = 10_000;

    // ========== Игровые объекты ==========

    /** Экземпляр змейки. Создаётся заново при каждом перезапуске. */
    private Snake snake;

    /** Текущая еда на поле. Пересоздаётся после каждого поедания. */
    private Food food;

    /** Игровое поле — сетка прямоугольников {@code Rectangle[COL_NUM][ROW_NUM]}. */
    private Board board;

    /**
     * Текущее направление движения змейки.
     * {@code null} означает, что пользователь ещё не нажал ни одну стрелку
     * после старта или перезапуска игры.
     */
    private KeyCode direction;

    // ========== Состояние игры и UI ==========

    /**
     * Анимационный таймер, представляющий собой игровой цикл.
     * Хранится в поле, чтобы можно было остановить его при Game Over
     * или при закрытии приложения.
     */
    private Timeline gameLoop;

    /** Флаг окончания текущей партии. Когда {@code true} — клавиши-стрелки игнорируются. */
    private boolean gameOver;

    /** Метка, отображающая текст "Game over. Press space" после поражения. */
    private Label gameOverLabel;

    /** Основное окно приложения. Нужно для обновления заголовка при Game Over. */
    private Stage stage;

    /**
     * Точка входа в JavaFX-приложение.
     * <p>
     * Инициализирует сцену, создаёт доску, подключает обработчик клавиатуры
     * и запускает первую партию методом {@link #initGame()}.
     *
     * @param primaryStage основная сцена, предоставленная JavaFX
     */
    @Override
    public void start(Stage primaryStage) {
        this.stage = primaryStage;
        stage.setTitle("Snake game");

        // GridPane используется для управления расположением ячеек доски
        GridPane grid = new GridPane();
        gameOverLabel = createGameOverLabel();

        // StackPane позволяет накладывать Label поверх игрового поля
        StackPane root = new StackPane(grid, gameOverLabel);
        Scene scene = new Scene(root);

        // Доска независима от логики: отвечает только за визуальное представление
        board = new Board();
        board.addToGrid(grid);

        // Обработчик нажатий клавиш — работает на JavaFX Application Thread
        scene.addEventHandler(KeyEvent.KEY_RELEASED, this::handleKeyReleased);

        stage.setScene(scene);
        stage.show();

        // Запускаем первую игру сразу после отображения окна
        initGame();
    }

    /**
     * Создаёт Label для отображения Game Over.
     * Изначально невидим; показывается только при завершении партии.
     *
     * @return настроенная, но скрытая метка
     */
    private Label createGameOverLabel() {
        Label label = new Label();
        label.setFont(new Font(GAME_OVER_FONT_SIZE));
        label.setVisible(false);
        return label;
    }

    /**
     * Обрабатывает отпускание клавиши.
     * <p>
     * Логика разделена на два режима:
     * <ol>
     *   <li><b>Игра активна</b> ({@code gameOver == false}):
     *       стрелки меняют направление движения.</li>
     *   <li><b>Игра окончена</b> ({@code gameOver == true}):
     *       только {@code SPACE} вызывает перезапуск.</li>
     * </ol>
     *
     * @param event событие клавиатуры
     */
    private void handleKeyReleased(KeyEvent event) {
        KeyCode code = event.getCode();
        switch (code) {
            case UP:
            case DOWN:
            case LEFT:
            case RIGHT:
                // Игнорируем смену направления после столкновения,
                // пока пользователь не перезапустит игру
                if (!gameOver) {
                    direction = code;
                }
                break;
            case SPACE:
                // Перезапуск возможен только после Game Over.
                // Если нажать SPACE во время игры — ничего не произойдёт
                if (gameOver) {
                    initGame();
                }
                break;
            default:
                // Прочие клавиши игнорируются, чтобы не мешать игровому процессу
        }
    }

    /**
     * Инициализирует (или переинициализирует) игровое состояние.
     * <p>
     * Выполняет следующие операции в строго определённом порядке:
     * <ol>
     *   <li>Останавливает старый {@link #gameLoop}, если он существует.</li>
     *   <li>Сбрасывает флаги и счётчики.</li>
     *   <li>Очищает доску и размещает змейку в начальной позиции.</li>
     *   <li>Генерирует первую еду.</li>
     *   <li>Создаёт и запускает новый {@link Timeline}.</li>
     * </ol>
     *
     * <p><b>Важно:</b> старый игровой цикл обязательно останавливается до
     * создания нового, иначе может возникнуть ситуация, когда два цикла
     * одновременно обращаются к общему состоянию.
     */
    private void initGame() {
        stopGameLoop();
        gameOver = false;
        direction = null; // ждём первого нажатия стрелки или авто-старт
        gameOverLabel.setVisible(false);

        // Перерисовываем доску в начальном состоянии — все ячейки фоновым цветом
        board.clear();

        // Змейка начинает из центра доски: голова + один сегмент хвоста
        snake = new Snake();
        snake.drawHead(board);
        snake.drawTail(board);

        // Убираем остатки старой еды, если она ещё отображается на доске
        if (food != null) {
            food.clean(board);
        }
        createAndDrawFood();

        // Создаём Timeline с одним KeyFrame, который вызывает tick() каждые PAUSE_MS мс
        gameLoop = new Timeline(new KeyFrame(Duration.millis(PAUSE_MS), e -> tick()));
        gameLoop.setCycleCount(Timeline.INDEFINITE);
        gameLoop.play();
    }

    /**
     * Корректно останавливает и обнуляет текущий игровой цикл.
     * Безопасно вызывать даже если цикл ещё не создан.
     */
    private void stopGameLoop() {
        if (gameLoop != null) {
            gameLoop.stop();
            gameLoop = null;
        }
    }

    /**
     * Создаёт новую еду и отображает её на доске.
     * <p>
     * Еда не должна появляться на теле змейки.
     * Вместо бесконечного цикла используется счётчик попыток
     * ({@link #MAX_FOOD_ATTEMPTS}).
     * <p>
     * Если змейка заняла всё поле (условная "победа"), метод завершается
     * без создания еды — следующий tick вызовет Game Over при попытке
     * двинуться, потому что любое направление приведёт к столкновению с собой.
     */
    private void createAndDrawFood() {
        int totalCells = Board.COL_NUM * Board.ROW_NUM;
        if (snake.getSize() >= totalCells) {
            // Доска полностью заполнена змейкой — условная победа
            return;
        }

        int attempts = 0;
        do {
            food = new Food();
            attempts++;
        } while (snake.contains(food.getPoint()) && attempts < MAX_FOOD_ATTEMPTS);

        food.draw(board);
    }

    /**
     * Один игровой такт.
     * <p>
     * Вызывается {@link Timeline} каждые {@link #PAUSE_MS} миллисекунд.
     * На каждом такте выполняется:
     * <ol>
     *   <li>Проверка состояния {@code gameOver} — если игра окончена, выходим.</li>
     *   <li>Если направление не задано, используем значение по умолчанию
     *       ({@code KeyCode.DOWN}), чтобы змейка начала двигаться сразу.</li>
     *   <li>Запоминаем позицию хвоста <i>перед</i> движением.</li>
     *   <li>Вызываем {@link Snake#move(KeyCode)} для перемещения головы.</li>
     *   <li>Проверяем, совпала ли новая позиция головы с едой:
     *       <ul>
     *         <li>если да — создаём новую еду, хвост не стираем (змейка растёт);</li>
     *         <li>если нет — удаляем последний сегмент хвоста и закрашиваем
     *             его старую ячейку фоновым цветом.</li>
     *       </ul>
     *   </li>
     *   <li>Перекрашиваем новую голову змейки.</li>
     * </ol>
     *
     * <p>Любая ошибка (столкновение со стеной или с собой) ловится
     * как {@link IllegalStateException}, после чего управление передаётся
     * {@link #handleGameOver(String)}.
     */
    private void tick() {
        if (gameOver) {
            return;
        }

        // Если игрок ещё не нажал ни одну стрелку — задаём начальное
        // направление движения вниз, чтобы игра не казалась "зависшей"
        if (direction == null) {
            direction = KeyCode.DOWN;
        }

        try {
            // Запоминаем координаты хвоста ДО сдвига,
            // чтобы потом стереть их с доски
            Point tail = snake.getTail();

            // Перемещаем голову на одну клетку в текущем направлении.
            // При столкновении со стеной или с телом будет выброшено исключение.
            snake.move(direction);

            if (snake.getHead().equals(food.getPoint())) {
                // Голова змейки совпала с едой — змейка растёт,
                // поэтому хвост не удаляем и генерируем новую еду
                createAndDrawFood();
            } else {
                // Обычный шаг: удаляем хвост из модели и закрашиваем
                // соответствующую ячейку на доске
                snake.removeTail();
                board.clearCell(tail.x, tail.y);
            }

            // Отрисовываем новую голову (и потенциально новый хвост,
            // если змейка выросла — но тело уже зелёное от предыдущих ходов)
            snake.drawHead(board);
        } catch (IllegalStateException e) {
            // "Game over. Press space" — текст формируется в Snake.validate(...)
            handleGameOver(e.getMessage());
        }
    }

    /**
     * Обрабатывает завершение партии.
     * <p>
     * Устанавливает флаг {@code gameOver}, останавляет таймер,
     * показывает метку с поясняющим текстом и обновляет заголовок окна,
     * добавляя в него достигнутый размер змейки.
     *
     * @param message текст сообщения, обычно "Game over. Press space"
     */
    private void handleGameOver(String message) {
        gameOver = true;
        stopGameLoop();
        gameOverLabel.setText(message);
        gameOverLabel.setVisible(true);
        stage.setTitle("Snake size " + snake.getSize());
    }

    /**
     * Вызывается JavaFX при закрытии приложения (нажатие "крестика" в окне
     * или вызов {@code Platform.exit()}).
     * <p>
     * Гарантирует остановку {@link Timeline}, чтобы избежать попыток
     * обращения к уже уничтоженным UI-объектам.
     */
    @Override
    public void stop() {
        stopGameLoop();
    }

}
