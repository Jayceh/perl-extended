FROM scottw/alpine-perl

RUN apk update && apk add openssl-doc openssl-dev readline readline-dev && apk upgrade musl musl-dev
RUN cpanm Net::SSLeay

# Had to pre-install these for Moo to build, odd
RUN cpanm Type::Tiny Types::Standard Type::Library
RUN cpanm Moo

RUN cpanm Mojo::Redis2 List::MoreUtils Redis::DistLock
RUN cpanm MongoDB
# MongoDB::Async Mango MongoDBI  -- not working yet in here

RUN cpanm Crypt::PK::ECC Bytes::Random::Secure

##not sure what the test isn't liking, but having to force this
RUN cpanm -f Term::ReadKey

# Locale needs a TZ environment for the tests to pass
ENV TZ=UTC
RUN cpanm Dist::Zilla

RUN cpanm DateTime::Tiny Data::Faker JSON::XS
RUN Meerkat
