package com.example;

/**
 * Concrete implementation of ExampleService.
 * @author demo
 */
public class ExampleServiceImpl implements ExampleService {

    private String name;
    private int version;
    private boolean initialized;

    /**
     * Default constructor.
     */
    public ExampleServiceImpl() {
        super();
    }

    /**
     * Initialize the service.
     * @param config the configuration
     * @return true if successful
     */
    @Override
    public boolean initialize(ServiceConfig config) {
        this.name = config.getName();
        this.version = 1;
        this.initialized = true;
        System.out.println("Service " + this.name + " initialized");
        return this.initialized;
    }

    /**
     * Get the service name.
     * @return the name
     */
    @Override
    public String getName() {
        return this.name;
    }

    /**
     * Get the service version.
     * @return the version string
     */
    @Override
    public String getVersion() {
        return Integer.toString(this.version);
    }

    /**
     * Shutdown the service.
     */
    @Override
    public void shutdown() {
        if (this.initialized) {
            System.out.println("Service " + this.name + " shut down");
            this.initialized = false;
        }
    }
}
