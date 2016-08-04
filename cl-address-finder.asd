;;;; cl-address-finder.asd

(asdf:defsystem #:cl-address-finder
  :version "0.0.0"
  :description "Common Lisp library for calling the Address Finder web service"
  :author "Carl Douglas <carl.douglas@abletech.co.nz>"
  :license "MIT"
  :depends-on (#:drakma
               #:yason)
  :serial t
  :components ((:file "package")
               (:file "cl-address-finder")))
