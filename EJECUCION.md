## Ejecución rápida de la app

Esta app se puede ejecutar **sin instalar Node ni Angular**, usando solo **Docker** y los scripts incluidos.

### 1. Requisitos

- Tener **Docker** instalado y en ejecución:
  - En Windows: Docker Desktop.
  - En Linux/macOS: Docker Engine / Docker Desktop.

### 2. Windows (PowerShell / doble clic)

1. Ir a la carpeta del proyecto.
2. Ejecutar el script:

   - Doble clic en `run-docker-lista-tareas.bat`, o  
   - Desde PowerShell:
     ```powershell
     .\run-docker-lista-tareas.bat
     ```

3. El script:
   - construye la imagen Docker,
   - levanta el contenedor,
   - abre automáticamente `http://localhost:8080` en el navegador.

### 3. Linux / macOS (bash)

1. Dar permisos de ejecución al script (solo la primera vez):

   ```bash
   chmod +x run-docker-lista-tareas.sh
   ```

2. Ejecutar:

   ```bash
   ./run-docker-lista-tareas.sh
   ```

3. El script:
   - construye la imagen Docker,
   - levanta el contenedor,
   - intenta abrir `http://localhost:8080` en el navegador.

### 4. URL de la aplicación

En ambos casos, la app queda disponible en:

```text
http://localhost:8080
```

