package example;

import java.util.ArrayList;
import java.util.List;

/**
 * Class Documentation
 * 
 * @author Alex
 */
class Example {

    int a = 0;

    void dummy(int x) {
        List<String> s = new ArrayList<>();
        int kw = 0;
        //s   // autocompletion works here, just print .
        s.add("");
        a = a + 1;
    }

    void another() {
        dummy(2);
    }
}
