## Lista de Tareas MVVM en Angular

Aplicación web sencilla de **lista de tareas** desarrollada en **Angular** para un taller universitario sobre el patrón arquitectónico **MVVM (Model–View–ViewModel)**.  
La app funciona completamente en el navegador, **sin backend** ni base de datos.

---

### Requisitos previos

- Node.js y npm instalados.
- Angular CLI (opcional, pero recomendado):

```bash
npm install -g @angular/cli
```

---

### Instalar dependencias

En la carpeta raíz del proyecto (donde está este `README.md`) ejecuta:

```bash
npm install
```

Esto descargará todas las dependencias necesarias definidas en `package.json`.

---

### Ejecutar el proyecto (desarrollo)

Puedes usar **Angular CLI** directamente:

```bash
ng serve
```

o bien, el script de npm:

```bash
npm start
```

Luego abre el navegador en:

- `http://localhost:4200/`

La aplicación se recargará automáticamente cuando modifiques los archivos fuente.

---

### Compilar el proyecto (build de producción)

Para generar los archivos listos para entregar o desplegar:

```bash
ng build
```

Esto generará la salida estática en la carpeta:

- `dist/lista-tareas-mvvm/` (o nombre equivalente configurado en `angular.json`)

Dentro de esa carpeta estarán los archivos HTML, CSS y JavaScript optimizados.

---

### Qué se debe entregar como “ejecutable” en Angular

Dependiendo de lo que pida el docente, se pueden entregar:

- **La carpeta completa del proyecto Angular**  
  (todo el código fuente con `src/`, `angular.json`, `package.json`, etc.).
- **La carpeta `dist/` generada después de `ng build`**  
  (solo los archivos compilados listos para desplegar en un servidor web).
- **Un `.zip`** que contenga:
  - solo el proyecto completo, o  
  - solo la carpeta `dist/`, o  
  - ambas, proyecto + `dist/`.

En este taller, lo importante es que quede claro cómo se genera el build (`ng build`) y qué carpeta contiene el resultado (`dist/`).

---

### Descripción funcional de la app

La aplicación permite:

- **Ingresar una nueva tarea** desde un campo de texto.
- **Visualizar la lista de tareas** en una tarjeta central.
- **Marcar tareas como completadas o pendientes**.
- **Eliminar tareas** de la lista.
- Ver un **contador** de:
  - tareas totales,
  - tareas completadas,
  - tareas pendientes.

No existe persistencia en base de datos ni en `localStorage` por defecto, de modo que al recargar la página la lista vuelve a estar vacía (comportamiento útil para explicar MVVM sin preocuparse por almacenamiento).

---

### MVVM en este proyecto

- **Model (Modelo)**
  - Definido en `src/app/models/task.model.ts`.
  - Representa la estructura de datos de una tarea (`Task`), con propiedades como `id`, `description` y `completed`.

- **ViewModel (Vista–Modelo)**
  - Implementada en el componente principal `src/app/app.ts` (`App`).
  - Mantiene el **estado** y la **lógica de negocio**:
    - arreglo de tareas (`tasks`),
    - propiedad ligada al campo de texto (`newTaskDescription`),
    - métodos como `addTask()`, `deleteTask(id)`, `toggleCompleted(id)`,
    - getters de solo lectura para los contadores (`totalTasks`, `completedTasks`, `pendingTasks`).

- **View (Vista)**
  - Plantilla HTML en `src/app/app.html`.
  - Utiliza:
    - **data binding bidireccional** con `[(ngModel)]="newTaskDescription"` para el input,
    - **`*ngFor`** para renderizar la lista de tareas,
    - **event binding** con `(click)` para llamar a los métodos del componente,
    - **interpolación** (`{{ ... }}`) para mostrar la descripción de cada tarea y los contadores.

El archivo `EXPLICACION_MVVM.md` amplía esta explicación con más detalle sobre el flujo de interacción entre usuario, View, ViewModel y Model.

---

### Estilo y presentación

La interfaz está pensada para ser:

- **Sencilla**: una sola tarjeta centrada con la lista de tareas.
- **Clara**: input y botón de “Agregar” arriba, lista debajo, contadores visibles.
- **Pedagógica**: el código está organizado para que sea fácil señalar qué parte corresponde a Model, ViewModel y View.

