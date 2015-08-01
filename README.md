This was an attempt to set up Gerrit with Heroku. Unfortunately I couldn't get
it to run.

The error I saw in the Heroku logs was this:

```
2015-07-26T23:39:44.058402+00:00 app[web.1]: 1) No index versions ready; run Reindex
2015-07-26T23:39:44.058403+00:00 app[web.1]:
2015-07-26T23:39:44.058404+00:00 app[web.1]: 1 error
2015-07-26T23:39:44.058406+00:00 app[web.1]: 	at com.google.gerrit.lucene.LuceneVersionManager.start(LuceneVersionManager.java:146)
2015-07-26T23:39:44.058407+00:00 app[web.1]: 	at com.google.gerrit.lifecycle.LifecycleManager.start(LifecycleManager.java:74)
2015-07-26T23:39:44.058409+00:00 app[web.1]: 	at com.google.gerrit.pgm.Daemon.start(Daemon.java:293)
2015-07-26T23:39:44.058410+00:00 app[web.1]: 	at com.google.gerrit.pgm.Daemon.run(Daemon.java:205)
2015-07-26T23:39:44.058412+00:00 app[web.1]: 	at com.google.gerrit.pgm.util.AbstractProgram.main(AbstractProgram.java:64)
2015-07-26T23:39:44.058413+00:00 app[web.1]: 	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
2015-07-26T23:39:44.058415+00:00 app[web.1]: 	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:57)
2015-07-26T23:39:44.058416+00:00 app[web.1]: 	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
2015-07-26T23:39:44.058418+00:00 app[web.1]: 	at java.lang.reflect.Method.invoke(Method.java:606)
2015-07-26T23:39:44.058419+00:00 app[web.1]: 	at com.google.gerrit.launcher.GerritLauncher.invokeProgram(GerritLauncher.java:166)
2015-07-26T23:39:44.058421+00:00 app[web.1]: 	at com.google.gerrit.launcher.GerritLauncher.mainImpl(GerritLauncher.java:93)
2015-07-26T23:39:44.058422+00:00 app[web.1]: 	at com.google.gerrit.launcher.GerritLauncher.main(GerritLauncher.java:50)
2015-07-26T23:39:44.058424+00:00 app[web.1]: 	at Main.main(Main.java:25)
```

need to reindex in the compile script

The Internet suggested running java -jar bin/gerrit.war reindex to fix this
error. I tried running this, was successful, but couldn't get the app to stop
crashing with this error.

Another odd issue I saw was the config getting set/written based on the
environment variables, but when I ran `heroku run bash` the config would not
have the database credentials available. I'm not sure what to do about this.
You can run `bin/gerrit.sh check` which will set them for you.

# Install

0. Create a Heroku app with `heroku create` (you'll need the Heroku Toolbelt)

1. Add the Heroku buildpack

    ```bash
    heroku buildpacks:add https://github.com/kevinburke/heroku-buildpack-gerrit-runner
    ```

2. Set Heroku environment variables by running `heroku config:set VARNAME=value`

    ```
    GERRIT_DB_HOSTNAME
    GERRIT_DB_DATABASE
    GERRIT_DB_USERNAME
    GERRIT_DB_PASSWORD
    ```

    Repositories will be placed in /app/git - this should be handled for you by
    the buildpack.

3. Generate SSH keys. These will be used by Gerrit to check out code

    ```
    ssh-keygen -t rsa -b 4096
    ```

    You may need to move these to the ssh_host_key; I'm not sure whether Gerrit
    needs the private or public key or both.

4. You might need to run the initialization script: `java -jar bin/gerrit.war init -d /app`
