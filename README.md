**Tree View Challenge**

**Description**

Tree View Challenge is a Flutter application designed to visualize and manage hierarchical asset data using a tree view. The app demonstrates effective use of state management, API integration, and user interface design, focusing on performance and usability.

**Features**

-   **Home Page**: Allows users to navigate between different companies and access their assets.
-   **Asset Page**: Displays a dynamic tree structure of assets, components, and locations.
    -   **Visualization**: Presents a hierarchical view of locations, assets, and components.
    -   **Filters**:
        -   **Text Search**: Search for specific items within the asset hierarchy.
        -   **Energy Sensors**: Filter to show only energy sensors.
        -   **Critical Sensor Status**: Filter to identify assets with critical sensor status.


        

**Project Structure**

bash

`lib/
  ├── data/
  │   ├── models/          # Data models for locations and assets
  │   ├── repositories/    # Implementations of data repositories
  │   └── datasources/     # Direct interactions with APIs
  ├── domain/
  │   ├── entities/        # Domain entities for locations and assets
  │   ├── repositories/    # Interfaces for data repositories
  │   └── usecases/        # Business logic use cases
  └── presentation/
      ├── pages/           # UI pages
      ├── viewmodels/      # State management and logic
      └── widgets/         # Reusable UI components`

