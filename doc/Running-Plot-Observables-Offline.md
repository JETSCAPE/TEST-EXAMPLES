# Plot Observables

While the plot observables test runs automatically on certain push events using GitHub Actions, it might sometimes be useful to run the plot observables test offline.  GitHub Actions limits wall-time to 3 hours, so in the interest of supporting longer runs with more events, an offline option is available.

This document shows how to run the plot observables test offline.

## Prerequisites

It is assumed that you are already able to run JETSCAPE/X-Scape on your local machine or cluster using Docker or Singularity.  Instructions to install and initially run the application are not included here.

## Environment

Included in the TEST-EXAMPLES repository is a folder called [test](https://github.com/JETSCAPE/TEST-EXAMPLES/tree/main/test).

* Following the path [test/plot/output/latest/](https://github.com/JETSCAPE/TEST-EXAMPLES/tree/main/test/plot/output/latest) brings us to an archive file called **test_out_histograms.root**.  This archive contains the reference data from a previous validated run alongside which the data from a new run will be plotted.

* The user XML file for the plot observables test is found at [test/pp/config/jetscape_user_PP19_weighted.xml](https://github.com/JETSCAPE/TEST-EXAMPLES/blob/main/test/pp/config/jetscape_user_PP19_weighted.xml).

* The script that runs the given plot observables test is found at [test/generate_plots.sh](https://github.com/JETSCAPE/TEST-EXAMPLES/blob/main/test/generate_plots.sh).

When the plot observables test is performed automatically using GitHub Actions, the following lines of code from the **.github/workflows/plot_observables** yaml file are used to prepare and call [test/generate_plots.sh](https://github.com/JETSCAPE/TEST-EXAMPLES/blob/main/test/generate_plots.sh) and pass in command line arguments.

### To Generate the pp Events
```
${GITHUB_WORKSPACE}/${REPO_NAME}/build/runJetscape ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/pp/config/jetscape_user_PP19_weighted.xml ${GITHUB_WORKSPACE}/${REPO_NAME}/config/jetscape_main.xml
```

### To Call the generate_plots.sh Script
```
${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/generate_plots.sh -j ${GITHUB_WORKSPACE}/${REPO_NAME} -a ${GITHUB_WORKSPACE}/TEST-EXAMPLES -o ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/plot/output/new
```

## Steps to Run the Plot Observables Test Offline

Running the plot observables test offline basically involves executing the above lines to generate pp events and calling the [test/generate_plots.sh](https://github.com/JETSCAPE/TEST-EXAMPLES/blob/main/test/generate_plots.sh) script to create the plots.

First create the environment variables **GITHUB_WORKSPACE**, **REPO_NAME**, and **PULL_NUMBER** on your local system or cluster using the following commands:

```
export REPO_NAME="X-SCAPE-COMP"
export GITHUB_WORKSPACE="/home/jetscape-user"
export PULL_NUMBER=1234
```
The values given to these environment variables can be adjusted depending upon the repository name and path corresponding to your installation.  The **PULL_NUMBER** variable can be set to any value.  GitHub Actions uses this variable to label the generated output files with the current pull request number.  When running the test offline, this can be set to any number.

Next, navigate to your **build** folder and generate the pp events.
```
cd ${GITHUB_WORKSPACE}/${REPO_NAME}/build

${GITHUB_WORKSPACE}/${REPO_NAME}/build/runJetscape ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/pp/config/jetscape_user_PP19_weighted.xml ${GITHUB_WORKSPACE}/${REPO_NAME}/config/jetscape_main.xml
```

Then use the following command to call the [test/generate_plots.sh](https://github.com/JETSCAPE/TEST-EXAMPLES/blob/main/test/generate_plots.sh) script.
```
${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/generate_plots.sh -j ${GITHUB_WORKSPACE}/${REPO_NAME} -a ${GITHUB_WORKSPACE}/TEST-EXAMPLES -o ${GITHUB_WORKSPACE}/TEST-EXAMPLES/test/plot/output/new
```

The test will generate a **/new/** folder containing several files at **test/plot/output/new/**. Among these  files will be several **.png** images, a **test_out_histograms.root** file, and a **results.pptx** PowerPoint file.  The PowerPoint file can be useful to quickly browse the generated plots, and if one would like to use the results from the current test as reference data for a subsequent test, replace the old **test/plot/output/latest/test_out_histograms.root** file with the **test_out_histograms.root** file generated in the **/new/** folder.

Note that the plot observables test is not a test that automatically passes or fails.  Rather, the test generates plots to compare a current run with a previous validated run and requires a manual analysis of the plots.

To rerun the test, be sure to remove or rename the **/new/** folder as well as any data files generated in the **/build/** folder such as **test_out_final_state_hadrons.dat** or **test_out_final_state_partons.dat**.
