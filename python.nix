{ pkgs, ... }:
let
  python = let packageOverrides = self: super: { pyjwt = super.pyjwt.overridePythonAttrs(old: rec {
        version = "2.0.1";
        src =  super.fetchPypi {
          pname = "PyJWT";
          inherit version;
          sha256 = "a5c70a06e1f33d81ef25eecd50d50bd30e34de1ca8b2b9fa3fe0daaabcf69bf7";
        };
      }); }; in pkgs.python3.override {inherit packageOverrides; self = python; };
in
let
  social-auth-core = pkgs.callPackage ./pypi-pkgs/social-auth-core {
    buildPythonPackage = python.pkgs.buildPythonPackage;
    fetchPypi = python.pkgs.fetchPypi;
    pyjwt = python.pkgs.pyjwt;
  };
  social-auth-app-django = pkgs.callPackage ./pypi-pkgs/social-auth-app-django {
    buildPythonPackage = python.pkgs.buildPythonPackage;
    fetchPypi = python.pkgs.fetchPypi;
    inherit social-auth-core;
  };
in
python.withPackages(ps: with ps; [
  pip
  setuptools
  django
  django-q
  djangorestframework
  django_extensions
  social-auth-app-django
]
)
