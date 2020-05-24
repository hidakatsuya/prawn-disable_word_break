FROM ruby:2.7.1

RUN apt-get update -qq && apt-get install -y build-essential xvfb

# Install diff-pdf
WORKDIR /tmp
RUN apt-get install -y libpoppler-glib-dev poppler-utils libwxgtk3.0-dev && curl -L https://github.com/vslavik/diff-pdf/archive/master.tar.gz -o diff-pdf-master.tar.gz && tar zxf diff-pdf-master.tar.gz && cd diff-pdf-master && ./bootstrap && ./configure && make && make install

RUN mkdir /prawn-disable_word_break

WORKDIR /prawn-disable_word_break
VOLUME /prawn-disable_word_break
