#!/usr/bin/zsh

source 0-source-me.zsh
setopt noglob

SUNMAP=$DIR/wmaps/english.unmap

GRAMA=$DIR/rules/test30/A/
GRAMB=$DIR/rules/test30/B/

# Translate the 30 sentences with each grammar and score the output translations against their
# English reference translation. Which grammar obtains the better BLEU score? Which of the
# two runs was faster? Did you post-process the hypotheses - why or why not?

## Grammar A
#hifst $DIR/configs/basic+params.features \
#  --textinput=$DIR/input/test30.spa.idx \
#  --rulefile=$GRAMA/r.?.gz \
#  --lm=$DIR/lm/test30.news-newscomm.eng.4g/G/?.G.gz --lmn=4 \
#  --range=1:30 \
#  --latoutputfst=output/example/LATS.A/?.fst.gz

## Write the 1-best translations from all lattices to a single file outA :
#printstrings --r=1:30 --input=output/example/LATS.A/?.fst.gz \
#  --output=outA --label-map=$SUNMAP

## Grammar B
#hifst $DIR/configs/basic+params.features \
#  --textinput=$DIR/input/test30.spa.idx \
#  --rulefile=$GRAMB/r.?.gz \
#  --lm=$DIR/lm/test30.news-newscomm.eng.4g/G/?.G.gz --lmn=4 \
#  --range=1:30 \
#  --latoutputfst=output/example/LATS.B/?.fst.gz

## Write the 1-best translations from all lattices to a single file outB :
#printstrings --r=1:30 --input=output/example/LATS.B/?.fst.gz \
#  --output=outB --label-map=$SUNMAP

## Post-process hypotheses: string <s> and </s> tags
#cat outA | sed 's/<s> //g' | sed 's/ <\/s>//g' > outA
#cat outB | sed 's/<s> //g' | sed 's/ <\/s>//g' > outB


#print "Scoring grammar A:"
#ScoreBLEU.sh \
#  -t outA \
#  -r $DIR/reference/test30.eng
# BLEU score = 0.4778
# faster

#print "Scoring grammar B:"
#ScoreBLEU.sh \
#  -t outB \
#  -r $DIR/reference/test30.eng
# BLEU score = 0.5265
# slower


# According to sentence-level BLEU scores, is every translated sentence better with grammar B
# than with A?
#for i in {1..30}; do
#  printstrings --r=$i:$i --input=output/example/LATS.A/?.fst.gz 2>/dev/null \
#    | sed 's/<s> //g' | sed 's/ <\/s>//g' \
#    > tmp
#  scoreA=$(ScoreBLEU.sh \
#    -t tmp \
#    -r $DIR/reference/test30/r.$i.eng.idx \
#    | cut -d ' ' -f 4)

#  printstrings --r=$i:$i --input=output/example/LATS.B/?.fst.gz 2>/dev/null \
#    | sed 's/<s> //g' | sed 's/ <\/s>//g' \
#    > tmp
#  scoreB=$(ScoreBLEU.sh \
#    -t tmp \
#    -r $DIR/reference/test30/r.$i.eng.idx \
#    | cut -d ' ' -f 4)
#  rm tmp

#  print "$i,$scoreA,$scoreB"
#done
# 1,1.0000,1.0000
# 2,0.2126,0.2163
# 3,0.1548,0.1579
# 4,0.0994,0.0994
# 5,0.3575,0.6865
# 6,0.2677,0.2677
# 7,0.2878,0.7277
# 8,0.6695,0.6695
# 9,0.4694,0.5405
# 10,0.8154,0.8154
# 11,0.2555,0.2623
# 12,0.2131,0.2131
# 13,0.8579,0.8606
# 14,1.0000,1.0000
# 15,0.4845,0.5428
# 16,0.6741,0.7268
# 17,0.2641,0.2641
# 18,0.2923,0.2923
# 19,0.8215,0.8215
# 20,0.7825,0.7825
# 21,0.5787,0.6901
# 22,0.8465,0.8465
# 23,1.0000,1.0000
# 24,0.8496,0.8496
# 25,0.2024,0.5933
# 26,1.0000,1.0000
# 27,0.2510,0.3493
# 28,0.0665,0.0665
# 29,0.0780,0.0768
# 30,0.3597,0.3475


