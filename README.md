# Install

You can install those plugins wherever you want.

On my Debian systems, Munin plugins are stored in `/usr/share/munin/plugins`.
I've installed those in my home directory and it works well.

# Plugins

## resque_queues

A graph with a line for the total number of pending jobs, and a line for each queue.

## resque_workers

A graph with the total number of workers and the number of active (busy) workers.

There are 2 levels :

* warning = 1.5 x workers
* critical = 3 x workers

For the moment, those thresholds are not configurable in plugin settings.

# Helper files

## plugin.rb

This file has the same purpose as `plugin.sh` but for Ruby scripts.

## resque.rb

It provides a simple `stats` method, that returns a nested hash from `Resque::Server` web app.