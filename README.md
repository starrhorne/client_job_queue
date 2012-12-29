# Introduction

[![Build Status](https://travis-ci.org/starrhorne/client_job_queue.png?branch=master)](https://travis-ci.org/starrhorne/client_job_queue)

This rails engine lets you invoke client-side workers from your
controllers without having to do ugly things like dynamically build JS 
in your views. 

# Setup

## In your application.js (or wherever)

    new EventQueue("my_queue", {
      "console:log": function(options){
        console.log(options);
      }
    })

## In your controller

    def index
      enqueue_client_job("my_queue", "console:log", "Hello World")
    end

# Warning

This code is under heavy development. Use at your own risk.

# Credits

This gem is brought to you by the good people at Honeybadger.io, a [Rails Error Notifier](http://honeybadger.io).

