= cl-address-finder

This package provides Common Lisp functions for calling the Address Finder web services.

== Installation

It can be loaded with [quicklisp](http://quicklisp.org). When using offline, copy the cl-address-finder directory
under `~/quicklisp/local-projects/`.

    (quicklisp:quickload :cl-address-finder)


== Configuration

The account key and secret need to be set in order to authenticate with each request.

    (setf cl-address-finder:*key*  "Your key")
    (setf cl-address-finder:*secret*  "Your secret")


== Usage

To perform an address search,

    (cl-address-finder:address "willis street")

JSON responses are converted to Common Lisp property lists.
