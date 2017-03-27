# fuel-ui-tests-docker

This repository contains configs for docker-compose to run [Fuel UI](https://github.com/openstack/fuel-ui/blob/stable/mitaka/README.rst) tests in docker.

**Branches:**

* `stable/mitaka` - to run UI tests on real Fuel 9.x (requires [fuel-ui](https://github.com/openstack/fuel-ui/tree/stable/mitaka) repo to be downloaded, and prepared Fuel master node with several slaves)
* `stable/newton` - to run UI tests on real Fuel 10.x (requires [fuel-ui](https://github.com/openstack/fuel-ui/tree/stable/newton) repo to be downloaded, and prepared Fuel master node with several slaves)
* `stable/newton-fake` - to run UI tests on fake Fuel 10.x (requires [fuel-ui](https://github.com/openstack/fuel-ui/tree/stable/newton) and [fuel-web](https://github.com/openstack/fuel-web/tree/stable/newton) repos to be downloaded)


**How to run**

For real Fuel:
  1. Download `fuel-ui` repo
  2. Prepare Fuel master and slaves
  3. Export variables to redefine ones in `.env` (optional)
  4. Run `docker-compose up`
  
For fake Fuel:
  1. Download `fuel-ui` and `fuel-web` repos
  2. Export variables to redefine ones in `.env` (optional)
  3. Run `docker-compose up`
