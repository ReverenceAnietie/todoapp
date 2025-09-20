/// Module: todoapp
module todoapp::todoapp;

use std::string::String;
use sui::object;

public struct TodoApp has key, store {
    id: UID,
    items: vector<String>,
    name: String,
}

public fun create_todo_list(name: String, ctx: &mut TxContext): TodoApp {
    let list = TodoApp {
        id: object::new(ctx),
        items: vector::empty(),
        name,
    };

    list
}

public fun add_todo(todo: &mut TodoApp, item: String) {
    todo.items.push_back(item);
}

public fun remove_todo(todo: &mut TodoApp, index: u64) {
    vector::remove(&mut todo.items, index);
}

public fun delete_todo_list(todo: TodoApp) {
    let TodoApp { id, items: _, name: _ } = todo;
    object::delete(id)
}

public fun length(todo: &TodoApp): u64 {
    todo.items.length()
}

public fun name(todo: &TodoApp): String {
    todo.name
}