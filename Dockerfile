FROM ubuntu:13.10

RUN apt-get update
RUN apt-get install -y bundler
RUN apt-get install -y git-core
RUN mkdir /root/aedile
ADD ./ /root/aedile
RUN cd /root/aedile && bundle install --quiet

CMD ["status"]
WORKDIR /root/aedile
ENTRYPOINT ["bundle", "exec", "bin/aedile"]