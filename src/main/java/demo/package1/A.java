package demo.package1;

import demo.package2.B;

public class A {

    public void a1() {
        System.out.println("method a1 called");
        new B().b1();
        // for going to b1() definition:
        // yank word b1
        // Ctrl-\ g
        // for going back
        // Ctrl-t
    }

    public static void main(String[] args) {
        new A().a1();
    }

}
