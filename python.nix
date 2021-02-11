{ pkgs, ... }:
let
  pyjwt = with pkgs.python3.pkgs; pkgs.callPackage ./pypi-pkgs/pyjwt {
    # buildPythonPackage = pkgs.python3.pkgs.buildPythonPackage;
    # fetchPypi = pkgs.python3.pkgs.fetchPypi;
    inherit buildPythonPackage fetchPypi cryptography ecdsa pytestrunner pytestcov pytest;
  };
  social-auth-core = pkgs.callPackage ./pypi-pkgs/social-auth-core {
    buildPythonPackage = pkgs.python3.pkgs.buildPythonPackage;
    fetchPypi = pkgs.python3.pkgs.fetchPypi;
    inherit pyjwt;
  };
  social-auth-app-django = pkgs.callPackage ./pypi-pkgs/social-auth-app-django {
    buildPythonPackage = pkgs.python3.pkgs.buildPythonPackage;
    fetchPypi = pkgs.python3.pkgs.fetchPypi;
    inherit social-auth-core;
  };
in
let
  python = let packageOverrides = self: super: { inherit pyjwt; }; in pkgs.python3.override {inherit packageOverrides; self = python; };
in
pkgs.python3.withPackages(ps: with ps; [
  pip
  setuptools
  django
  django-q
  djangorestframework
  django_extensions
  social-auth-app-django
]
)
