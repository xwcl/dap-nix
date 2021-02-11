{ lib, buildPythonPackage, fetchPypi, python3, pyjwt }:
buildPythonPackage rec {
  pname = "social-auth-core";
  version = "4.0.3";

  src = fetchPypi {
    inherit pname version;
    sha256 = "694eb355825cd72d3346afb816dd899493be1a8ee7405945d2e989cabed10cf2";
  };
  doCheck = false;
  propagatedBuildInputs = [ pyjwt ] ++ (with python3.pkgs; [
    requests
    oauthlib
    requests_oauthlib
    cryptography
    defusedxml
    python3-openid
  ]);
  meta = {
    homepage = https://github.com/python-social-auth/social-core;
    description = "Python Social Auth is an easy to setup social authentication/registration mechanism with support for several frameworks and auth providers.";
    license = lib.licenses.bsd3;
  };
}
