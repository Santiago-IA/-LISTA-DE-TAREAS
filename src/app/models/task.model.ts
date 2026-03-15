export interface Task {
  /**
   * Identificador único de la tarea dentro de la lista (Model).
   */
  id: number;

  /**
   * Descripción de la tarea que verá el usuario.
   */
  description: string;

  /**
   * Indica si la tarea está completada o pendiente.
   */
  completed: boolean;
}

