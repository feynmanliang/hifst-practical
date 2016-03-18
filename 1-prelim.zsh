#!/usr/bin/zsh

source 0-source-me.zsh

setopt noglob

##
# Ex 2
##

# For a preliminary test, run the following command, which translates sentence
# 14 from the test file:
hifst $DIR/configs/basic+params.features \
  --textinput=$DIR/input/test30.spa.idx \
  --rulefile=$DIR/rules/test30/B/r.?.gz \
  --lm=$DIR/lm/test30.news-newscomm.eng.4g/G/?.G.gz --lmn=4 \
  --range=14:14 \
  --latoutputfst=output/example/LATS/?.fst.gz

# Run the following command to check that the 1-best translation has a cost of 33.7 and is:
SUNMAP=$DIR/wmaps/english.unmap
printstrings --input=output/example/LATS/14.fst.gz --label-map=$SUNMAP -w 2> /dev/null

# How many alternative translations are generated?
# How many translation candidates candidates, including repeated?
printstrings --input=output/example/LATS/14.fst.gz --label-map=$SUNMAP -w -n 1000 2>/dev/null | wc -l
# 797

##
# Ex 3
##

# For example, let us find the derivations that lead to the 1-best candidate from before.
#printstrings --input=output/example/LATS/14.fst.gz -n 1 -u --output=example.hyp1.eng
#cat example.hyp1.eng
#
#hifst $DIR/configs/basic+params.features \
#  --textinput=$DIR/input/test30.spa.idx \
#  --rulefile=$DIR/rules/test30/B/r.?.gz \
#  --lm=$DIR/lm/test30.news-newscomm.eng.4g/G/?.G.gz --lmn=4 \
#  --range=14:14 \
#  --latoutputfst=output/example/LATS.hyp1/?.fst.gz \
#  --towardsreference=example.hyp1.eng
#
## The output of the system is now a transducer, and we can print the input or output strings with
## usual FST commands:
#printstrings -n 1 -u -w --input=output/example/LATS.hyp1/14.fst.gz
## returns the 1-best derivation (sequence of rules) that produces any of the references contained in
## example.hyp1.eng. Rules are mapped to numbers corresponding to the line number in the input
## rulefile where each rule is (see $DIR/rules/test30/B/r.14.gz).
#
## The 1-best English translation found (in integer-mapped form), which should correspond to the
## contents of example.hyp1.eng:
#printstrings -n 1 -u -w --input=output/example/LATS.hyp1/14.fst.gz \
#  --print-output-labels 2> /dev/null
#
###
## Ex 3
###
#
## Drawing derivation tree
#printstrings -n 1 -u --input=output/example/LATS.hyp1/14.fst.gz --output=example.dvn1
#cat example.dvn1
#
#draw_tree.sh example.dvn1 $DIR/rules/test30/B/r.14.gz output/tree14dvn1.jpg
#
#cat output/tree14dvn1.jpg.rules
