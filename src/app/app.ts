import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Task } from './models/task.model';

@Component({
  selector: 'app-root',
  // ViewModel expone datos y operaciones a la Vista.
  imports: [CommonModule, FormsModule],
  templateUrl: './app.html',
  styleUrl: './app.css',
})
export class App {
  /**
   * Texto que el usuario escribe en el input (parte de la ViewModel).
   * Está enlazado con la vista mediante [(ngModel)].
   */
  newTaskDescription = '';

  /**
   * Colección de tareas que representa el estado de la aplicación (Model gestionado por la ViewModel).
   */
  tasks: Task[] = [];

  /**
   * Contador interno para generar ids únicos de tareas.
   */
  private nextId = 1;

  /**
   * Getter de solo lectura para mostrar la cantidad total de tareas.
   */
  get totalTasks(): number {
    return this.tasks.length;
  }

  /**
   * Getter de solo lectura para mostrar cuántas tareas están completadas.
   */
  get completedTasks(): number {
    return this.tasks.filter((task) => task.completed).length;
  }

  /**
   * Getter de solo lectura para mostrar cuántas tareas están pendientes.
   */
  get pendingTasks(): number {
    return this.tasks.filter((task) => !task.completed).length;
  }

  /**
   * Agrega una nueva tarea utilizando el texto ingresado en la vista.
   * Aplica validación para evitar descripciones vacías o solo con espacios.
   */
  addTask(): void {
    const description = this.newTaskDescription.trim();
    if (!description) {
      return;
    }

    const newTask: Task = {
      id: this.nextId++,
      description,
      completed: false,
    };

    this.tasks = [...this.tasks, newTask];
    this.newTaskDescription = '';
  }

  /**
   * Elimina una tarea por id.
   */
  deleteTask(id: number): void {
    this.tasks = this.tasks.filter((task) => task.id !== id);
  }

  /**
   * Cambia el estado de completada/pendiente de una tarea.
   */
  toggleCompleted(id: number): void {
    this.tasks = this.tasks.map((task) =>
      task.id === id ? { ...task, completed: !task.completed } : task,
    );
  }

  /**
   * Función de trackBy para *ngFor, usando el id de la tarea.
   */
  trackByTaskId(index: number, task: Task): number {
    return task.id;
  }
}
