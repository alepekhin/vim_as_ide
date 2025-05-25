package example;

/**
 * Class of printable books
 */
class Book implements Printable {

    /**
     * Book name
     */
    String name;

    /**
     * Constructor
     */
    Book(String name) {
        this.name = name;
    }

    /**
     * print book as it is Printable
     */
    @Override
    public void print() {
        System.out.println(name);
    }

}