# (a) Examine two sentences where you obtain a significantly better score with rulefile B, show-
# ing the input sentence, the English reference and the two alternative translations. Do you
# think the sentence-level BLEU score reflects a true improvement in translation quality?
# Show 5 examples of clear improvement in the produced English hypothesis.
# Sentences 5 and 27

# (b) Repeat the previous question with a sentence that gets lower score with rulefile B. Does
# the BLEU score reflect a true degradation in translation quality? Why do you think it is
# worse?
# Sentence 30

# Compare rulefiles A and B for sentence 27. What are the main differences you observe? Pay
# special attention to the nonterminals used in the various columns. How do these differences in
# the rulefiles explain the differences in the produced translation?
#print "Rules for 27 A:"
#cat $DIR/rules/test30/A/r.27.gz | gunzip

#print "Rules for 27 B:"
#cat $DIR/rules/test30/B/r.27.gz | gunzip

# Give further support to your previous answer by drawing the 1-best derivation tree for sentence
# 27 when translated by each ruleset. Which rule sequence is used in each case?
#printstrings -n 1 -u --input=output/example/LATS.A/27.fst.gz --output=27.A.dvn1
#cat 27.A.dvn1
#draw_tree.sh 27.A.dvn1 $DIR/rules/test30/A/r.27.gz output/tree.27.A.dvn1.jpg
#cat output/tree.27.A.dvn1.jpg.rules

#printstrings -n 1 -u --input=output/example/LATS.B/27.fst.gz --output=27.B.dvn1
#cat 27.B.dvn1
#draw_tree.sh 27.B.dvn1 $DIR/rules/test30/B/r.27.gz output/tree.27.B.dvn1.jpg
#cat output/tree.27.B.dvn1.jpg.rules


# Now align the 30 sentences towards their respective English reference. In order to do that, you
# will need to retranslate the input using the --towardsreference option. This forces the
# translation system to produce all possible derivations that can generate each English reference
# for each sentence2
# hifst $DIR/configs/basic+params.features \
#   --textinput=$DIR/input/test30.spa.idx \
#   --rulefile=$GRAMA/r.?.gz \
#   --lm=$DIR/lm/test30.news-newscomm.eng.4g/G/?.G.gz --lmn=4 \
#   --range=1:30 \
#   --latoutputfst=output/example/LATS.A.towards_ref/?.fst.gz \
#   --towardsreference=$DIR/reference/test30/r.?.eng.idx
#hifst $DIR/configs/basic+params.features \
#  --textinput=$DIR/input/test30.spa.idx \
#  --rulefile=$GRAMB/r.?.gz \
#  --lm=$DIR/lm/test30.news-newscomm.eng.4g/G/?.G.gz --lmn=4 \
#  --range=1:30 \
#  --latoutputfst=output/example/LATS.B.towards_ref/?.fst.gz \
#  --towardsreference=$DIR/reference/test30/r.?.eng.idx

# By examining the resulting output transducers, determine for how many
# input sentences can the reference be generated? Compare this for grammar A and B
#integer Acnt=0
#integer Bcnt=0
#for i in {1..30}; do
#  integer numA=$(printstrings -n 500000 -u -w --input=output/example/LATS.A.towards_ref/$i.fst.gz \
#    2>/dev/null \
#    | wc -l)
#  integer numB=$(printstrings -n 500000 -u -w --input=output/example/LATS.B.towards_ref/$i.fst.gz \
#    2>/dev/null \
#    | wc -l)
#  print "$i, $numA, $numB"
#  Acnt+=numA
#  Bcnt+=numB
#done
#print "Acnt: $Acnt, Bcnt: $Bcnt"
# 1, 4, 8
# 2, 1, 1
# 3, 1, 1
# 4, 1, 1
# 5, 1, 165
# 6, 1, 1
# 7, 1, 8586
# 8, 1, 1
# 9, 1, 1
# 10, 48, 122
# 11, 1, 1
# 12, 1, 84
# 13, 11070, 51692
# 14, 47, 83
# 15, 1, 1
# 16, 1, 1
# 17, 1, 1
# 18, 1, 1
# 19, 1, 1
# 20, 52, 166
# 21, 1, 1
# 22, 500000, 500000
# 23, 2586, 14030
# 24, 1, 1
# 25, 1, 282
# 26, 270, 658
# 27, 1, 1
# 28, 1, 1
# 29, 1, 1
# 30, 1, 1
# Acnt: 514099, Bcnt: 575894


