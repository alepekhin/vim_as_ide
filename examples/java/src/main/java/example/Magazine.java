package example;

class Magazine implements Printable {

    String name;

    Magazine(String name) {
        this.name = name;
    }

    @Override
    public void print() {
        System.out.println(name);
    }

}
