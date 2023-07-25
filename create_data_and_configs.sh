i=$1
outdir=$2

bn=$(basename $i)
splitext=$(echo $bn | cut -d "." -f1)
mkdir ${outdir}/$splitext
ln -s $i ${outdir}/$splitext/${bn}
cat <<- EOF > ${outdir}/$splitext/${splitext}.data.config
#### REQUIRED ####
bam: $splitext/${bn}  # path to the alignments file (BAM/CRAM format)
fai: "/home/vsfishman/soft/cue/data/demo/inputs/GRCh38.fa.fai"  # path to the reference FASTA FAI file
#### OPTIONAL ####
logging_level: "INFO"  # verbosity level (set to "ERROR" to reduce logging volume)
EOF
    
cat <<- EOF > ${outdir}/$splitext/${splitext}.model.config
#### REQUIRED ####
model_path: "/home/vsfishman/soft/cue/data/models/cue.v2.pt"  # path to the pretrained Cue model
n_cpus: 28
EOF