FROM ubuntu:13.10

RUN apt-get update
RUN apt-get install -y bundler
RUN apt-get install -y git-core
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
ENTRYPOINT ["bundle", "exec", "bin/aedile"]