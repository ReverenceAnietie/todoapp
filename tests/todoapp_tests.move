
#[test_only]
module todoapp::todoapp_tests;

use bridge::bridge_env::scenario;
use sui::test_scenario;
use sui::transfer::public_transfer;
use todoapp::todoapp::{create_todo_list, add_todo, remove_todo, TodoApp};

#[test]
fun test_create_todo() {
    let sender = @0x5b2;
    let name = b"Mfoniso".to_string();

    let mut scenerio = test_scenario::begin(sender);

    {
        let ctx = test_scenario::ctx(&mut scenerio);
        let todo = create_todo_list(name, ctx);

        assert!(todo.length()==0, 0);
        transfer::public_transfer(todo, sender)
    };
    scenerio.end();
}

#[test]
fun test_add_to_todo() {
    let sender = @0x5b2;
    let name = b"Mfoniso".to_string();

    let mut scenerio = test_scenario::begin(sender);

    {
        let ctx = test_scenario::ctx(&mut scenerio);
        let todo = create_todo_list(name, ctx);

        assert!(todo.length()==0, 0);
        transfer::public_transfer(todo, sender)
    };

    scenerio.next_tx(sender);
    {
        // let ctx = test_scenario::ctx(&mut scenerio);
        let mut todo = scenerio.take_from_address<TodoApp>(sender);

        add_todo(&mut todo, b"First Todo Item".to_string());
        add_todo(&mut todo, b"Second Todo Item".to_string());

        assert!(todo.length()==2, 0);
        transfer::public_transfer(todo, sender);
    };
    scenerio.end();
}

#[test]
fun test_remove_from_todo() {
    let sender = @0x5b2;
    let name = b"Mfoniso".to_string();
    let mut scenerio = test_scenario::begin(sender);

    {
        let ctx = test_scenario::ctx(&mut scenerio);
        let todo = create_todo_list(name, ctx);

        assert!(todo.length()==0, 0);
        transfer::public_transfer(todo, sender)
    };

    scenerio.next_tx(sender);{

        let mut todo = scenerio.take_from_address<TodoApp>(sender);

        add_todo(&mut todo, b"First Todo Item".to_string());
        add_todo(&mut todo, b"Second Todo Item".to_string());

        remove_todo(&mut todo, 0);

        assert!(todo.length()==1, 0);
        transfer::public_transfer(todo, sender);
    };
    scenerio.end();
}