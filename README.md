tl;dr: This shows a way to integrate JRebel into a Play application.

It is tailored towards this usecase: Migrating a gradle-managed, multi-project JavaEE Web-Application to Play.
But maybe it is helpful for others, too.

### Long version ###

Our pre-play workflow: Deploy to Container XXX, let JRebel handle code changes.

Play:
We put the jars in the `/lib` dir.
Play comes with it's own reload mechanism, but it won't reload the jars in the `/lib` dir.
And I think 'just' reloading here would be a bad idea - think of static variables losing their state.
That's where JRebel comes into place. The trick here is to include a `rebel.xml` inside the dependent jars.

### How to run ###

Ensure `/tmp/jrebel.jar` and `/tmp/jrebel.lic` exist.

Run `./simulate_dev_workflow.sh` in a terminal.
It
 * prepares `rebel.xml`
 * creates the jar (in `play-java/lib`)
 * to simulate some work, it updates timestamps every 5 seconds (in it's only Java class and in the only Play controller)
 
Run `./run_play_in_dev_mode_with_jrebel.sh` in another terminal.
It just starts the Play application in DEV mode with `JAVA_OPTS` for activating JRebel.

When browsing to i.e. localhost:9000, the output should look similar to:

````
My                 time: Thu Oct  8 12:33:47 UTC 2015
Dependency dynamic time: Thu Oct  8 12:33:47 UTC 2015
Dependency  static time: Thu Oct  8 12:32:02 UTC 2015
````

The first line is the timestamp in the `Application` controller.
The second line is the timestamp in the Dependency (result of a method invocation).
The third line is the timestamp in the Dependency (content of a static field).

### Explanation ###

The first and second timestamp should be equal (and current):
The `Application` controller is reloaded by Play.
The dependency is reloaded by JRebel.

The third timestamp should stay the same (time of application startup):
It's a static field and JRebel doesn't seem to touch these when reloading the class.

### Versions ###

Tested with JRebel 6.2.5, Play 2.4.3, Java 1.8.0_60-b27, Activator 1.3.6 .

The play application in `/play-java` has been created with `activator new play-java play-java`.
The only change is the output of the `Application` controller.
