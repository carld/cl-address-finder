;;;; cl-address-finder.lisp

(in-package :cl-address-finder)

(defparameter *key* nil
  "API key")

(defparameter *secret* nil
  "API secret")

(defun make-keyword (name)
  "Intern `name' into the keyword package"
  (values (intern (string-upcase name) "KEYWORD")))

(defun stringify-param (var)
  "Writes `var' as a string unless it already is a string"
  (unless (stringp var) (write-to-string var)))

(defun *default-parameters* ()
  "Returns an association list of mandatory parameters for every request"
    `(("key" . ,*key*) ("secret" . ,*secret*)))

(defun api-request (uri params)
  "make an HTTP request to `uri' with the supplied `params'"
  (let ((stream
         (drakma:http-request
          uri
          :want-stream t
          :method :GET
          :parameters params )))
    (setf (flexi-streams:flexi-stream-external-format stream) :utf-8)
    (yason:parse stream :object-as :plist
                 :object-key-fn #'make-keyword
                 )))

(defmacro defapi (path params)
  `(api-request
    ,(format nil "https://api.addressfinder.io/api/~a" path)
    (append (*default-parameters*) ,params)))

;; Address Finder helper functions below

(defun address (q)
  (defapi "nz/address" `(("q" . ,q))))

(defun address/info (pxid)
  (defapi "nz/address/info" `(("pxid" . ,pxid))))

(defun address/nearby (longitude latitude)
  (defapi "nz/address/nearby"
      `(("x" . ,(stringify-param longitude))
        ("y" . ,(stringify-param latitude)))))

(defun address/bulk (points)
  (defapi "nz/address/bulk"
      `(("points" . ,(cond
                      ((listp points) (format nil "~{~a~^,~}" points))
                      ((stringp points) points)
                      (t (error "points parameter must be a list or a string")))))))

(defun address/cleanse (q)
  (defapi "nz/address/cleanse" `(("q" . ,q))))

(defun location (q)
  (defapi "nz/location" `(("q" . ,q))))

(defun location/info (pxid)
  (defapi "nz/location/info" `(("pxid" . ,pxid))))

(defun location/nearby (longitude latitude)
  (defapi "nz/location/nearby"
      `(("x" . ,(stringify-param longitude))
        ("y" . ,(stringify-param latitude)))))
