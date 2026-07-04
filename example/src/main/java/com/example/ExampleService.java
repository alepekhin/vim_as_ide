package com.example;

/**
 * Service interface that defines the core contract.
 * 
 * Autocomplete: Type 'new ' and see ExampleServiceImpl suggested
 * Go-to-definition: Ctrl+Click on this interface
 * Find references: Find all references to this interface name
 */
public interface ExampleService {

    /**
     * Get the service name.
     * Hover here to see Javadoc documentation
     * @return the service name
     */
    String getName();

    /**
     * Get the service version.
     * @return the version string
     */
    String getVersion();

    /**
     * Initialize the service.
     * Signature help: Hover here to see parameter name hints
     * @param config the service configuration
     * @return true if initialization succeeded
     */
    boolean initialize(ServiceConfig config);

    /**
     * Shutdown the service.
     */
    void shutdown();
}
