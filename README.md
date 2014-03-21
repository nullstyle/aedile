# Aedile - simple PaaS on top of CoreOS and Fleet

TODO: Write a description

## Installation

Running this on a system that has ruby 1.9 or greater installed?:

    $ gem install aedile

Running this on a system that has docker installed?:

    $ docker pull nullstyle/aedile

## Usage

TODO: Write usage instructions here


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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
