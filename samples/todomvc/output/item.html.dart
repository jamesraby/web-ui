// Generated Dart class from HTML template item.html.
// DO NOT EDIT.

#library('item_html');

#import('dart:html');
#import('../../../component.dart');
#import('../../../watcher.dart');

/** Below import from script tag in HTML file. */
#import('model.dart');

class TodoItemComponent extends Component {
  /** User written code associated with this component 'item.html'. */
  Todo todo;
  bool _editing = false;

  void edit() {
    _editing = true;
  }

  void update() {
    _editing = false;
  }

  /** Autogenerated from the template. */
  TodoItemComponent() : super('x-todo-item');

  DivElement topDiv;
  LabelElement label;
  InputElement checkbox;
  ButtonElement destroy;
  InputElement editbox;
  void created(ShadowRoot shadowRoot) {
    root = shadowRoot;
    label = root.query('#label');
    checkbox = root.query('#checkbox');
    destroy = root.query('button.destroy');
    editbox = root.query('input.edit');
    topDiv = root.query('#todo-item');
  }

  // TODO(samhop): this is a terrible pattern -- it would be better if
  // there were a lifecycle event for 'data is ready', which in this case
  // we would call when scopedVariables contained the data to do the binding
  // (i.e. AFTER scopedVariables is initially set up by the Component's
  // constructor).
  void set scopedVariables(vars) {
    super.scopedVariables = vars;
    if (element != null) {
      todo = scopedVariables[element.attributes['data-todo']];
    }
  }

  get scopedVariables => super.scopedVariables;

  WatcherDisposer _stopWatcher1;
  WatcherDisposer _stopWatcher2;
  WatcherDisposer _stopWatcher3;
  EventListener _listener1;
  EventListener _listener2;
  EventListener _listener3;
  EventListener _listener4;
  void inserted() {
    _stopWatcher1 = bind(() => todo.task, (_) { label.innerHTML = todo.task; });
    _stopWatcher2 = bind(() => todo.done, (_) {
      checkbox.checked = todo.done;
      if (todo.done) {
        root.query('#todo-item').classes.add('completed');
      } else {
        root.query('#todo-item').classes.remove('completed');
      }
    });

    _listener1 = (_) {
      todo.done = checkbox.checked;
      dispatch();
    };
    checkbox.on.click.add(_listener1);

    _listener2 = (_) {
      var list = app.todos;
      var index = list.indexOf(todo);
      if (index != -1) {
        list.removeRange(index, 1);
        dispatch();
      }
    };
    destroy.on.click.add(_listener2);

    _stopWatcher3 = bind(() => _editing, (_) {
      if (_editing) {
        root.query('#todo-item').classes.add('editing');
      } else {
        root.query('#todo-item').classes.remove('editing');
      }
    });

    _listener3 = (_) {
      editbox.value = todo.task;
      _editing = true;
      // TODO(terry): Double underscore needed to eliminate error:  '_' is
      //              hiding parameter '_' from above _listener3
      _listener4 = (__) {
        update();
        todo.task = editbox.value;
        editbox.on.blur.remove(_listener4);
        editbox.on.change.remove(_listener4);
        dispatch();
      };
      editbox.on.blur.add(_listener4);
      editbox.on.change.add(_listener4);
      dispatch();
    };
    topDiv.on.doubleClick.add(_listener3);
  }

  void removed() {
    _stopWatcher1();
    _stopWatcher2();
    _stopWatcher3();
    checkbox.on.click.remove(_listener1);
    destroy.on.click.remove(_listener2);
    topDiv.on.doubleClick.remove(_listener3);
  }
}
