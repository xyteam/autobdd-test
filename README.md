# autobdd-test
autobdd-test project has 2 purposes:
1. smoke test and demo the automagic power of xyteam/autobdd test framework;
2. serve as an template for setting up a new autobdd test project.

#### requirement:
docker host or docker desktop

#### end-to-end test and report:
##### e2e test
```
docker-compose run --rm autobdd-test-run "make e2e-autorunner"
```
##### review e2e test report
use browser to open test-results/build-test/index.html
or
lauch a http server:
```
cd test-results
python -m http.server
```
then open browser to http://host-ip:8000
to review the report

#### performance test
###### k6 performance test
```
docker-compose run --rm autobdd-test-run "make k6-test"
```
#### unit test
###### js unit test
```
docker-compose run --rm autobdd-test-run "make js-test"
```
###### cypress unit test
```
docker-compose run --rm autobdd-test-run "make cy-test"
```
###### python3 unit test
```
docker-compose run --rm autobdd-test-run "make py3-test"
```
###### python2 unit test
```
docker-compose run --rm autobdd-test-run "make py2-test"
```
