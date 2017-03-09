# Deployment of Static Files to Staging VPS (Multiple Pipelines Assignment)
#### By Emily Kaneff

For this tutorial, we will be using a static html file to demonstrate the process of deploying a static application to a virtual private server that was set up using Ansible through the use of remote git repositories.

If you have not done so already, follow the tutorial for setting up the VPS using Digital Ocean and Ansible [here](setup.md). 

>Note: This is only one of the three pipelines feeding into our servers. The others with setup and deployment instructions can be found at: <br>
>[https://github.com/ekaneff/wk2-php](https://github.com/ekaneff/wk2-php) <br>
>[https://github.com/ekaneff/wk2-node](https://github.com/ekaneff/wk2-node)

##Table of Contents

* [Create Static File](#one)
* [Add Git Remote](#two)
* [Push to Git Remote](#three)

<a name="one"></a>
##Step One: Create Static File

This project is set up to handle plain, static files. Therefore, you can simply move your static project files into the directory with the ansible files.

For this tutorial we will simply create an `index.html` file with the content of `Hello World` to demonstrate the deployment process. 

To create this file, simply run in the root directory: 

```shell
nano index.html
```

and insert: 

```shell
<h1>Hello, world!</h1>
```

Save and close the file. 

<a name="two"></a>
## Step Two: Adding Remote Connection

When setting up our servers, the automation script went through the process of initializing a bare repository on each server. This repository contains a post-receive hook that will push the files we send to the correct live folder based on the pipeline the files are running through. 

In order to send these files, we need to create a connection locally to that remote repository. We can do this through the Git commands: 

```shell
git remote add StaticStaging ssh://root@[staging ip]:/var/repos/static.git

git remote add StaticProduction ssh://root@[production ip]:/var/repos/static.git
```

>Note that the file path at the end must remain the same as I have listed it as that is the naming convention used in the playbook. You can change this if you so wish, you just need to edit the correct line in `repos.sh`. 

## Step Three: Push to Remote

Now that the connection has been created, we can push files up to the server as we please. This is done through the command: 

```shell
git push StaticStaging [local branch]:[remote branch]
```

The local branch in this line will be whatever branch you use in your workflow that contains the version of your files ready for release. 

The remote branch is the branch on your remote repository that you want to hold the files you send. If the branch does not exit, it will be created. 

The `post-receive` hook located in the remote repository (created in our automation script) will handle the transfer of files from the repository to the live folders, so there is no need for you to go in and do it manually. 

Also note that we only pushed to the staging server, and not the production one. Pushing to production would be the same command but with the name of the connection to your remote production repository instead. In our workflow, pushing to production only happens after everything is functional on staging. 

If you would like to check that your files transferred correctly without pulling it up in the browser, you can ssh into your server and look for the changes in `/var/www/html/static`. 

You should now be able to navigate to `html.[your stage ip].xip.io` and be greeted by your `hello world` text.