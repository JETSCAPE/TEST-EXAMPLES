While the X-Scape regression tests run automatically on certain push and pull request events using GitHub Actions, it might sometimes be useful to run a regression test offline, especially if a test running with GitHub Actions fails.  Running a regression test offline will provide an ability to review the generated files and determine the extent to which reference data does not match new output.

This document shows how to run regression tests offline.

## Prerequisites

It is assumed that you are already able to run JETSCAPE/X-Scape on your local machine or cluster using Docker or Singularity.  Instructions to install and initially run the application are not included here.

## Environment

Included in the TEST-EXAMPLES repository is a folder called [test](https://github.com/JETSCAPE/TEST-EXAMPLES/tree/main/test).

* Following the path [test/PbPb/output/latest/](https://github.com/JETSCAPE/TEST-EXAMPLES/tree/main/test/PbPb/output/latest) brings us to several generated sub-folders that contain reference data for the PbPb test.  This is the data that output from a new run will be checked against.

* Following the path [test/pp/output/latest/](https://github.com/JETSCAPE/TEST-EXAMPLES/tree/main/test/pp/output/latest) brings us to several generated sub-folders that contain reference data for the pp test.  This is the data that output from a new run will be checked against.

* The user XML file for the PbPb test is found at [test/PbPb/config/jetscape_user.xml](https://github.com/JETSCAPE/TEST-EXAMPLES/blob/main/test/PbPb/config/jetscape_user.xml) and the user XML file for the pp test is found at [test/pp/config/jetscape_user_PP19.xml](https://github.com/JETSCAPE/TEST-EXAMPLES/blob/main/test/pp/config/jetscape_user_PP19.xml).

* The script that runs a given test is found at [test/runTest.sh](https://github.com/JETSCAPE/TEST-EXAMPLES/blob/main/test/runTest.sh).

When regression tests are performed automatically using GitHub Actions, the following lines of code from the **.github/workflows/test-events** yaml files in the repository under test will be used to call [test/runTest.sh](https://github.com/JETSCAPE/TEST-EXAMPLES/blob/main/test/runTest.sh) and pass in command line arguments.

### For the pp Test
```
${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/runTest.sh -j ${GITHUB_WORKSPACE}/${REPO_NAME} -a ${GITHUB_WORKSPACE}/TEST-EXAMPLES -c ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/pp/config/jetscapeTestConfig.yaml -o ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/pp/output/new -r ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/pp/output/latest

```

### For the PbPb Test
```
${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/runTest.sh -j ${GITHUB_WORKSPACE}/${REPO_NAME} -a ${GITHUB_WORKSPACE}/TEST-EXAMPLES -c ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/PbPb/config/jetscapeTestConfig.yaml -o ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/PbPb/output/new -r ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/PbPb/output/latest
```

## Steps to Run the Tests Offline

Running these regression tests offline basically involves executing the above lines to run each respective test.

First create the environment variables **GITHUB_WORKSPACE** and **REPO_NAME** on your local system or cluster using the following commands:

```
export REPO_NAME="X-SCAPE-COMP"
export GITHUB_WORKSPACE="/home/jetscape-user"   
```
The values given to these environment variables can be adjusted depending upon the repository name and path corresponding to your installation.

Next, enter these commands (separately) to run each respective test.

### For the pp Test
```
${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/runTest.sh -j ${GITHUB_WORKSPACE}/${REPO_NAME} -a ${GITHUB_WORKSPACE}/TEST-EXAMPLES -c ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/pp/config/jetscapeTestConfig.yaml -o ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/pp/output/new -r ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/pp/output/latest
```

### For the PbPb Test
```
${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/runTest.sh -j ${GITHUB_WORKSPACE}/${REPO_NAME} -a ${GITHUB_WORKSPACE}/TEST-EXAMPLES -c ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/PbPb/config/jetscapeTestConfig.yaml -o ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/PbPb/output/new -r ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/PbPb/output/latest
```

The tests will generate new folders including new files at **test/PbPb/output/new/** for the PbPb test and at **test/pp/output/new/** for the pp test.  Terminal output will state whether a test passes or fails.

Partial terminal output is shown here as an example:
```
    Generating 1_seed11_eCM5020_deltaT0.01_vir_factor0.5_namecolorless
    Generating 1_seed11_eCM5020_deltaT0.01_vir_factor0.5_namecolored
    Generating 1_seed11_eCM5020_deltaT0.1_vir_factor0.25_namecolorless
    Generating 1_seed11_eCM5020_deltaT0.1_vir_factor0.25_namecolored
    Generating 1_seed11_eCM5020_deltaT0.1_vir_factor0.5_namecolorless
    Generating 1_seed11_eCM5020_deltaT0.1_vir_factor0.5_namecolored

Comparing tests in /home/jetscape-user/X-SCAPE-COMP/test/pp/output/new to Reference in /home/jetscape-user/X-SCAPE-COMP/test/pp/output/latest ...

All 64 tests passed! :)
```

If a test fails, terminal output will state where a mismatch is first detected.

Partial terminal output is shown here as an example:
```
    Generating 1_seed11_eCM5020_deltaT0.01_vir_factor0.5_namecolorless
    Generating 1_seed11_eCM5020_deltaT0.01_vir_factor0.5_namecolored
    Generating 1_seed11_eCM5020_deltaT0.1_vir_factor0.25_namecolorless
    Generating 1_seed11_eCM5020_deltaT0.1_vir_factor0.25_namecolored
    Generating 1_seed11_eCM5020_deltaT0.1_vir_factor0.5_namecolorless
    Generating 1_seed11_eCM5020_deltaT0.1_vir_factor0.5_namecolored

Comparing tests in /home/jetscape-user/X-SCAPE-COMP/test/pp/output/new to Reference in /home/jetscape-user/X-SCAPE-COMP/test/pp/output/latest ...

Error: Check whether you have used the same YAML config for the Test and the Reference
New file: /home/jetscape-user/X-SCAPE-COMP/test/pp/output/new/0_seed10_eCM200_deltaT0.01_vir_factor0.25_namecolored//test_out.hepmc
Reference file: /home/jetscape-user/X-SCAPE-COMP/test/pp/output/latest/0_seed10_eCM200_deltaT0.01_vir_factor0.25_namecolored/test_out.hepmc
```

To rerun a test, be sure to remove or rename its generated **/new/** folder.
