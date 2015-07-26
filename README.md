# Install

1. Add the Heroku buildpack

    ```bash
    heroku buildpacks:add https://github.com/kevinburke/heroku-buildpack-gerrit-runner
    ```

2. Set Heroku environment variables:

    ```
    GERRIT_DB_HOSTNAME
    GERRIT_DB_DATABASE
    GERRIT_DB_USERNAME
    GERRIT_DB_PASSWORD
    ```

    Projects will be placed in /app/projects - this should be handled for you by
    the buildpack

3. Generate SSH keys. These will be used by Gerrit to check out code

    ```
    ssh-keygen -t rsa -b 4096
    ```

    you may need to move these to ssh_host_key
