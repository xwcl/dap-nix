{ pkgs, ... }:
let
  social-auth-app-django = callPackage ../pypi-pkgs/social-auth-app-django;
in
(pkgs.python38.buildEnv.override {
  extraLibs = with python38.pkgs; [
    django
    django-q
    djangorestframework
    django_extensions
    social-auth-app-django
  ];
}).env
