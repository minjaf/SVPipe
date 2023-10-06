# create data and cue config for new cram files
# execute from results dir
cram_folder="/home/venus/lago/vfishman/2023Aug14_copy/";\
results_folder="/home/venus/lago/vfishman/results";\
for i in {124..127}; do \
    [ ! -d "${results_folder}/i$i/" ] && mkdir -p ${results_folder}/i$i/; \
    for j in ${cram_folder}/${i}*.cram; \
        do bash create_data_and_configs.sh $j ${results_folder}/i$i/; \
    done;\
done;

# run cue for a subset of folders on Brazil server
# execute from results dir
for i in {124..127}; do cd i$i; bash ~/soft/SVPipe/run_cue.sh .; cd ..; done

# run delly_sv for a subset of folders on Brazil server
# execute from results dir
/home/venus/lago/vfishman/results$ for i in {4..9}; do bash ~/soft/SVPipe/run_delly_sv.sh ~/projects/1000gSVs/results/i10${i}/ ~/projects/1000gSVs/results/i10${i}; done

# run cue for set of folders on CPU
cram_folder="/mnt/10tb/home/vsfishman/genomes/crams/";\
results_folder="/mnt/10tb/home/vsfishman/genomes/process/";\
for i in {117..124}; do \
    [ ! -d "${results_folder}/i$i/" ] && mkdir -p ${results_folder}/i$i/; \
    for j in ${cram_folder}/${i}*.cram; \
        do bash create_data_and_configs.sh $j ${results_folder}/i$i/; \
    done;\
done;
