# Aedile - simple PaaS on top of CoreOS and Fleet

Aedile is a system to help you manage services running atop [CoreOS](https://coreos.com/) and [Fleet](https://github.com/coreos/fleet).  By defining services (and the docker containers that comprise a service) and setting scale, aedile will make sure to create and submit the appropriate unit files to fleet to run that many instances of the container across your cluster.

Rather than tediously crafting a long and unwieldy command line string to launch a docker container from within fleet, aedile will create the commands for you from a simple json configuration file.

```
# The config file (for a service named `bash`):
{
  "image"  : "ubuntu",
  "command": "/bin/bash"
}

# will expand to the unit
[Unit]
Description=aedile: bash.0.service
After=docker.service
Requires=docker.service

[Service]
ExecStart=/usr/bin/docker run ubuntu /bin/bash

[X-Fleet]
X-Conflicts=bash.*.service
```

Rather than creating 15 copies of your app server's unit file, simply define a service in aedile to use your appserver container and set the scale to fifteen; Aedile will handle the "instancing" of the service and submit all 15 copies of the unit to fleet

## Status

At this point, you can add,edit,delete and scale services and the manager process will naively just submit units to fleet.  The manager does not properyly delete or update unit files

## Installation

Running this on a system that has ruby 1.9 or greater installed?:

    $ gem install aedile

Running this on a system that has docker installed?:

    $ docker pull nullstyle/aedile
    # add the following to your shell init files (.bashrc and the like) for ease of use
    $ function aedile() { docker run -i -t --rm=true nullstyle/aedile $@; }

## Usage

NOTE: this represented the indended cli and workflow... not everything works yet

### Global Options

Aedile aims to provide a similar interface as fleetctl, and in that spirit we support two global options: `tunnel` and `endpoint`.
use tunnel to ssh from your workstation into a coreos box to run commands, and use endpoint to manually configure the http address that etcd is listening at (we default to the CoreOS convention of `http://172.17.42.1:4001`)

### Defining a service

The first step to working with aedile is to define a service.  You do this will the following command:

```bash
aedile new-service NAME
# example: aedile service new web
```

Running this command will open your local editor (as specified by your EDITOR environment variable) in which you can customize the docker image to run and what command to run within the image.

### Setting a service's scale

A new service initially has a scale of 0; That is, it will not be scheduled to run on any machines in your cluster.  By setting the scale to greater than zero, we can decide how many copies of the service we want to provide to fleet for scheduling.  You do this simply by:

```bash
aedile scale-service NAME SCALE
# example: aedile service scale web 4
```

### Running the aedile manager

Most commands in aedile simply interact with etcd, getting and setting values into that system.  A manager process that runs within your cluster is where the magic happens.  It watches for changes to your aedile configuration and makes the appropriate commands against fleet to ensure your desired services are scheduled.  Change a services scale, and it sees the config change and adds the appropriate unit files to fleet, and so forth.

Running a simple manager is as easy as:

    aedile manage

The command above runs a foreground instance of the manager that you can watch do its thing.  This is useful for learning how aedile works, but in the long run it makes more sense to hand the management of the manager (heh) off to fleet itself, like so:

    aedile install-manager



## Tutorial - Hello World sinatra app

TODO: write the damn tutorial

## Future Directions

At the moment, aedile is pretty sparse.  In the future I want to automate more things 
and allow higher level docker/coreos patterns to be expressed simply via aedile when they come 
about.  Some future directions I see:

### Multiple containers per service

This one seems pretty important to me.  To enable ambassador patterns such as described in https://coreos.com/blog/docker-dynamic-ambassador-powered-by-etcd/ aedile needs to support defining a service that has multiple containers that run in conjunction.  The idea here would be to render and submit multiple unit files to fleet (with the appropriate X-Fleet arguments to schedule them on the same machine) for any given "Service Instance"

### Service pinning

The idea here would be to automate the selection of the "permanent home" for a service instance such that it can write to docker volumes and be ensured that fleet won't move it to another machine if the container dies.  By specifying that you want the service pinned we would simply pick out a machine to schedule the process on for you from the list of machines known to fleet.

### Other things (that I am too lazy to write a full description for)

- volume support
- rolling restart orchestration
- continuous delivery


### TODO

1.  Get the manager working
1.  manager needs to flush the memoized data on each run

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
