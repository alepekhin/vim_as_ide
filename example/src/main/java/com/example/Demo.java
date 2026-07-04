package com.example;

/**
 * Demo class that exercises the Java LSP features.
 * 
 * ================== How to test Java Language Server features ==================
 * 
 * 1. **Autocomplete** — Place cursor after 'new ' and start typing.
 *    The language server should suggest: ExampleServiceImpl, ServiceConfig.
 * 
 * 2. **Go-to-definition** — Ctrl+Click (or Cmd+Click) on these symbols:
 *    - ExampleService
 *    - ExampleServiceImpl
 *    - ServiceConfig
 *    - getName()
 *    - initialize()
 * 
 * 3. **Find references** — Use "References" on:
 *    - ExampleService (should show usage in ExampleServiceImpl and Demo)
 *    - getName() (should show all calls in Demo)
 * 
 * 4. **Hover** — Hover over these to see Javadoc:
 *    - The ExampleService interface
 *    - getName()
 *    - initialize()
 * 
 * 5. **Diagnostics** — The language server provides real-time linting:
 *    - Fix "ServiceConfig not found" by selecting the error and pressing Quick Fix
 *    - It will insert the import statement automatically
 * 
 * 6. **Signature help** — Place cursor after method call and press Ctrl+Shift+Space:
 *    - Initialize: see 'initialize(ServiceConfig config)'
 *    - getName(): see 'String getName()'
 * 
 * 7. **Inlay hints** — Enable parameter name hints in settings:
 *    - Hover over method calls to see parameter names
 * 
 * 8. **Code actions** — Press Alt+Enter (or Cmd+Enter) on these:
 *    - Field 'name' → generate @Getter, toString(), equals(), hashCode()
 *    - Method 'initialize()' → add missing @Override (if not present)
 * 
 * 9. **Rename** — Select variable 'config' and choose "Rename Symbol":
 *    - The server will rename all occurrences in ExampleServiceImpl
 * 
 * 10. **Lombok** — Uncomment @Data and use @Builder:
 *    - Add @Data to ExampleServiceImpl
 *    - Add @Builder to generate builder pattern
 * 
 */
public class Demo {

    /**
     * Service reference (find references to this usage).
     */
    private static ExampleService service;

    /**
     * Main entry point.
     */
    public static void main(String[] args) {
        System.out.println("Example Java Language Server Demo");

        // Autocomplete test: place cursor here and type 'new '
        Demo demo = new Demo();

        // Initialize the example service
        demo.testCreate();

        demo.run();
    }

    /**
     * Test creating the service with different implementations.
     * Autocomplete: type 'new Ex' here to see suggestions.
     */
    private void testCreate() {
        // Autocomplete test: uncomment below to test go-to-definition on class
        // ExampleServiceImpl service = new ExampleServiceImpl();

        // Create service via interface with configuration
        service = new ExampleServiceImpl();

        ServiceConfig config = new ServiceConfig("MyService", 8080);

        // Signature help: hover here to see parameter info
        service.initialize(config);
    }

    /**
     * Run the service.
     */
    private void run() {
        System.out.println("Running service...");

        // Go-to-definition test: click on service.getName()
        String name = service.getName();
        String version = service.getVersion();

        System.out.println(name + " v." + version);

        // Find references test: this calls initialize()
        service.initialize(new ServiceConfig("Other", 9090));

        service.shutdown();
    }
}
