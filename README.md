# TEST-EXAMPLES

This repository hosts automated tests and examples for use with JETSCAPE and X-SCAPE.

## Instructions
[Running-Regression-Tests-Offline](https://github.com/JETSCAPE/TEST-EXAMPLES/blob/main/doc/Running-Regression-Tests-Offline.md)

[Running-Plot-Observables-Offline](https://github.com/JETSCAPE/TEST-EXAMPLES/blob/main/doc/Running-Plot-Observables-Offline.md)

Reference the main branch when working with the JETSCAPE and X-SCAPE dependencies provided in the docker container **jetscape/base:v1.8**.  Reference the legacy branch when working with dependencies provided in earlier containers such as **jetscape/base:v1.7**.

## Accepting an Error Threshold for Passing Regression Tests

The Similarity branch provides an additional ability to specify an error threshold for passing the regression tests.  If the difference between compared values is below the specified threshold, the tests will still pass.

The file [test/similarity.py](https://github.com/JETSCAPE/TEST-EXAMPLES/blob/similarity/test/similarity.py) defines the variable **<span style="color:red">err = .0001</span>**.  Set this value to your desired error threshold before running the regression tests.

```
# threshold for an acceptable floating point variation
err = .01
```
