{ lib, buildPythonPackage, fetchPypi, social-auth-core }:
buildPythonPackage rec {
  pname = "social-auth-app-django";
  version = "4.0.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "2c69e57df0b30c9c1823519c5f1992cbe4f3f98fdc7d95c840e091a752708840";
  };
  doCheck = false;
  propagatedBuildInputs = [ social-auth-core ];
  meta = {
    homepage = https://github.com/python-social-auth/social-app-django;
    description = "Django support for Python Social Auth. Python Social Auth is an easy to setup social authentication/registration mechanism with support for several frameworks and auth providers.";
    license = lib.licenses.bsd3;
  };
}
