#! /bin/bash

JETSCAPE="/home/jetscape-user/JETSCAPE"
JETSCAPE_ANALYSIS="/home/jetscape-user/TEST-EXAMPLES"
ANALYSIS_CONFIG="${JETSCAPE_ANALYSIS}/test/brick_rMatter_lbt/config/jetscape_user_rMatterLbt.xml"
OUTPUT_DIR="${JETSCAPE_ANALYSIS}/test/brick_rMatter_lbt/output/new"
REFERENCE_DIR="${JETSCAPE_ANALYSIS}/test/brick_rMatter_lbt/output/latest"

#  Parse command line options
POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -j)
    JETSCAPE="$2"
    shift # remove argument
    shift # remove value
    ;;
    -a)
    JETSCAPE_ANALYSIS="$2"
    shift # remove argument
    shift # remove value
    ;;
    -c)
    ANALYSIS_CONFIG="$2"
    shift
    shift
    ;;
    -o)
    OUTPUT_DIR="$2"
    shift
    shift
    ;;
    -r)
    REFERENCE_DIR="$2"
    shift
    shift
    ;;
esac
done

echo ""
echo "Running brick_rMatter_lbt file Tests..."
echo ""

cd ${JETSCAPE}/build
./runJetscape ${ANALYSIS_CONFIG}

echo ""
echo "Comparing tests in $OUTPUT_DIR to Reference in $REFERENCE_DIR ..."
echo ""

if [ ! -d $OUTPUT_DIR ]
then
  mkdir -p $OUTPUT_DIR
fi

mv test_brick_rMatter_lbt.dat $OUTPUT_DIR
mv test_brick_rMatter_lbt.hepmc $OUTPUT_DIR

echo ""
echo "------------------------------------------"
echo ""

echo "start of test_brick_rMatter_lbt.dat file..."
head $OUTPUT_DIR/test_brick_rMatter_lbt.dat
echo ""
echo "start of reference test_brick_rMatter_lbt.dat file..."
head $REFERENCE_DIR/test_brick_rMatter_lbt.dat

echo ""
echo "start of test_brick_rMatter_lbt.hepmc file..."
head $OUTPUT_DIR/test_brick_rMatter_lbt.hepmc
echo ""
echo "start of reference test_brick_rMatter_lbt.hepmc file..."
head $REFERENCE_DIR/test_brick_rMatter_lbt.hepmc

echo ""
echo "------------------------------------------"
echo ""

echo "Comparing test_brick_rMatter_lbt.dat files..."
diff $OUTPUT_DIR/test_brick_rMatter_lbt.dat $REFERENCE_DIR/test_brick_rMatter_lbt.dat
if [ $? -ne 0 ]
then
  echo "Error: Check whether you have used the same YAML config for the Test and the Reference"
  echo "New file: $OUTPUT_DIR/test_brick_rMatter_lbt.dat"
  echo "Reference file: $REFERENCE_DIR/test_brick_rMatter_lbt.dat"
  exit 1
fi

echo ""
echo "Comparing test_brick_rMatter_lbt.hepmc files..."
diff $OUTPUT_DIR/test_brick_rMatter_lbt.hepmc $REFERENCE_DIR/test_brick_rMatter_lbt.hepmc
if [ $? -ne 0 ]
then
  echo "Error: Check whether you have used the same YAML config for the Test and the Reference"
  echo "New file: $OUTPUT_DIR/test_brick_rMatter_lbt.hepmc"
  echo "Reference file: $REFERENCE_DIR/test_brick_rMatter_lbt.hepmc"
  exit 1
fi

echo ""
echo "------------------------------------------"
echo ""
echo "brick_rMatter_lbt file Tests Passed!"
echo ""
