## Explicación del patrón MVVM en esta app

Esta aplicación de lista de tareas está construida para ilustrar de forma clara el patrón **MVVM (Model–View–ViewModel)** usando Angular.

---

### 1. Model (Modelo)

**Archivo:** `src/app/models/task.model.ts`

- Contiene la definición de la interfaz `Task`:
  - `id: number`
  - `description: string`
  - `completed: boolean`
- Representa **solo los datos**, sin lógica de presentación.
- Es independiente de Angular; podría reutilizarse en otros contextos.

En MVVM, el **Model** es la parte que conoce la estructura de la información que maneja la aplicación.

---

### 2. ViewModel (Vista–Modelo)

**Archivo:** `src/app/app.ts` (clase `App`)

Responsabilidades principales:

- Mantener el **estado** que necesita la vista:
  - `tasks: Task[]` → arreglo de tareas.
  - `newTaskDescription: string` → texto que escribe el usuario en el input.
  - `nextId: number` → contador interno para asignar ids únicos.
- Exponer **propiedades calculadas** para la vista:
  - `totalTasks` → número total de tareas.
  - `completedTasks` → tareas con `completed = true`.
  - `pendingTasks` → tareas con `completed = false`.
- Implementar la **lógica de interacción**:
  - `addTask()` → agrega una nueva tarea validando que el texto no esté vacío ni sea solo espacios.
  - `deleteTask(id: number)` → elimina una tarea por id.
  - `toggleCompleted(id: number)` → alterna el estado completada/pendiente de una tarea.
  - `trackByTaskId` → ayuda de rendimiento para `*ngFor`.

La ViewModel **no** conoce detalles de HTML ni de estilos; solo expone datos y operaciones que la View puede enlazar.

---

### 3. View (Vista)

**Archivo:** `src/app/app.html`

Responsabilidades principales:

- Mostrar la información expuesta por la ViewModel.
- Definir la estructura visual y la maquetación.
- Disparar eventos de usuario que la ViewModel se encargará de procesar.

Elementos clave en la View:

- **Data binding bidireccional**:

  ```html
  <input
    [(ngModel)]="newTaskDescription"
    ...
  />
  ```

  - El valor del input se actualiza cuando cambia `newTaskDescription`.
  - Cuando el usuario escribe, se actualiza automáticamente `newTaskDescription` en la ViewModel.

- **Eventos (event binding)**:

  ```html
  <button type="button" (click)="addTask()">Agregar</button>
  <button type="button" class="btn-secondary" (click)="toggleCompleted(task.id)">
    {{ task.completed ? 'Desmarcar' : 'Completar' }}
  </button>
  <button type="button" class="btn-danger" (click)="deleteTask(task.id)">
    Eliminar
  </button>
  ```

  - La Vista solo dispara `(click)` y delega la lógica a la ViewModel.

- **Renderizado de listas con `*ngFor`**:

  ```html
  <li
    *ngFor="let task of tasks; trackBy: trackByTaskId"
    [class.task-completed]="task.completed"
  >
    ...
  </li>
  ```

  - La Vista recorre el arreglo `tasks` proporcionado por la ViewModel.
  - Usa `trackByTaskId` para identificar cada elemento establemente.

- **Interpolación de datos**:

  ```html
  {{ task.description }}
  {{ totalTasks }}
  {{ completedTasks }}
  {{ pendingTasks }}
  ```

  - Muestra valores primitivos calculados por la ViewModel.

- **Estilos y presentación**:
  - Controlados principalmente en `src/app/app.css`.
  - Tareas completadas usan la clase `task-completed` para verse con texto tachado y colores más suaves.

---

### 4. Flujo de interacción usuario–MVVM

1. **El usuario escribe una tarea nueva** en el campo de texto.
   - La Vista actualiza `newTaskDescription` en la ViewModel gracias a `[(ngModel)]`.

2. **El usuario hace clic en “Agregar”**.
   - La Vista dispara `(click)="addTask()"`.
   - La ViewModel ejecuta `addTask()`:
     - Valida que `newTaskDescription.trim()` no esté vacío.
     - Crea un nuevo objeto `Task`.
     - Actualiza el arreglo `tasks`.
     - Limpia `newTaskDescription`.

3. **Angular vuelve a renderizar la Vista**.
   - `*ngFor` recorre el nuevo arreglo `tasks`.
   - La lista en pantalla muestra la nueva tarea.
   - Los contadores (`totalTasks`, `completedTasks`, `pendingTasks`) se recalculan automáticamente y se actualizan en la Vista.

4. **El usuario marca una tarea como completada**.
   - La Vista dispara `(click)="toggleCompleted(task.id)"`.
   - La ViewModel busca la tarea y alterna su propiedad `completed`.
   - Angular vuelve a actualizar la Vista:
     - La clase CSS `task-completed` se añade o se quita.
     - Cambia el símbolo (`✓` / `○`) y el texto del botón (`Completar` / `Desmarcar`).
     - Se actualizan los contadores.

5. **El usuario elimina una tarea**.
   - La Vista dispara `(click)="deleteTask(task.id)"`.
   - La ViewModel filtra el arreglo `tasks` eliminando esa entrada.
   - La Vista se vuelve a renderizar sin esa tarea y se actualizan los contadores.

En todo momento:

- La **View** se limita a mostrar datos y disparar eventos.
- La **ViewModel** contiene la lógica y manipula el **Model** (`Task`).
- El **Model** solo define la forma de los datos.

Este desacoplamiento es lo que hace al patrón MVVM especialmente útil y pedagógico en aplicaciones como esta.

