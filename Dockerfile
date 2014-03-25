FROM ubuntu:13.10

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update

# install fleetctl
RUN apt-get install -y wget
RUN cd /root && wget https://github.com/coreos/fleet/releases/download/v0.1.4/fleet-v0.1.4-linux-amd64.tar.gz
RUN cd /root && tar -xzf fleet-v0.1.4-linux-amd64.tar.gz
RUN mv /root/fleet-v0.1.4-linux-amd64/fleetctl /usr/local/bin

# install bundler
RUN apt-get install -y git-core ruby ruby-dev build-essential
RUN gem install bundler


# install gem bundle
RUN mkdir -p /root/aedile/lib/aedile
# Add needed files for bundle install only 
# this improves use of the docker build cache to speed up build times
ADD ./Gemfile /root/aedile/Gemfile
ADD ./aedile.gemspec /root/aedile/aedile.gemspec
ADD ./lib/aedile/version.rb /root/aedile/lib/aedile/version.rb
RUN cd /root/aedile && bundle --quiet

ADD ./ /root/aedile

CMD ["status"]
WORKDIR /root/aedile
ENTRYPOINT ["bundle", "exec", "bin/aedilectl"]