package com.example;

/**
 * Configuration class for ExampleService.
 * Rename this: Test rename refactoring feature
 */
public class ServiceConfig {

    private String name;
    private int port;

    /**
     * Construct a ServiceConfig.
     * @param name the name
     * @param port the port number
     */
    public ServiceConfig(String name, int port) {
        this.name = name;
        this.port = port;
    }

    /**
     * Get the name.
     * Find references to this method across workspace
     * @return the service name
     */
    public String getName() {
        return name;
    }

    /**
     * Get the port.
     * @return the port number
     */
    public int getPort() {
        return port;
    }

    /**
     * Override toString for debugging.
     * @return the formatted config string
     */
    @Override
    public String toString() {
        return "ServiceConfig{name='" + name + "', port=" + port + "}";
    }
}
