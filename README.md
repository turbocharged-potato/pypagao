# PYPagao

A website providing crowdsourced solution for past year papers.

[![Build Status](https://travis-ci.org/turbocharged-potato/pypagao.svg?branch=master)](https://travis-ci.org/turbocharged-potato/pypagao) [![Coverage Status](https://coveralls.io/repos/github/turbocharged-potato/pypagao/badge.svg?branch=master)](https://coveralls.io/github/turbocharged-potato/pypagao?branch=master) [![Maintainability](https://api.codeclimate.com/v1/badges/4964d9836fd4f76498ff/maintainability)](https://codeclimate.com/github/turbocharged-potato/pypagao/maintainability)

## Entity-Relationship Diagram
![ERD](schema.png)

### Generate ERD
To generate the current Entity-Relationship Diagram, install `graphviz` (`sudo apt install graphviz` or `brew install graphviz`), then run `rake generate_erd`. This is also run as a post-migration hook (i.e. after `bin/rails db:migrate`)

## Installation
Make sure you have Ruby 2.5.0, Bundler, and PostgreSQL 9.6 installed. Adjust the content of `database.yml` and `.env`

```bash
cp config/database.yml.example config/database.yml
cp .env.default .env
bundle install
bin/rails db:setup
bin/rails server
```
