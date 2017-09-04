FROM elixir

RUN apt update && apt install -y vim

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -

RUN mix local.hex --force

RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez --force

RUN apt-get update -qq && \
apt-get install -y --no-install-recommends bzip2 ca-certificates \
python python-dev python-pip python-twisted-core python-setuptools

RUN pip install csvkit

RUN pip install 'six>=1.9.0'

ADD docker-entrypoint.sh /entrypoint.sh

RUN chmod 755 /entrypoint.sh
