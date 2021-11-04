package com.smps.zad6;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class TaskStorage {

    private static final TaskStorage taskStorage = new TaskStorage();

    private final List<Task> tasks;

    public static TaskStorage getInstance() {
        return taskStorage;
    }

    private TaskStorage() {
        tasks = new ArrayList<>();

        for (int i = 0; i < 100; i++) {
            Task task = new Task();
            task.setName("Zadanie #" + i);
            task.setDone(i % 3 == 0);
            tasks.add(task);
        }
    }

    public List<Task> getList(){
        return tasks;
    }

    public Task getById(UUID id){
        Task task = tasks.stream().filter(x-> x.getId().equals(id)).findAny().orElse(null);
        return task;
    }
}
