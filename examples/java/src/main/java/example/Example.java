package example;

import java.util.*;
import java.util.concurrent.*;

/**
 * Class Documentation
 *
 * @author Alex
 */
class Example {

    static List<Printable> list = List.of(new Book("book1"), new Book("book2"), new Magazine("mag1"));

    void test() {
        CompletableFuture.runAsync(() -> list.forEach(Printable::print));
    }

        public static void main(String[] args) {
            list.stream().forEach(Printable::print);
    }
}
