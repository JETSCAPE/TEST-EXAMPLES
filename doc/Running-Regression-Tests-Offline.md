# Regression Tests

While the X-Scape regression tests run automatically on certain push and pull request events using GitHub Actions, it might sometimes be useful to run a regression test offline, especially if a test running with GitHub Actions fails.  Running a regression test offline will provide an ability to review the generated files and determine the extent to which reference data does not match new output.

This document shows how to run regression tests offline.

## Prerequisites

It is assumed that you are already able to run JETSCAPE/X-Scape on your local machine or cluster using Docker or Singularity.  Instructions to install and initially run the application are not included here.

## Environment

Included in the TEST-EXAMPLES repository is a folder called [test](https://github.com/JETSCAPE/TEST-EXAMPLES/tree/main/test).

* Following the path [test/PbPb/output/latest/](https://github.com/JETSCAPE/TEST-EXAMPLES/tree/main/test/PbPb/output/latest) brings us to several generated sub-folders that contain reference data for the PbPb test.  This is the data that output from a new run will be checked against.

* Following the path [test/pp/output/latest/](https://github.com/JETSCAPE/TEST-EXAMPLES/tree/main/test/pp/output/latest) brings us to several generated sub-folders that contain reference data for the pp test.  This is the data that output from a new run will be checked against.

* Following the path [test/isr/output/latest/](https://github.com/JETSCAPE/TEST-EXAMPLES/tree/main/test/isr/output/latest) brings us to three files that provide the reference data for the isr tests.  This is the data that output from new isr runs will be checked against.

* The user XML file for the PbPb test is found at [test/PbPb/config/jetscape_user.xml](https://github.com/JETSCAPE/TEST-EXAMPLES/blob/main/test/PbPb/config/jetscape_user.xml), the user XML file for the pp test is found at [test/pp/config/jetscape_user_PP19.xml](https://github.com/JETSCAPE/TEST-EXAMPLES/blob/main/test/pp/config/jetscape_user_PP19.xml), and the user XML file for the isr tests is found at [test/isr/config/jetscape_user_iMATTERMCGlauber.xml](https://github.com/JETSCAPE/TEST-EXAMPLES/blob/main/test/isr/config/jetscape_user_iMATTERMCGlauber.xml)

* The script that runs the pp and PbPb tests is found at [test/runTest.sh](https://github.com/JETSCAPE/TEST-EXAMPLES/blob/main/test/runTest.sh), and the scripts that run the isr tests are found at the following links to the [hadron](https://github.com/JETSCAPE/TEST-EXAMPLES/blob/main/test/isr/runPythiaIsrHadronTest.sh), [parton](https://github.com/JETSCAPE/TEST-EXAMPLES/blob/main/test/isr/runPythiaIsrPartonTest.sh) and [Isr-DAT](https://github.com/JETSCAPE/TEST-EXAMPLES/blob/main/test/isr/runPythiaIsrDatTest.sh) test respectively.

When regression tests are performed automatically using GitHub Actions, the following lines of code from the **.github/workflows/test-events** yaml files in the repository under test will be used to call the various tests and pass in command line arguments.

### For the pp Test
```
${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/runTest.sh -j ${GITHUB_WORKSPACE}/${REPO_NAME} -a ${GITHUB_WORKSPACE}/TEST-EXAMPLES -c ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/pp/config/jetscapeTestConfig.yaml -o ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/pp/output/new -r ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/pp/output/latest
```

### For the PbPb Test
```
${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/runTest.sh -j ${GITHUB_WORKSPACE}/${REPO_NAME} -a ${GITHUB_WORKSPACE}/TEST-EXAMPLES -c ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/PbPb/config/jetscapeTestConfig.yaml -o ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/PbPb/output/new -r ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/PbPb/output/latest
```

### For the Isr Hadron Test
```
${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/isr/runPythiaIsrHadronTest.sh -j ${GITHUB_WORKSPACE}/${REPO_NAME} -a ${GITHUB_WORKSPACE}/TEST-EXAMPLES -c ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/isr/config/jetscape_user_iMATTERMCGlauber.xml -o ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/isr/output/new -r ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/isr/output/latest
```

### For the Isr Parton Test
```
${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/isr/runPythiaIsrPartonTest.sh -j ${GITHUB_WORKSPACE}/${REPO_NAME} -a ${GITHUB_WORKSPACE}/TEST-EXAMPLES -c ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/isr/config/jetscape_user_iMATTERMCGlauber.xml -o ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/isr/output/new -r ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/isr/output/latest
```

### For the Isr Dat File Test
```
${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/isr/runPythiaIsrDatTest.sh -j ${GITHUB_WORKSPACE}/${REPO_NAME} -a ${GITHUB_WORKSPACE}/TEST-EXAMPLES -c ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/isr/config/jetscape_user_iMATTERMCGlauber.xml -o ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/isr/output/new -r ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/isr/output/latest
```
## Steps to Run the Tests Offline

Running these regression tests offline basically involves executing the above lines to run each respective test.

First create the environment variables **GITHUB_WORKSPACE** and **REPO_NAME** on your local system or cluster using the following commands:

```
export REPO_NAME="X-SCAPE-COMP"
export GITHUB_WORKSPACE="/home/jetscape-user"
```
The values given to these environment variables can be adjusted depending upon the repository name and path corresponding to your installation.

Then ensure that this TEST-EXAMPLES repository is cloned to your local system or cluster:

```
cd $GITHUB_WORKSPACE
git clone https://github.com/JETSCAPE/TEST-EXAMPLES.git
```

Next, enter these commands (separately) to run each respective test.

### For the pp Test
```
${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/runTest.sh -j ${GITHUB_WORKSPACE}/${REPO_NAME} -a ${GITHUB_WORKSPACE}/TEST-EXAMPLES -c ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/pp/config/jetscapeTestConfig.yaml -o ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/pp/output/new -r ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/pp/output/latest
```

### For the PbPb Test
```
${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/runTest.sh -j ${GITHUB_WORKSPACE}/${REPO_NAME} -a ${GITHUB_WORKSPACE}/TEST-EXAMPLES -c ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/PbPb/config/jetscapeTestConfig.yaml -o ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/PbPb/output/new -r ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/PbPb/output/latest
```

### For the Isr Hadron Test
```
${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/isr/runPythiaIsrHadronTest.sh -j ${GITHUB_WORKSPACE}/${REPO_NAME} -a ${GITHUB_WORKSPACE}/TEST-EXAMPLES -c ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/isr/config/jetscape_user_iMATTERMCGlauber.xml -o ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/isr/output/new -r ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/isr/output/latest
```

### For the Isr Parton Test
```
${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/isr/runPythiaIsrPartonTest.sh -j ${GITHUB_WORKSPACE}/${REPO_NAME} -a ${GITHUB_WORKSPACE}/TEST-EXAMPLES -c ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/isr/config/jetscape_user_iMATTERMCGlauber.xml -o ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/isr/output/new -r ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/isr/output/latest
```

### For the Isr Dat File Test
```
${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/isr/runPythiaIsrDatTest.sh -j ${GITHUB_WORKSPACE}/${REPO_NAME} -a ${GITHUB_WORKSPACE}/TEST-EXAMPLES -c ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/isr/config/jetscape_user_iMATTERMCGlauber.xml -o ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/isr/output/new -r ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/isr/output/latest
```

The tests will generate new folders including new files at **test/PbPb/output/new/** for the PbPb test, at **test/pp/output/new/** for the pp test, and at **test/isr/output/new/** for the isr tests.  Terminal output will state whether a test passes or fails.

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
