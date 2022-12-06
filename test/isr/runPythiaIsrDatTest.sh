#! /bin/bash

JETSCAPE="/home/jetscape-user/JETSCAPE"
JETSCAPE_ANALYSIS="/home/jetscape-user/TEST-EXAMPLES"
ANALYSIS_CONFIG="${JETSCAPE_ANALYSIS}/test/isr/config/jetscape_user_PP19.xml"
OUTPUT_DIR="${JETSCAPE_ANALYSIS}/test/isr/output/new"
REFERENCE_DIR="${JETSCAPE_ANALYSIS}/test/isr/output/latest"

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
echo "Running Pythia ISR .dat file Tests..."
echo ""

cd ${JETSCAPE}/build
./PythiaIsrTest ${ANALYSIS_CONFIG}

echo ""
echo "Comparing tests in $OUTPUT_DIR to Reference in $REFERENCE_DIR ..."
echo ""

if [ ! -d $OUTPUT_DIR ]
then
  mkdir -p $OUTPUT_DIR
fi

mv test_out_final_state_hadrons.dat $OUTPUT_DIR
mv test_out_final_state_partons.dat $OUTPUT_DIR
mv test_out_isr.dat $OUTPUT_DIR

echo "start of new isr.dat file..."
head $OUTPUT_DIR/test_out_isr.dat
echo "start of reference isr.dat file..."
head $REFERENCE_DIR/test_out_isr.dat

N=0
N_PASSED_ISR=0
cd $PREFIX/$OUTPUT_DIR
for dir in */ ; do
  N=$((N+1))

  DIFF_ISR=$(diff $OUTPUT_DIR/test_out_isr.dat $REFERENCE_DIR/test_out_isr.dat)
  if [ $? -ne 0 ]
  then
    echo "Error: Check whether you have used the same YAML config for the Test and the Reference"
    echo "New file: $OUTPUT_DIR/test_out_isr.dat"
    echo "Reference file: $REFERENCE_DIR/test_out_isr.dat"
    exit 1
  fi

  if [ "${DIFF_ISR}" == "" ]
  then
    N_PASSED_ISR=$((${N_PASSED_ISR}+1))
  else
    echo "Test failed for ISR"
  fi
    
done

N_FAILED_ISR=$(($N-$N_PASSED_ISR))
if [[ $N_FAILED_ISR -eq 0 ]];
then
  echo "All $N tests passed! :)"
else
  echo ""
  echo "Tests FAILED :("
  echo "$N_FAILED_ISR/$N tests FAILED for ISR"
  exit 1
fi
echo ""
