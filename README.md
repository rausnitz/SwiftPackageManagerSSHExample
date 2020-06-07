# SwiftPackageManagerSSHExample

## Create a deploy key

1. Run `mkdir .ssh` and `cd .ssh`.
2. Run `ssh-keygen -b 4096 -t rsa -N "" -f key -C ""` locally to generate a new SSH key.
3. Add a file called `config` in your `.ssh` directory, consisting of:
```
Host github.com
    HostName github.com
    User git
    IdentityFile ./.ssh/key
```
4. Go to the Settings page of the GitHub repo for your private dependency. Click `Add deploy key`.
5. Choose a Title and then paste the contents of the `key.pub` file (which should begin with `ssh-rsa`) that you generated in step 2 into the Key field.

(To use the key locally on your Mac, run `ssh-add ./.ssh/key`.)

## Add the dependency to your Package.swift file

Add the package to your Package.swift `dependencies` array, using SSH in the URL instead of HTTPS. For example: `.package(url: "git@github.com:rausnitz/SwiftExample.git", .branch("master"))`

## Set up your private key with Docker

Add the following to your Dockerfile before packages get built:

```
RUN mkdir -p /root/.ssh
RUN touch /root/.ssh/known_hosts
RUN cp ./.ssh/* /root/.ssh
RUN ssh-keyscan -t rsa github.com >> /root/.ssh/known_hosts
RUN chmod 400 ./.ssh/key
```